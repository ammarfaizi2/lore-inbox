Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314652AbSEFUUK>; Mon, 6 May 2002 16:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314709AbSEFUUK>; Mon, 6 May 2002 16:20:10 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:26118 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S314652AbSEFUUJ>; Mon, 6 May 2002 16:20:09 -0400
Date: Mon, 6 May 2002 22:20:11 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.12] x86 Boot enhancements, boot params 1/11
Message-ID: <20020506202011.GC6027@atrey.karlin.mff.cuni.cz>
In-Reply-To: <m11ycuzk4q.fsf@frodo.biederman.org> <20020427025642.E413@toy.ucw.cz> <m1u1pl1t4h.fsf@frodo.biederman.org> <20020506151939.GE12131@atrey.karlin.mff.cuni.cz> <m1pu0917q0.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Do you mean something other than the vga= command line option?
> > > Which actually just sets a 16bit mode in the kernel parameter structure.
> > 
> > In case of vga=ask, it is kernel that gets number from the user,
> > right?
> 
> Right.
>  
> > I'd need to know what mode was actually selected, so I can restore it
> > after S3 resume.
> 
> I guess that works.  In this case it makes sense for the kernel to
> store it in the same variable the video mode is specified in.  This
> may require an extra store but it should be trivial to implement.
> 
> How are you handling the case of X and friends?  Are you making
> certain to switch to kernel controlled vt?

Switch to kernel-controlled-console with messages about suspend is how
I'm handling this in S4 (suspend-to-disk).

> My hunch is that this is a decent argument for real framebuffer drivers
> in the kernel.  But that is a separate problem.

Well, not neccessary since I can switch consoles back and forth in
kernel just fine.
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
