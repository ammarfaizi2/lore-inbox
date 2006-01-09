Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932905AbWAIGjd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932905AbWAIGjd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 01:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932907AbWAIGjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 01:39:32 -0500
Received: from smtp114.sbc.mail.re2.yahoo.com ([68.142.229.91]:31638 "HELO
	smtp114.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932905AbWAIGjc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 01:39:32 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: Re: [PATCH 5/8] RTC subsystem, dev interface
Date: Mon, 9 Jan 2006 01:39:29 -0500
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org
References: <20060108231235.153748000@linux> <200601082150.22213.dtor_core@ameritech.net> <20060109041206.6115bafb@inspiron>
In-Reply-To: <20060109041206.6115bafb@inspiron>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601090139.29556.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 08 January 2006 22:12, Alessandro Zummo wrote:
> > > +/* interface registration */
> > > +
> > > +struct class_interface rtc_dev_interface = {
> > > +   .add = &rtc_dev_add_device,
> > > +   .remove = &rtc_dev_remove_device,
> > > +};
> > > +
> > 
> > I wonder if doing rtc dev as a class device interface is a good idea.
> > It may be cleaner to fold it into the core.
> 
>  What the code implements is actually an interface, so this should
>  be the riht place. It is also fully optional, everything could work
>  without it. Probably the interface implementation hasn't all the primitives
>  to handle this kind of work, but I'm not willing to go into that right now ;)
> 

Yes, it is an interface. What I am trying to say - is it a main interface?
What is the preferred, most efficient way to interface with RTC? If it is
through this interface it may make sence to fold it into the core. Otherwise
do what input layer does and have interface create another class device which
reprsesents your /dev node.

-- 
Dmitry
