Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbVIRGpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbVIRGpo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 02:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbVIRGpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 02:45:44 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:13800
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751161AbVIRGpn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 02:45:43 -0400
Date: Sat, 17 Sep 2005 23:45:19 -0700 (PDT)
Message-Id: <20050917.234519.130676096.davem@davemloft.net>
To: kloczek@rudy.mif.pg.gda.pl
Cc: davem@redhat.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
       aurora-sparc-devel@lists.auroralinux.org
Subject: Re: [2.6.14-rc1/sparc54]: BUG: soft lockup detected on CPU#0!
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.BSO.4.62.0509171945280.5000@rudy.mif.pg.gda.pl>
References: <20050916.155919.41629794.davem@redhat.com>
	<Pine.BSO.4.62.0509171707410.5000@rudy.mif.pg.gda.pl>
	<Pine.BSO.4.62.0509171945280.5000@rudy.mif.pg.gda.pl>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz K³oczko <kloczek@rudy.mif.pg.gda.pl>
Date: Sat, 17 Sep 2005 19:49:17 +0200 (CEST)

> Something new.
> I'm just finish rewrite backup procedure from dumping to NFS volume to
> using piped dump|ssh|dd.
> During this happens:
> 
> PSYCHO0: Uncorrectable Error, primary error type[DMA Write]
> PSYCHO0: bytemask[0000] dword_offset[7] UPA_MID[1f] was_block(1)
> PSYCHO0: UE AFAR [000000005c8bc040]
> PSYCHO0: UE Secondary errors [(DMA Write)]
> PSYCHO0: IOMMU Error, type[Protection Error]

A driver unmapped a DMA area while the device is still
accessing it.  If you're still using the cassini card,
it's driver is the most likely suspect.
