Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314512AbSEFPTw>; Mon, 6 May 2002 11:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314505AbSEFPTr>; Mon, 6 May 2002 11:19:47 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:24071 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S314512AbSEFPTi>; Mon, 6 May 2002 11:19:38 -0400
Date: Mon, 6 May 2002 17:19:39 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.12] x86 Boot enhancements, boot params 1/11
Message-ID: <20020506151939.GE12131@atrey.karlin.mff.cuni.cz>
In-Reply-To: <m11ycuzk4q.fsf@frodo.biederman.org> <20020427025642.E413@toy.ucw.cz> <m1u1pl1t4h.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > #5  boot.heap
> > > ============================================================
> > > Modify video.S so that mode_list is also allocated from
> > > the boot time heap.  This probably saves a little memory,
> > > and makes a compiled in command line a sane thing to implement.
> > 
> > Do you see easy way to pass video mode used to kernel? S3 suspend support
> > is going to need that..
> 
> Do you mean something other than the vga= command line option?
> Which actually just sets a 16bit mode in the kernel parameter structure.

In case of vga=ask, it is kernel that gets number from the user,
right?

I'd need to know what mode was actually selected, so I can restore it
after S3 resume.
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
