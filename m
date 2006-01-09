Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750883AbWAICu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbWAICu7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 21:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750911AbWAICu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 21:50:59 -0500
Received: from smtp104.sbc.mail.re2.yahoo.com ([68.142.229.101]:16270 "HELO
	smtp104.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750910AbWAICu5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 21:50:57 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: Re: [PATCH 4/8] RTC subsystem, proc interface
Date: Sun, 8 Jan 2006 21:50:55 -0500
User-Agent: KMail/1.8.3
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-kernel@vger.kernel.org
References: <20060108231235.153748000@linux> <200601082056.30227.dtor_core@ameritech.net> <20060109030433.581c49e7@inspiron>
In-Reply-To: <20060109030433.581c49e7@inspiron>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601082150.55926.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 08 January 2006 21:04, Alessandro Zummo wrote:
> On Sun, 8 Jan 2006 20:56:29 -0500
> Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> 
> > > +static void rtc_proc_remove_device(struct class_device *class_dev,
> > > +                                             struct class_interface *class_intf)
> > > +{
> > > +       down(&rtc_sem);
> > > +       if (rtc_dev == class_dev) {
> > > +               remove_proc_entry("driver/rtc", NULL);
> > > +               rtc_dev = NULL;
> > > +       }
> > > +       up(&rtc_sem);
> > > +}
> > 
> > What if I happen to remove (unregister) rtc devices in order other
> > than they were registered in? You need a counter there instead of
> > storing the first device created.
> 
>  Only the first device that registers will get the /proc/driver/rtc
>  entry, which will be removed when the driver unregisters.
> 
>  /proc/driver/rtc is a legacy interface, thus supporting it
>  for more than one RTC is useless. Any system that uses
>  more than one RTCs should access them via /dev/rtcX or
>  via sysfs.
> 

Oh, I see. Ignore me then... 

-- 
Dmitry
