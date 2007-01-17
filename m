Return-Path: <linux-kernel-owner+w=401wt.eu-S1751293AbXAQA6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbXAQA6X (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 19:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbXAQA6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 19:58:23 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:38907 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751293AbXAQA6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 19:58:22 -0500
Date: Wed, 17 Jan 2007 01:57:55 +0100
From: Pavel Machek <pavel@ucw.cz>
To: andi@lisas.de, seife@suse.de
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       Linux usb mailing list 
	<linux-usb-devel@lists.sourceforge.net>
Subject: Re: 2.6.20-rc5: usb mouse breaks suspend to ram
Message-ID: <20070117005755.GB6270@elf.ucw.cz>
References: <20070116135727.GA2831@elf.ucw.cz> <d120d5000701160608t73db4405n5d157db43899776a@mail.gmail.com> <20070116142432.GA6171@elf.ucw.cz> <d120d5000701161325h112a9299w944763b7f1032a61@mail.gmail.com> <20070117004012.GA11140@rhlx01.hs-esslingen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070117004012.GA11140@rhlx01.hs-esslingen.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > No, HID is the preferred... I am not sure what is going on - on my box
> > STR does not work at all thanks to nvidia chip turning the display on
> > all the way as the very last step of suspend ;(
> 
> One or several of these options might help cure this:
> - agp=off kernel command line (plus AGP driver option enabled in nvidia xorg.conf)
> - suspend: cat /proc/bus/pci/AA/BB.C >/tmp/video_state    --> resume
> - suspend: vbetool vbestate save    --> resume
> - directly after resume: vbetool post
> - playing with chvt to not stay in X vt upon suspend
> - acpi_sleep=s3_bios or acpi_sleep=s3_mode
> 
> Especially the PCI video_state trick finally got me a working resume on
> 2.6.19-ck2 r128 Rage Mobility M4 AGP *WITH*(!) fully enabled and working
> (and keeping working!) DRI (3D).

Can we get whitelist entry for suspend.sf.net? s2ram from there can do
all the tricks you described, one letter per trick :-). We even got
PCI saving lately.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
