Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129831AbQJ3X1D>; Mon, 30 Oct 2000 18:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129829AbQJ3X0n>; Mon, 30 Oct 2000 18:26:43 -0500
Received: from www.collectingnation.com ([206.183.160.80]:22532 "EHLO
	collectingnation") by vger.kernel.org with ESMTP id <S129697AbQJ3X0g>;
	Mon, 30 Oct 2000 18:26:36 -0500
Date: Mon, 30 Oct 2000 18:29:54 -0500 (EST)
From: John Babina III <babina@pex.net>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Update: SMP 2.2.15 #2 kernel, lock ups...
Message-ID: <Pine.LNX.4.20.0010301813430.14540-100000@pioneer.local.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I spent the entire day working on this problem... as per Alan's
suggestion, I attempted to upgrade to 2.2.17.

Ugh, I had nothing but disaster....  First, the kernel would not
auto-recognize I had 1 gig of memory... it would only boot saying I had 64
meg.  So I added the MEM=1024M line to the lilo config (I believe that is
the correct line, don't have it in front of me).  Whenever I booted the
machine under 2.2.17, I would get errors during the boot process... here
is part of one (if you need more details let me know, i had to copy these
down on scrap paper)

Swap_Free trying to free no-existant swap page

Zap_Pte_range: bad pmd (371b10b7)

Unable to handle Kernel Null Ptr deref at virt addr 000001a9

then it goes on and finally lists an oops for a process "top100" (it's an
apache process I have running)

The machine has 1 Gig, a Mylex ExtremeRaid 1100, dual 700 mhz pentium
3's.  To refresh, the original problem I had was a lockup every 24-48
hours randomly, with no warning or errors.

As per suggested here (as well as upgrading to .17) I also checked into
bios upgrades for the motherboard -- I found mine was the most current.  I
also checked and upgraded the Mylex bios to the latest version and moved
the cards around to different PCI slots.  As for the lockups, I don't know
If I have resolved them yet or not, but I do know I am having horrible
problems besides the lockups, as per upgrading to .17.

I am starting to wonder if I am having memory problems?  I noticed that
when I was running at 64 megs (by accident, the system was not detecting
my full memory for some reason) the machine seemed to work perfectly, but
once I said MEM=1024, all hell broke loose... thats when I started getting
errors.  One thing that consistently happened with .17 was after I had an
error and had to reboot, FSCK had to run.  FSCK would find all of these
bad time header things and would work at fixing them, then after like 1
minute of crunching it would just lockup, I could hit return on the
keyboard and see a blank line appear on the screen but that was it.  The
drives stopped running and no further processing.  If i kept rebooting,
this occurred over and over.  Once I dropped back to an older kernel (via
a kernel boot disk), the fsck would work perfectly and complete the boot
process... 

Does this sound like a .17 problem or a memory problem or both?  I have
had 4 machines with similar hardware (dual processor, mylex raid cards, 1
gig) and not had any problems like this before. (theo ther machines had
slower processors, or older mylex raid).  I am about to boot this machine
out the door.

Shouldn't my machine be auto-detecting how much memory I have without
using the MEM= line in lilo?.. I believe it had in the past.

I have ordered a new gig of memory overnight so I can drop it in and see
if it resolves the problem(s)... if you need any more info, such as more
details on those errors, etc. please let me know.

Thanks in advance,
-John

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
