Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281609AbRLGRlK>; Fri, 7 Dec 2001 12:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282644AbRLGRk5>; Fri, 7 Dec 2001 12:40:57 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:57227 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S281609AbRLGRki>; Fri, 7 Dec 2001 12:40:38 -0500
Date: Fri, 7 Dec 2001 10:40:31 -0700
Message-Id: <200112071740.fB7HeVG16220@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Robert Love <rml@tech9.net>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org
Subject: Re: horrible disk thorughput on itanium
In-Reply-To: <1007745537.828.15.camel@phantasy>
In-Reply-To: <p73r8q86lpn.fsf@amdsim2.suse.de.suse.lists.linux.kernel>
	<Pine.LNX.4.33.0112070710120.747-100000@mikeg.weiden.de.suse.lists.linux.ker
	 nel>
	<9upmqm$7p4$1@penguin.transmeta.com.suse.lists.linux.kernel>
	<p73n10v6spi.fsf@amdsim2.suse.de>
	<200112071614.fB7GEQ514356@vindaloo.ras.ucalgary.ca>
	<1007745537.828.15.camel@phantasy>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love writes:
> On Fri, 2001-12-07 at 11:14, Richard Gooch wrote:
> 
> > This kind of thing should be covered by _REENTRANT. If you don't
> > compile with _REENTRANT (the default), then putc() should be the
> > unlocked version.
> 
> The link to the mailing list post from bug-glibc says otherwise,
> that is the problem.  Using the unlocked version isn't implied by
> not setting __REENTRANT.

The bug is in glibc. An application shouldn't need to be changed to
work around that bug. putc() is a well-known interface, and people
shouldn't have to code around a change in that interface.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
