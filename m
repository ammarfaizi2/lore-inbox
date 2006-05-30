Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964825AbWE3XjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbWE3XjP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 19:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbWE3XjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 19:39:15 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:28652 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964825AbWE3XjO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 19:39:14 -0400
Date: Wed, 31 May 2006 01:38:26 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Dave Airlie <airlied@gmail.com>, "D. Hazelton" <dhazelton@enter.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
Message-ID: <20060530233826.GE16106@elf.ucw.cz>
References: <200605280112.01639.dhazelton@enter.net> <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com> <20060529102339.GA746@elf.ucw.cz> <21d7e9970605290336m1f80b08nebbd2a995be959cb@mail.gmail.com> <20060529124840.GD746@elf.ucw.cz> <21d7e9970605291623k3636f7hcc12028cad5e962b@mail.gmail.com> <20060530202401.GC16106@elf.ucw.cz> <9e4733910605301356k64dcd75fo38e45e1b7572817f@mail.gmail.com> <21d7e9970605301601t37f8d3ddwaf4a900ed8997fdf@mail.gmail.com> <9e4733910605301627t2f28db08vf58c78e2656b7047@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910605301627t2f28db08vf58c78e2656b7047@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Actually the suspend/resume has to be in userspace, X just re-posts
> >the video ROM and reloads the registers... so the repost on resume has
> >to happen... so some component needs to be in userspace..
> 
> I'd like to see the simple video POST program get finished. All of the
> pieces are lying around. A key step missing is to getting klibc added
> to the kernel tree which is being worked on.
> 
> BenH has the emu86 code. I agree that is simpler to always use emu86
> and not bother with vm86. He also pointed out that we need to copy the
> image back into the kernel after the ROM runs. Right now you can only
> read the ROM image from the sysfs attribute. The ROM code has support
> for keeping an image in RAM, it just isn't hooked up to the sysfs
> attribute for writing it.

Actually, vbetool is the piece of puzzle we currently use to
reinitialize graphics cards after resume. (suspend.sf.net).

We currently do it all in userspace; it would be cleaner to do it as
call_usermodehelper() from kernel.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
