Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262143AbVERJk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262143AbVERJk6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 05:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262142AbVERJk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 05:40:58 -0400
Received: from odin2.bull.net ([192.90.70.84]:61414 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S262143AbVERJkv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 05:40:51 -0400
Subject: Broken scsi on 2.6.12rc4 + realtime-preempt-2.6.12-rc4-V0.7.47-03
	( adaptec aic7901a and lsi 53c1030 fusion-mpt )
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: BTS
Message-Id: <1116408679.3391.48.camel@ibiza.btsn.frna.bull.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-5.1.100mdk 
Date: Wed, 18 May 2005 11:31:19 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel with the realtime-preempt-2.6.12-rc4-V0.7.47-03 patch works
well on IDE.
I have a cannot open root device at boot on two machines ( i386 ) with
aic79xx or LSI controler.
If I suppress the realtime patch, it works.
I tried to set different options for realtime without success.

On the first machine  with LSI :
The lspci command shows :
...
04:03.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 PCI-X
Fusion-MPT Dual Ultra320 SCSI (rev 07)
04:03.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 PCI-X
Fusion-MPT Dual Ultra320 SCSI (rev 07)
...

On the second one with adaptec :
The lspci command shows :
...
03:05.0 SCSI storage controller: Adaptec AIC-7901A U320 (rev 03)
...

During boot the following error occurs :
...
VFS: Cannot open root device "0806" or unknown-block(8,6)
Please append a correct "root=" boot option
Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(8,6)

Any idea ?
I can send more info.

