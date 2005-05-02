Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261728AbVEBT2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbVEBT2s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 15:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbVEBT2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 15:28:48 -0400
Received: from diadema.skane.tbv.se ([193.13.139.13]:14236 "EHLO
	diadema.skane.tbv.se") by vger.kernel.org with ESMTP
	id S261724AbVEBT2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 15:28:45 -0400
From: "Oskar Liljeblad" <oskar@osk.mine.nu>
Date: Mon, 2 May 2005 21:28:43 +0200
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: clock drift with two Promise Ultra133 TX2 (PDC 20269) cards
Message-ID: <20050502192843.GA3367@oskar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
X-Spam-Score: 0.0 (/)
X-Spam-Report: Spam detection software, running on the system "diadema.skane.tbv.se", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  I'm running 2.6.11.8 on an server with two Promise
	Ultra133 TX2 (PDC20269) PCI cards, same hardware revision (judging from
	stickers on the cards). I'm using the CONFIG_BLK_DEV_PDC202XX_NEW
	driver. Each card has two connected hard drives. Whenever I read from a
	disk on one of the cards (e.g. using 'dd if=/dev/hdX of=/dev/null
	bs=1M'), and at the same time read from a disk on the other card, there
	is heavy software clock drift. It drifts about 2-5 seconds per minute.
	[...] 
	Content analysis details:   (0.0 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running 2.6.11.8 on an server with two Promise Ultra133 TX2 (PDC20269)
PCI cards, same hardware revision (judging from stickers on the cards).
I'm using the CONFIG_BLK_DEV_PDC202XX_NEW driver.
Each card has two connected hard drives. Whenever I read from a disk
on one of the cards (e.g. using 'dd if=/dev/hdX of=/dev/null bs=1M'), and
at the same time read from a disk on the other card, there is heavy
software clock drift. It drifts about 2-5 seconds per minute.

This does not happen if I read from two drives connected on the same
card, or if I read from a drive connected to the motherboard IDE
(VIA vt8233a) and a drive on either of the Promise cards.

Oskar Liljeblad (oskar@osk.mine.nu)
