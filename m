Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268983AbRG3Pz7>; Mon, 30 Jul 2001 11:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268987AbRG3Pzt>; Mon, 30 Jul 2001 11:55:49 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:61202
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S268983AbRG3Pzp>; Mon, 30 Jul 2001 11:55:45 -0400
Date: Mon, 30 Jul 2001 11:55:00 -0400
From: Chris Mason <mason@suse.com>
To: linux-kernel@vger.kernel.org
cc: andrea@suse.de
Subject: BUG at smp.c:481, 2.4.8-pre2
Message-ID: <296370000.996508500@tiny>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



Ok, During boot on 2.4.8-pre2 I'm getting this oops just as it starts to
probe my aic7890 card.  Andrea is cc'd because I'm guessing it is due to
one of his patches ;-)

2 PIII cpus, 128MB ram on the box.

The oops is at line 481 on smp.c, call trace:

smp_call_function (BUG() is here, spin_unlock_bh())
ahc_reset_channel
flush_tlb_all
ahc_reset_channel
remap_area_pages
__ioremap
ahc_pci_map_registers
ahc_find_pci_device
pci_bios_set_master

-chris
