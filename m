Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269911AbUJMXfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269911AbUJMXfu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 19:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269916AbUJMXfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 19:35:50 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:40972 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S269911AbUJMXfZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 19:35:25 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
       "'Ankit Jain'" <ankitjain1580@yahoo.com>,
       "'linux'" <linux-kernel@vger.kernel.org>
Subject: RE: VM Vs Swap Space
Date: Wed, 13 Oct 2004 16:35:08 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKOEMJOPAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAdrZR1ip2x0S1aHNr193n7gEAAAAA@casabyte.com>
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Wed, 13 Oct 2004 16:12:00 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Wed, 13 Oct 2004 16:12:05 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> A long but basic explanation of the difference between "Virtual
> Memory" and "Swap
> Space" follows:

	One of the problems with a 'basic' explanation is that you always wind up
leaving out something that someone else things is important. ;)

> Imagine a computer with only five pages of memory.  Imagine a
> moment when pages 1 3
> and 5 are in use, and the system needs to load a program that is
> two pages long.  In
> the absence of virtual memory, that program couldn't be loaded
> because the two
> available pages (2 and 4) are not "next to each other" so the
> program would be broken
> in half.

	Even if it only had one page, it could load half the program in one page.
When the program tried to access the other page, it would fault. The first
page could be discarded and the second loaded. So the system could operate
even if it didn't have enough pages or any swap space.

> Now, in the same way that you, were you playing a game with
> hundreds of cards, would
> like to be able to put some cards aside while sorting through
> things so that you can
> handle the most important cards in play; the computer sometimes
> would like to put
> aside pages of memory that are valid, but that nobody seems to
> need just now.

> A swap file (which is also called a "paging file" in some
> systems) represents a place
> where the system (linux/windows/whatever) can set aside (swap
> out) the data from a
> page of real RAM memory, so that it can reuse that piece of real
> memory for another
> purpose.

	Or, if the data is already stored somewhere (if it's a page from a file
that hasn't been modified), it can just throw the page away.

> If the program that "owns" the original data tries to get to it a
> "page fault"
> happens and the system finds a (usually different) page of real
> memory that isn't in
> use (or that can be swapped out) and puts the data back (swaps)
> in this original data
> page into the new place, and makes that new/other piece of RAM
> appear (to the
> program) as if it had always been there and that it didn't move at all.

	This works the same whether the place is a file or a swap page.

> "Virtual Memory" is a short-hand name for either the task of
> making and maintaining
> these logical maps/chunks, or the name for any one consistent
> logical chunk when seen
> from inside.  If phrase is used without enough context it can get
> meaningless.  But
> in no meaningful case is it "interchangeable" with the term "swap space".

	Swap space, basically, allows a virtual memory system to move pages that it
can't discard out of precious physical memory.

	DS


