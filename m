Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278813AbRKSNq4>; Mon, 19 Nov 2001 08:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278810AbRKSNqh>; Mon, 19 Nov 2001 08:46:37 -0500
Received: from mta.sara.nl ([145.100.16.144]:22691 "EHLO mta.sara.nl")
	by vger.kernel.org with ESMTP id <S278813AbRKSNq1>;
	Mon, 19 Nov 2001 08:46:27 -0500
Message-Id: <200111191346.OAA04290@zhadum.sara.nl>
X-Mailer: exmh version 2.1.1 10/15/1999
From: Remco Post <r.post@sara.nl>
To: James A Sutherland <jas88@cam.ac.uk>
cc: Remco Post <r.post@sara.nl>, linux-kernel@vger.kernel.org,
        remco@zhadum.sara.nl
Subject: Re: Swap 
In-Reply-To: Message from James A Sutherland <jas88@cam.ac.uk> 
   of "Mon, 19 Nov 2001 13:33:22 GMT." <E165oY1-0006Db-00@mauve.csi.cam.ac.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 19 Nov 2001 14:46:19 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Monday 19 November 2001 10:51 am, Remco Post wrote:
> > --8<--
> >
> > > Except that openoffice and mozilla can be swapped out in BOTH cases: the
> > > kernel can discard mapped pages and reread as needed, whether you have a
> > > swap partition or not.
> >
> > No they can't without swap, nothing can be SWAPPED out. The code pages can
> > be paged out (discarded), but no SWAPPING takes place.
> 
> OK, s/swapped/paged/.
> 
> > > Whereas without swapspace, only the read-only mapped pages can be swapped
> > > out.
> >
> > Again, pages do not gat swapped out, only applications can get swapped out.
> > Swapping is per definition the process of removing all pages used by one
> > application from RAM, and moving ALL pages to swap.
> 
> So in effect, Linux never ever swaps. At all. Under any circumstances. (Using 
> your interpretation of the word). Which does raise the question of WTF that 
> "swap space" is for, and why it's really used for "paging"...
> 
Linux does swap (I guess), swapping is a very extreem measure, "I need memory 
now, and the paging algorithm does not work any more", this is quite rare, but 
a few runaway netscape processes can easily cause this....


> > > Provided the VM is doing its job properly, adding swap will always be a
> > > net win for efficiency: the kernel is able to dump unused pages to make
> > > more room for others. Of course, you tend to "feel" the response times to
> > > interactive events, rather than the overall throughput, so a change which
> > > slows the system down but makes it more "responsive" to mouse clicks etc
> > > feels like a net win...
> >
> > With any properly sized system, it will NEVER SWAP. Paging is a completely
> > different thing. A little paging is not a problem. Up to 70 pagescans/s on
> > occasion is quite acceptable. If paging activety grows above that, you may
> > have a real problem. I don't know about the current VM, but with most
> > unixes when you hit this mark, the system actually starts swapping, and
> > your responsiveness goes down the drain....
> 
> By your definition, Linux does not swap, ever. It only "pages". This is what 
> I was referring to as swapping, since this involves the SWAPspace/partition, 
> rather than PAGEfile :)
> 
> 
> James.
> 

It is quite a common mistake. When discussing the VM, it is important to make 
the distinction. In the old days (about the time when I was born ;) swapping 
was the only thing Unixes ever did, no paging, which is quite a recent 
invention. As you'd expect, this is why you have a swapspace that is now also 
used for paging. As a test, you could quite simply build an application that 
uses so much memory (not only malloc it, but also USE it)  that your system 
will start swapping, try using any interative application after that, and 
you'll feel why you really don't want a system to swap...



-- 
Met vriendelijke groeten,

Remco Post

SARA - Stichting Academisch Rekencentrum Amsterdam
High Performance Computing  Tel. +31 20 592 8008    Fax. +31 20 668 3167

"I really didn't foresee the Internet. But then, neither did the computer
industry. Not that that tells us very much of course - the computer industry
didn't even foresee that the century was going to end." -- Douglas Adams


