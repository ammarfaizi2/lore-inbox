Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285704AbSALLPO>; Sat, 12 Jan 2002 06:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285747AbSALLPE>; Sat, 12 Jan 2002 06:15:04 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:14402 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S285730AbSALLOv>; Sat, 12 Jan 2002 06:14:51 -0500
Date: Sat, 12 Jan 2002 12:13:15 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Robert Love <rml@tech9.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, nigel@nrg.org,
        Rob Landley <landley@trommello.org>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020112121315.B1482@inspiron.school.suse.de>
In-Reply-To: <E16P0vl-0007Tu-00@the-village.bc.nu> <1010781207.819.27.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <1010781207.819.27.camel@phantasy>; from rml@tech9.net on Fri, Jan 11, 2002 at 03:33:22PM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2002 at 03:33:22PM -0500, Robert Love wrote:
> On Fri, 2002-01-11 at 07:37, Alan Cox wrote:
> 
> > Its more than a spinlock cleanup at that point. To do anything useful you have
> > to tackle both priority inversion and some kind of at least semi-formal 
> > validation of the code itself. At the point it comes down to validating the
> > code I'd much rather validate rtlinux than the entire kernel
> 
> The preemptible kernel plus the spinlock cleanup could really take us
> far.  Having locked at a lot of the long-held locks in the kernel, I am
> confident at least reasonable progress could be made.
> 
> Beyond that, yah, we need a better locking construct.  Priority
> inversion could be solved with a priority-inheriting mutex, which we can
> tackle if and when we want to go that route.  Not now.
> 
> I want to lay the groundwork for a better kernel.  The preempt-kernel
> patch gives real-world improvements, it provides a smoother user desktop
> experience -- just look at the positive feedback.  Most importantly,
> however, it provides a framework for superior response with our standard

I don't know how to tell you, positive feedback compared to mainline
kernel is totally irrelevant, mainline has broken read/write/sendfile
syscalls that can hang the machine etc... That was fixed ages ago in
many ways, current way is very lightweight, if you can get positive
feedback compared to -aa _that_ will matter.

Andrea
