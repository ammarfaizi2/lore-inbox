Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315440AbSE1OPQ>; Tue, 28 May 2002 10:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316309AbSE1OPP>; Tue, 28 May 2002 10:15:15 -0400
Received: from sark.cc.gatech.edu ([130.207.7.23]:20882 "EHLO
	sark.cc.gatech.edu") by vger.kernel.org with ESMTP
	id <S315440AbSE1OPO>; Tue, 28 May 2002 10:15:14 -0400
Date: Tue, 28 May 2002 10:15:15 -0400
From: Josh Fryman <fryman@cc.gatech.edu>
To: linux-kernel@vger.kernel.org
Subject: changing __PAGE_OFFSET on x86?
Message-Id: <20020528101515.56785de1.fryman@cc.gatech.edu>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi,

i posted a query last week about a problem we're having with some PCI devices.
we have a P4 system with 512M of RAM and two PCI cards, each having another
256MB of RAM.  we want our device driver to expose the entire memory region
for the pci cards.

when adding all this up, we're exceeding the 3G/1G split of the linux kernel.
as dan maas pointed out, there should be a way to fix this in the kernel...
so, after some grepping and code browsing, my new question is:

to fix this, if we change the __PAGE_OFFSET in include/asm-i386/page.h from
0xc0000000 to 0xb000000, are there any hidden dependencies?  is there anything 
else we need to worry about?  (does the __PAGE_OFFSET need to lie on a 1G
boundary?)

i haven't seen any, but them i'm not willing to say i understand all the 
implications from chaging such a fundamental #define ....

thanks,

josh
