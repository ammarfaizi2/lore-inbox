Return-Path: <linux-kernel-owner+w=401wt.eu-S1751653AbXAPVrc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653AbXAPVrc (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 16:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751664AbXAPVrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 16:47:32 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:34910 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751653AbXAPVrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 16:47:31 -0500
Date: Tue, 16 Jan 2007 22:47:06 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Linux usb mailing list 
	<linux-usb-devel@lists.sourceforge.net>
Subject: Re: 2.6.20-rc5: usb mouse breaks suspend to ram
Message-ID: <20070116214706.GA2182@elf.ucw.cz>
References: <20070116135727.GA2831@elf.ucw.cz> <d120d5000701160608t73db4405n5d157db43899776a@mail.gmail.com> <20070116142432.GA6171@elf.ucw.cz> <d120d5000701161325h112a9299w944763b7f1032a61@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000701161325h112a9299w944763b7f1032a61@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> >I started using el-cheapo usb mouse... only to find out that it breaks
> >> >suspend to RAM. Suspend-to-disk works okay. I was not able to extract
> >> >any usefull messages...
> >> >
> >> >Resume process hangs; I can still switch console and even type on
> >> >keyboard, but userland is dead, and I was not able to get magic sysrq
> >> >to respond.
> >>
> >> Are you using hid or usbmouse?
> >
> >I think it is hid:
> >
> >pavel@amd:/data/l/linux$ cat .config | grep MOUSE
...
> >pavel@amd:/data/l/linux$
> >
> >Should I disable config_hid and try some other driver?
> 
> No, HID is the preferred... I am not sure what is going on - on my box
> STR does not work at all thanks to nvidia chip turning the display on
> all the way as the very last step of suspend ;(

Hmm, I guess we should fix the suspend for you...

Strange, I can't reproduce the hang any more.

I found other weirdness while trying to hang it: if I move the mouse
while suspending, it is _not_ completely powered off while machine is
suspended. LED still shines, at half brightness...?! 
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
