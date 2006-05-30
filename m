Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932400AbWE3UZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbWE3UZA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 16:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbWE3UZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 16:25:00 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:19390 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932400AbWE3UY7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 16:24:59 -0400
Date: Tue, 30 May 2006 22:24:01 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Dave Airlie <airlied@gmail.com>
Cc: "D. Hazelton" <dhazelton@enter.net>, Jon Smirl <jonsmirl@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
Message-ID: <20060530202401.GC16106@elf.ucw.cz>
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <200605272245.22320.dhazelton@enter.net> <9e4733910605272027o7b59ea5n5d402dabdd7167cb@mail.gmail.com> <200605280112.01639.dhazelton@enter.net> <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com> <20060529102339.GA746@elf.ucw.cz> <21d7e9970605290336m1f80b08nebbd2a995be959cb@mail.gmail.com> <20060529124840.GD746@elf.ucw.cz> <21d7e9970605291623k3636f7hcc12028cad5e962b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21d7e9970605291623k3636f7hcc12028cad5e962b@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >No, to the contrary. suspend/resume can't ever work properly with
> >vgacon and vesafb. It works okay with radeonfb tooday, and in fact
> >radeonfb is neccessary today for saving power over S3.
> 
> But the things is today for many users suspend/resume to RAM works for
> people running X drivers, I know on my laptop that my radeon
> suspends/resumes fine when running vgacon/DRM/accelerated X, it
> doesn't suspend/resume at all well when running vgacon on its own of
> course. or with radeonfb for that matter. so I still believe the
> suspend/resume code for a card can live in userspace if necessary but
> it just shouldn't be part of X... it needs to be part of another
> graphics controller process.

So we are mostly in agreement. I'd prefer to have suspend/resume code
in kernel in cases it is simple... but separate userspace process is
better than having it in X.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
