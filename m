Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272562AbRHaAOV>; Thu, 30 Aug 2001 20:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272561AbRHaAOL>; Thu, 30 Aug 2001 20:14:11 -0400
Received: from dfw-smtpout3.email.verio.net ([129.250.36.43]:25051 "EHLO
	dfw-smtpout3.email.verio.net") by vger.kernel.org with ESMTP
	id <S272562AbRHaAOB>; Thu, 30 Aug 2001 20:14:01 -0400
Message-ID: <3B8ED6D7.CE237CE2@bigfoot.com>
Date: Thu, 30 Aug 2001 17:14:15 -0700
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.20p9ai i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pascal Schmidt <pleasure.and.pain@web.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: System crashes with via82cxxx ide driver
In-Reply-To: <Pine.LNX.4.33.0108310035530.2970-100000@neptune.sol.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 2.2.20p9, ide.2.2.19.05042001.patch.bz2, e2fsck v1.19.
> How did you get both the 2.2.20 pre-patch and the ide patch to apply? I
> get a couple of rejects.

1. Do the pre patch first.
2. The rejects didn't make any difference.  init/main.c.rej was SCSI
hd[m-t] addresses which were easy to drop in by hand,
drivers/block/ide.c.rej was comments & spacing, and the others were in
Configure.help or Makefile EXTRAVERSION conflicts.  These don't matter
in most cases where the ide patch makes sense.

> > 00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev
> > 10)
> The IDE part of my chipset is only revision 06, so perhaps this is a bug
> fixed in your revision.

I've another machine that uses the same kernel+ide:

00:00.0 Host bridge: VIA Technologies, Inc. VT82C585VP [Apollo VP1/VPX]
(rev 10)
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA
[Apollo VP] (rev 02)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev
02)
00:08.0 VGA compatible unclassified device: 3DLabs Permedia II 2D+3D
(rev 01)
00:09.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev
20)
00:0a.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev
20)

rgds,
tim.
--
