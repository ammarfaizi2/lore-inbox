Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbWDSVZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWDSVZL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 17:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbWDSVZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 17:25:10 -0400
Received: from service.sh.cvut.cz ([147.32.127.214]:61366 "EHLO
	service.sh.cvut.cz") by vger.kernel.org with ESMTP id S1751160AbWDSVZJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 17:25:09 -0400
Message-ID: <4446AAA8.70907@sh.cvut.cz>
Date: Wed, 19 Apr 2006 23:24:56 +0200
From: Rudolf Marek <r.marek@sh.cvut.cz>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Watchdog device class
References: <4443EED9.30603@sh.cvut.cz> <20060418195751.GA6968@infomag.infomag.iguana.be> <4445533D.9010000@sh.cvut.cz> <20060419210204.GA4205@infomag.infomag.iguana.be>
In-Reply-To: <20060419210204.GA4205@infomag.infomag.iguana.be>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Wim,

> You can have a check now. I uploaded some code. Need to retest it, but it
> has been working on my v2.6.5 test machine.

Good I will check. I have one test machine provided by Asus, Winbond and me :)
(I'm using it for lm-sensors stuff) I can give you access if you give me ssh key.

> Don't agree here: boot_status is a copy of the status at boot. the status
> itself can change during normal operation. and thus get_status must return
> the "devices status" at that moment.

Ah correct, not always updated via async event, maybe the register is to be
polled only.

>>I have no such thing for the temp IOCTL but the new "ioctl" operation
>>could be created to catch it.
>>(and get called when no standard ioctl in watchdog-dev is used)
> 
> 
> I think we want to review the temperature stuff in the kernel in general.

If you mean in watchdog class, the yes. Otherwise no. The hwmon class has well
defined interface for a while...

> I still have to look at your driver in detail, but my first thought would
> be that the private part here would be a link to this common device structure.
> (see what I did with the example softdog implementation in the experimental tree).

Ok.

> It's not about different approaches: we have to find the best thing for watchdog
> devicesi, so the best thing is to talk about pro's and con's and see what we should 
> do best. (I for instance didn't come to the sysfs part yet of my code (which would
> be in watchdog_sysfs.c)

Ok I will look into your code.

>>Also I would like to know your ideas about the sysfs file structure for
>>watchdogs and also If you like to have more watchdogs active in the system or
>>just one.
> 
> 
> My view:
> to start we should keep one /dev/watchdog, but we should create/define a suitable
> sysfs interface that makes it possible to have multiple watchdog devices running 
> in parallel. We will need this functionality in the future when a system will 
> consist of different processors that all have their own memory and some basic
> I/O interfacing.
> Later on we will then see what we will do with /dev/watchdog.

I will let you know when I'm done with the studying of your code. I hope that I
will have some time in near fututure, got lot of stuff to do.

Regards
Rudolf

PS: CC me please.
