Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267676AbRGPTRH>; Mon, 16 Jul 2001 15:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267677AbRGPTQ5>; Mon, 16 Jul 2001 15:16:57 -0400
Received: from sloth.wcug.wwu.edu ([140.160.176.172]:3878 "HELO
	sloth.wcug.wwu.edu") by vger.kernel.org with SMTP
	id <S267676AbRGPTQq>; Mon, 16 Jul 2001 15:16:46 -0400
Date: Mon, 16 Jul 2001 12:16:49 -0700 (PDT)
From: Josh Logan <josh@wcug.wwu.edu>
To: Andrea Arcangeli <andrea@suse.de>, alan@lxorguk.ukuu.org.uk
cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
        Andrew Morton <andrewm@uow.edu.au>,
        Klaus Dittrich <kladit@t-online.de>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.7p6 hang
In-Reply-To: <Pine.BSO.4.21.0107111217490.30480-100000@sloth.wcug.wwu.edu>
Message-ID: <Pine.BSO.4.21.0107161214160.11198-100000@sloth.wcug.wwu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just tried 2.4.6-ac5 and I had the same problem.  I'll go try 2.4.7-pre4
next.

							Later, JOSH


On Wed, 11 Jul 2001, Josh Logan wrote:

> 
> 
> On Wed, 11 Jul 2001, Andrea Arcangeli wrote:
> 
> > On Wed, Jul 11, 2001 at 11:33:40AM -0700, Josh Logan wrote:
> > > 
> > > I'm having a hang right after the floppy is initialised with pre5 and pre6
> > > (2.4.3 works fine)  I tried this patch, but it did not make any
> > 
> > is the problem introduced in pre5? Can you reproduce under 2.4.7pre4?
> 
> I'll have to go try it...
> 
> > 
> > > improvments.  The machine still has SysRq commands available.  Please let
> > > me know what other information you would like to debug this problem.
> > 
> > SYSRQ+T
> 
> Floppy Drives(s): fd0 is 1.44M
> FDC 0 is a post-1991 82077
> SysRq: Show State
> 
>   task		     PC    stack    pid father child younger older
> swapper		D C03EDEC0  4980      1      0     7               (L-TLB)
> keventd		S C1234560  6624      2      1             3       (L-TLB)
> ksoftirqd_CPU   S C1232000  6468      3      1             4     2 (L-TLB)
> kswapd		S C1231FA8  6588      4      1             5     3 (L-TLB)
> kreclaimd	S 00000286  6656      5      1             6     4 (L-TLB)
> bdflush		S 00000286  6652      6      1             7     5 (L-TLB)
> kupdated	S C7F9BFC8  6620      7      1                   6 (L-TLB)
> 
> I can add Call Traces if needed, this is done by hand.
> 
> > 
> > > BTW, I also tried to disable the floppy in the BIOS and got:
> > > ...
> > > Floppy OK
> > > task queue still active
> > > <HANG>
> > 
> > I'll soon have a look at this message.
> > 
> > Andrea
> > 
> 
> 							Later, JOSH
> 
> 
> 


