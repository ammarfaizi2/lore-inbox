Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278808AbRKSNdo>; Mon, 19 Nov 2001 08:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278795AbRKSNde>; Mon, 19 Nov 2001 08:33:34 -0500
Received: from mauve.csi.cam.ac.uk ([131.111.8.38]:28632 "EHLO
	mauve.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S278742AbRKSNdT>; Mon, 19 Nov 2001 08:33:19 -0500
Content-Type: text/plain; charset=US-ASCII
From: James A Sutherland <jas88@cam.ac.uk>
To: Remco Post <r.post@sara.nl>, linux-kernel@vger.kernel.org
Subject: Re: Swap
Date: Mon, 19 Nov 2001 13:33:22 +0000
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <200111191051.LAA04099@zhadum.sara.nl>
In-Reply-To: <200111191051.LAA04099@zhadum.sara.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E165oY1-0006Db-00@mauve.csi.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 November 2001 10:51 am, Remco Post wrote:
> --8<--
>
> > Except that openoffice and mozilla can be swapped out in BOTH cases: the
> > kernel can discard mapped pages and reread as needed, whether you have a
> > swap partition or not.
>
> No they can't without swap, nothing can be SWAPPED out. The code pages can
> be paged out (discarded), but no SWAPPING takes place.

OK, s/swapped/paged/.

> > Whereas without swapspace, only the read-only mapped pages can be swapped
> > out.
>
> Again, pages do not gat swapped out, only applications can get swapped out.
> Swapping is per definition the process of removing all pages used by one
> application from RAM, and moving ALL pages to swap.

So in effect, Linux never ever swaps. At all. Under any circumstances. (Using 
your interpretation of the word). Which does raise the question of WTF that 
"swap space" is for, and why it's really used for "paging"...

> > Provided the VM is doing its job properly, adding swap will always be a
> > net win for efficiency: the kernel is able to dump unused pages to make
> > more room for others. Of course, you tend to "feel" the response times to
> > interactive events, rather than the overall throughput, so a change which
> > slows the system down but makes it more "responsive" to mouse clicks etc
> > feels like a net win...
>
> With any properly sized system, it will NEVER SWAP. Paging is a completely
> different thing. A little paging is not a problem. Up to 70 pagescans/s on
> occasion is quite acceptable. If paging activety grows above that, you may
> have a real problem. I don't know about the current VM, but with most
> unixes when you hit this mark, the system actually starts swapping, and
> your responsiveness goes down the drain....

By your definition, Linux does not swap, ever. It only "pages". This is what 
I was referring to as swapping, since this involves the SWAPspace/partition, 
rather than PAGEfile :)


James.
