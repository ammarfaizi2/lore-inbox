Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317246AbSEXSrQ>; Fri, 24 May 2002 14:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314829AbSEXSrP>; Fri, 24 May 2002 14:47:15 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61198 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314811AbSEXSrO>; Fri, 24 May 2002 14:47:14 -0400
Subject: Linux I2O Status
To: linux-kernel@vger.kernel.org
Date: Fri, 24 May 2002 20:07:52 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17BKPo-00078P-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I asked folks to avoid touching the I2O stuff in 2.5 because major surgery
and work was needed in 2.4 before even tackling 2.5

The 2.4.19pre8-ac5  status is:

-	The i2o_pci layer has been cleaned up massively and might well
	be both 32/64bit clean
-	The i2o_block layer has been half rewritten to deal with firmware
	bugs now that the I/O layers can hand down blocks of 64K or more
-	The i2o_core should be pretty clean. 
-	The i2o_scsi layer is still not 64bit clean and still uses the old
	eh code. Basically it needs the same work as the other scsi drivers
	plus some pointer into 32bit message field abuses fixing

On x86 32bit it is all stable again and now works on my DPT and on the
AMI Megaraid as well as the cards it handled before. Block caching strategy
is now configurable.

I still have to do the pci mapping and try and find the rest of the
64bit bogons, however the core code is now in a shape where it ought to be
possible to move it forward into 2.5 if anyone with i2o kit feels the urge.

I'll look at the SCSI 64bit cleanness and PCI mapping over time. They are not
priority items to me right now (at least until AMD Hammer hits the mass
market)

Alan


