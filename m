Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285126AbRLMUEN>; Thu, 13 Dec 2001 15:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285148AbRLMUEE>; Thu, 13 Dec 2001 15:04:04 -0500
Received: from Soo.com ([199.202.113.33]:49678 "EHLO Soo.com")
	by vger.kernel.org with ESMTP id <S285126AbRLMUDs>;
	Thu, 13 Dec 2001 15:03:48 -0500
Date: Thu, 13 Dec 2001 15:03:46 -0500
From: "really mason@soo.com" <lnx-kern@Sophia.soo.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.1-pre11 de2104X tulip driver problem
Message-ID: <20011213150346.A31843@Sophia.soo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a tulip driver bug report:

i'm one of those dinosaurs using a 10base2 network and really
old DLink-530 21040 and 21041 based ethercards.

This is what a recent kernel version (2.5.1-pre10) working
tulip driver prints out when booting up:

kernel: tulip0: 21041 Media table, default media 0800 (Autosense).
kernel: tulip0:  21041 media #0, 10baseT.
kernel: tulip0:  21041 media #4, 10baseT-FDX.
kernel: tulip0:  21041 media #1, 10base2.
[...]
kernel: eth0: Digital DC21041 Tulip rev 17 at 0xe0800f80, 21041 mode, 00:80:C8:3E:D0:BC, IRQ 12.
[...]
kernel: eth0: No 21041 10baseT link beat, Media switched to AUI.

Card still works on my 10base2 network even tho i haven't got
an AUI port on the ethercard.
======================================================================

This is what the non working 2.5.1-pre11 tulip driver prints out:

kernel: de2104x PCI Ethernet driver v0.5.1 (Nov 20, 2001)
kernel: de0: SROM-listed ports: TP
kernel: eth0: 21041 at 0xe0800f80, 00:80:c8:3e:d0:bc, IRQ 12
[...]
kernel: eth0: set link 10baseT auto, mode 7ffc0040, sia 10c4,ffffef01,ffffffff,ffff0008
kernel:                  set mode 7ffc0000, set sia ef01,ffff,8

====================================================================

regards,
b <mason@soo.com>
