Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964801AbWE3XBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbWE3XBZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 19:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbWE3XBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 19:01:25 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:12856 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964801AbWE3XBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 19:01:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VpGFg3lkr8LZaElUij70vCxJTjDeWRCSQZGeAn1GrJ1fpQcoj04UJDUI/LWQglpa2ZNsmvswhCX8SuHpo1PmnZnxzAZFPMpH49bFRV7RWHwiAn6W3iWEbEtDsatvmG4WX5ij4cQ/LMFayMYoGUJ2MLjf4BzSsuiZqyKKf07slZM=
Message-ID: <21d7e9970605301601t37f8d3ddwaf4a900ed8997fdf@mail.gmail.com>
Date: Wed, 31 May 2006 09:01:23 +1000
From: "Dave Airlie" <airlied@gmail.com>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "Pavel Machek" <pavel@ucw.cz>, "D. Hazelton" <dhazelton@enter.net>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <9e4733910605301356k64dcd75fo38e45e1b7572817f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <9e4733910605272027o7b59ea5n5d402dabdd7167cb@mail.gmail.com>
	 <200605280112.01639.dhazelton@enter.net>
	 <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com>
	 <20060529102339.GA746@elf.ucw.cz>
	 <21d7e9970605290336m1f80b08nebbd2a995be959cb@mail.gmail.com>
	 <20060529124840.GD746@elf.ucw.cz>
	 <21d7e9970605291623k3636f7hcc12028cad5e962b@mail.gmail.com>
	 <20060530202401.GC16106@elf.ucw.cz>
	 <9e4733910605301356k64dcd75fo38e45e1b7572817f@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > > >No, to the contrary. suspend/resume can't ever work properly with
> > > >vgacon and vesafb. It works okay with radeonfb tooday, and in fact
> > > >radeonfb is neccessary today for saving power over S3.
> > >
> > > But the things is today for many users suspend/resume to RAM works for
> > > people running X drivers, I know on my laptop that my radeon
> > > suspends/resumes fine when running vgacon/DRM/accelerated X, it
> > > doesn't suspend/resume at all well when running vgacon on its own of
> > > course. or with radeonfb for that matter. so I still believe the
> > > suspend/resume code for a card can live in userspace if necessary but
> > > it just shouldn't be part of X... it needs to be part of another
> > > graphics controller process.
> >
> > So we are mostly in agreement. I'd prefer to have suspend/resume code
> > in kernel in cases it is simple... but separate userspace process is
> > better than having it in X.
>
> Don't draw any conclusions from saying that suspend/resume works in X
> and doesn't work on xx_fb. What matters is that a set of code that can
> perform suspend/resumes exists at all. Once a coherent driver model is
> designed the relevant code can be moved to the correct place.
>

Actually the suspend/resume has to be in userspace, X just re-posts
the video ROM and reloads the registers... so the repost on resume has
to happen... so some component needs to be in userspace..

Dave.
