Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262943AbTHZXNY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 19:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262971AbTHZXNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 19:13:24 -0400
Received: from mta03-svc.ntlworld.com ([62.253.162.43]:9464 "EHLO
	mta03-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S262943AbTHZXNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 19:13:22 -0400
From: Chris Rankin <cj.rankin@ntlworld.com>
Message-Id: <200308262313.h7QNDKIu007249@twopit.underworld>
Subject: Looking for tunable hardware parameters in 2.4.22
To: linux-kernel@vger.kernel.org
Date: Wed, 27 Aug 2003 00:13:20 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This could well be a motherboard problem, but the motherboard support
person has given up and all BIOS development has long since
stopped. So I'm wondering if just *maybe* there's a magic parameter I
could try tweaking on the Linux command line, please? I've already
tried "noapic", "acpi=off" and "nosmp".

Background:
- a dual PIII Coppermine board, i840 chipset, 133 MHz FSB
- 1GB of P100 memory
- CPUs are identical, and rated at 933 MHz on a 133 MHz FSB

This board has suddenly become unstable when there is a CPU in what
the motherboard calls "slot 2" and when the FSB is 133 MHz. The
motherboard is fine when either:
a) both CPUs are installed, and the FSB is set to 100 MHz, or
b) the CPU is removed from slot 2 and the FSB is set to 133 MHz.

I've swapped the CPUs around and tried replacing them entirely to no
avail, and so I know these CPUs are OK. I've also run memtest 3.0 over
the memory for almost 6 hours (with FSB=133 MHz; 3 times through the
entire RAM) with no problems, so I'm sure the RAM is OK too. However,
the support person thought that the problem was a mis-timing between
the FSB and the memory bus. (This board's memory bus runs at 100 MHz,
of course.)

The fact that the board runs OK with the underclocked FSB gives me
hope that the board hasn't burnt out or anything, because surely such
a catastrophic failure would have rendered it completely useless?

Unfortunately, the only timing the BIOS lets me change is the PCI
latency, which is currently set to 64. Would it be wise to adjust this
to (say) 96? I really don't want to risk damaging anything via a
"randomly tweaking monkey" approach.

Any advice appreciated, even if it's just "Give up, you have tried
everything."

Thanks in advance,
Chris


