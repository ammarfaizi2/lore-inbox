Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932372AbVL0WF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbVL0WF5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 17:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbVL0WF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 17:05:56 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2214 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932372AbVL0WF4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 17:05:56 -0500
Date: Tue, 27 Dec 2005 23:05:33 +0100
From: Pavel Machek <pavel@ucw.cz>
To: dtor_core@ameritech.net
Cc: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys interface
Message-ID: <20051227220533.GA1914@elf.ucw.cz>
References: <20051227213439.GA1884@elf.ucw.cz> <d120d5000512271355r48d476canfea2c978c2f82810@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000512271355r48d476canfea2c978c2f82810@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >  static ssize_t state_show(struct device * dev, struct device_attribute *attr, char * buf)
> >  {
> > -       return sprintf(buf, "%u\n", dev->power.power_state.event);
> > +       if (dev->power.power_state.event)
> > +               return sprintf(buf, "suspend\n");
> > +       else
> > +               return sprintf(buf, "on\n");
> >  }
> 
> Are you sure that having only 2 options (suspend/on) is enough at the
> core level? I could envision having more levels, like "poweroff", etc?

Note that interface is 0/2, currently, so this is improvement :-).

One day, when we find device that needs it, we may want to add more
states. I don't know about such device currently.

								Pavel
-- 
Thanks, Sharp!
