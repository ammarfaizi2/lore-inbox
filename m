Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261927AbSI3FWD>; Mon, 30 Sep 2002 01:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261928AbSI3FWD>; Mon, 30 Sep 2002 01:22:03 -0400
Received: from stroke.of.genius.brain.org ([206.80.113.1]:55424 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id <S261927AbSI3FWC>; Mon, 30 Sep 2002 01:22:02 -0400
Date: Mon, 30 Sep 2002 01:27:21 -0400
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Subject: 2.5.39 ide-scsi kernel panic
Message-ID: <20020930052721.GA1618@Master.Wizards>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel panic trying to use ide-scsi.
module or built-in, same result

ASUS P4S533 (SiS645DX chipset)
P4 2Ghz
1G PC2700 RAM 
nVidia Corporation NV15 [GeForce2 GTS] (rev a4)
Maxtor 4G100J5, ATA DISK drive
LG CD-RW CED-8120B, ATAPI CD/DVD-ROM drive <-- the one trying to be ide-scsi
SAMSUNG DVD-ROM SD-616T, ATAPI CD/DVD-ROM drive

(incomplete -> hand copied from screen. ide-scsi as a module)
Mounting local filesystems: -------[ cut here ]-------
kernel BUG at slab.c:1477!
invalid operand: 0000
ide-scsi
CPU: 0
EIP: 0060:[<c013735e>]   not tainted
EFLAGS: 00010016
EIP is at kmem_cache_free_one+0x7e/0x230
  <register values here - not copied>
Process swapper (pid:0, threadinfo=c03e8000 task=c03a2940)
  <stack values here - not copied>
Call Trace:
[<c013693f>]kfree+0x5f/0xb0
[<fa92a48c>]idescsi_end_request+0x1ac/0x2c0[ide-scsi]
[<fa92a622>]idescsi_pc_intr+0x82/0x2f0[ide-scsi]
[<c0226086>]ide_timer_expiry+0xd6/0x230
[<fa92a5a0>]idescsi_pc_intr+0x0/0x2f0[ide-scsi]
[<c022afb0>]ide_timer_expiry+0x0/0x230
[<c01233d2>]run_timer_list+0x112/0x170
[<c011f4e3>]bh_action+0x33/0x40
  <there was more (next was tasklet_hi_action) but it was taking too
  long to write the stuff down by hand>
  

-- 
Murray J. Root
------------------------------------------------
DISCLAIMER: http://www.goldmark.org/jeff/stupid-disclaimers/
------------------------------------------------
Mandrake on irc.openprojects.net:
  #mandrake & #mandrake-linux = help for newbies 
  #mdk-cooker = Mandrake Cooker 

