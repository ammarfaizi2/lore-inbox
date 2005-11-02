Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030250AbVKCBgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030250AbVKCBgd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 20:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030251AbVKCBgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 20:36:33 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:56203
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1030250AbVKCBgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 20:36:32 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Robert Hancock <hancockr@shaw.ca>
Subject: Re: echo 0 > /proc/sys/vm/swappiness triggers OOM killer under 2.6.14.
Date: Wed, 2 Nov 2005 16:24:36 -0600
User-Agent: KMail/1.8
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <53VDs-5r1-5@gated-at.bofh.it> <5400l-3iY-37@gated-at.bofh.it> <43680338.6040600@shaw.ca>
In-Reply-To: <43680338.6040600@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511021624.36587.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 November 2005 18:07, Robert Hancock wrote:
> > Free pages:        1416kB (0kB HighMem)
> > Active:14014 inactive:718 dirty:1 writeback:0 unstable:0 free:354
> > slab:468 mapped:14722 pagetables:58
> > DMA free:1416kB min:1024kB low:1280kB high:1536kB active:56056kB
> > inactive:2872kB present:65536kB pages_scanned:26577 all_unreclaimable? no
>
> It looks like some memory is available here, but likely some UML person
> would have to say for sure..

UML = User Mode Linux.  I.E. configuring and building the normal linux kernel 
with "ARCH=um", which makes for much less rebooting when testing this sort of 
thing out.  I can try making an equivalent bootable kernel and re-running the 
test under there to confirm I get the failure, if you'd like, but this part 
of the kernel (the virtual memory subsystem) really shouldn't be affected by 
this.

> > Out of Memory: Killed process 30055 (cc1).
> > Badness in handle_page_fault
> > at
> > /home/landley/newbuild/firmware-build/tmpdir/linux-2.6.14/arch/um/kernel/
> >trap_kern.c:98
>
> You likely need a UML person for this part too :-)

The fact that the User Mode Linux people wrote their own trap handler?  Do you 
think that changes the trap being dumped, or is likely to alter the behavior 
of the VM subsystem?

Rob
