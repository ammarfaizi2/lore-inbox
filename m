Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261424AbVGYSqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbVGYSqz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 14:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbVGYSqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 14:46:55 -0400
Received: from [81.92.212.1] ([81.92.212.1]:21006 "EHLO zmail.pt")
	by vger.kernel.org with ESMTP id S261424AbVGYSqy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 14:46:54 -0400
Subject: Re: [BUG] Tulip for ULi M5263: No packets transmitted
From: Ricardo Bugalho <ricardo.b@zmail.pt>
To: jbenc@suse.cz
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <20050725141644.66ba4021@griffin.suse.cz>
References: <1122146524.7275.22.camel@localhost>
	 <20050725141644.66ba4021@griffin.suse.cz>
Content-Type: text/plain
Date: Mon, 25 Jul 2005 19:46:11 +0100
Message-Id: <1122317171.7713.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: ricardo.b@zmail.pt
X-Spam-Processed: smtp.zmail.pt, Mon, 25 Jul 2005 19:44:27 +0100
	(not processed: spam filter disabled)
X-Return-Path: ricardo.b@zmail.pt
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: ricardo.b@zmail.pt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
yes it does help. Thanks.
Still not perfect though, it gives a warning, reports to be working on
half-duplex and I can't use mii-tool with it.

Here's the dmesg output (2.6.12.3 + patch):
Linux Tulip driver version 1.1.13 (May 11, 2002)
ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 17 (level, low) -> IRQ 17
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1)
block.
tulip0:  Index #1 - Media 10baseT (#0) described by a <unknown> (128)
block.
tulip0:  Index #2 - Media 10baseT (#0) described by a 21140 non-MII (0)
block.
tulip0:  Index #3 - Media 10base2 (#1) described by a 21140 non-MII (0)
block.
tulip0:  Index #4 - Media 10baseT-FDX (#4) described by a 21140 non-MII
(0) block.
tulip0:  Index #5 - Media 100baseTx-FDX (#5) described by a 21140
non-MII (0) block.
tulip0: ***WARNING***: No MII transceiver found!
eth0: ULi M5261/M5263 rev 64 at f884cc00, 00:0B:6A:D1:FC:B9, IRQ 17.
...
eth0: Setting half-duplex based on MII#1 link partner capability of
ffff.
...

When I try to run mii-tool, it yields: 
# mii-tool eth0
SIOCGMIIPHY on 'eth0' failed: No such device


On Mon, 2005-07-25 at 14:16 +0200, Jiri Benc wrote:

> Does tulip-fixes-for-uli5261.patch from -mm tree help?
> 

-- 
        Ricardo

