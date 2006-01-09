Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbWAICNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbWAICNK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 21:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWAICNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 21:13:09 -0500
Received: from jack.kinetikon.it ([62.152.125.81]:58753 "EHLO
	mail.towertech.it") by vger.kernel.org with ESMTP id S1750813AbWAICNI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 21:13:08 -0500
Date: Mon, 9 Jan 2006 03:13:39 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] RTC subsystem, sysfs interface
Message-ID: <20060109031339.6c661d9c@inspiron>
In-Reply-To: <200601082102.40992.dtor_core@ameritech.net>
References: <20060108231235.153748000@linux>
	<20060108231254.952993000@linux>
	<200601082102.40992.dtor_core@ameritech.net>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Jan 2006 21:02:40 -0500
Dmitry Torokhov <dtor_core@ameritech.net> wrote:

> On Sunday 08 January 2006 18:12, Alessandro Zummo wrote:
> > +static ssize_t rtc_sysfs_show_date(struct class_device *dev, char *buf)
> > +{
> > +       ssize_t retval = -ENODEV;
> > +       struct rtc_device *rtc = to_rtc_device(dev);
> > +       struct rtc_time tm;

 [...]

> ops locking is a mess here. Half of the code accesses it under protection
> of ops_lock while other half is unlocked. I think it would be better if
> that lock was taken in rtc_read_time and friends.

 Good point. I'll move them, thanks.
 

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

