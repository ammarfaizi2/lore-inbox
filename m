Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277713AbRKSKwQ>; Mon, 19 Nov 2001 05:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277738AbRKSKwG>; Mon, 19 Nov 2001 05:52:06 -0500
Received: from mta.sara.nl ([145.100.16.144]:15255 "EHLO mta.sara.nl")
	by vger.kernel.org with ESMTP id <S277713AbRKSKv4> convert rfc822-to-8bit;
	Mon, 19 Nov 2001 05:51:56 -0500
Message-Id: <200111191051.LAA04099@zhadum.sara.nl>
X-Mailer: exmh version 2.1.1 10/15/1999
From: Remco Post <r.post@sara.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: Swap 
In-Reply-To: Message from James A Sutherland <jas88@cam.ac.uk> 
   of "Mon, 19 Nov 2001 09:18:11 GMT." <E165kZ4-0005I4-00@mauve.csi.cam.ac.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Date: Mon, 19 Nov 2001 11:51:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8<--

> Except that openoffice and mozilla can be swapped out in BOTH cases: the 
> kernel can discard mapped pages and reread as needed, whether you have a swap 
> partition or not.
>
No they can't without swap, nothing can be SWAPPED out. The code pages can be 
paged out (discarded), but no SWAPPING takes place.
 

> Whereas without swapspace, only the read-only mapped pages can be swapped out.

Again, pages do not gat swapped out, only applications can get swapped out. 
Swapping is per definition the process of removing all pages used by one 
application from RAM, and moving ALL pages to swap.


> Provided the VM is doing its job properly, adding swap will always be a net 
> win for efficiency: the kernel is able to dump unused pages to make more room 
> for others. Of course, you tend to "feel" the response times to interactive 
> events, rather than the overall throughput, so a change which slows the 
> system down but makes it more "responsive" to mouse clicks etc feels like a 
> net win...
> 
> 
> James.

With any properly sized system, it will NEVER SWAP. Paging is a completely 
different thing. A little paging is not a problem. Up to 70 pagescans/s on 
occasion is quite acceptable. If paging activety grows above that, you may 
have a real problem. I don't know about the current VM, but with most unixes 
when you hit this mark, the system actually starts swapping, and your 
responsiveness goes down the drain....


-- 
Met vriendelijke groeten,

Remco Post

SARA - Stichting Academisch Rekencentrum Amsterdam
High Performance Computing  Tel. +31 20 592 8008    Fax. +31 20 668 3167

"I really didn't foresee the Internet. But then, neither did the computer
industry. Not that that tells us very much of course - the computer industry
didn't even foresee that the century was going to end." -- Douglas Adams


