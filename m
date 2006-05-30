Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932458AbWE3USx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbWE3USx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 16:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbWE3USx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 16:18:53 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:21473 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932461AbWE3USw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 16:18:52 -0400
Date: Tue, 30 May 2006 22:18:02 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Lang <dlang@digitalinsight.com>
Cc: Jeff Garzik <jeff@garzik.org>, Dave Airlie <airlied@gmail.com>,
       "D. Hazelton" <dhazelton@enter.net>, Jon Smirl <jonsmirl@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
Message-ID: <20060530201802.GB16106@elf.ucw.cz>
References: <200605272245.22320.dhazelton@enter.net> <9e4733910605272027o7b59ea5n5d402dabdd7167cb@mail.gmail.com> <200605280112.01639.dhazelton@enter.net> <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com> <20060529102339.GA746@elf.ucw.cz> <21d7e9970605290336m1f80b08nebbd2a995be959cb@mail.gmail.com> <20060529124840.GD746@elf.ucw.cz> <447B666F.5080109@garzik.org> <20060529214540.GB7537@elf.ucw.cz> <Pine.LNX.4.63.0605301043010.4786@qynat.qvtvafvgr.pbz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0605301043010.4786@qynat.qvtvafvgr.pbz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Well, I agree that vesafb and vgacon need to exist and are useful for
> >installation/servers/etc. I was arguing that some combinations are
> >bad.
> >
> >Like vgacon + X + 3D acceleration.
> 
> why is this bad?
> 
> this lets the user of the box use as much as is needed, from plain text 
> mode on up to accelerated modes. perfect for the user who sometimes needs 
> a nimple, stripped down system and sometimes needs graphics (and if they 
> need graphics it seems silly to deny them access to the accelerated 
> features)

Because you have vgacon that knows nothing about your videocard, then
try to run 3D acceleration over it. Suspend/resume can't work properly
in such case... fbcon is pretty good for your stripped-down system,
too.

...and we do not want to support 1000 different configs, because then
they all become buggy.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
