Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265852AbTL3WYB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 17:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265823AbTL3WOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 17:14:33 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:3784 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S265852AbTL3WIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 17:08:41 -0500
Subject: [BK PATCH] SCSI updates
From: James Bottomley <James.Bottomley@steeleye.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 30 Dec 2003 16:08:32 -0600
Message-Id: <1072822114.1783.36.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This represents the driver updates and other fairly stable changes that
have been floating around in the SCSI trees for a while.  The only
controversial element is updating the aic7xxx/79xx drivers.  I've been
receiving reports that the 1.3.9 version of the aic79xx was
non-functional in 2.6, so I updated it to 1.3.11 based on Justin's tree
(after confirming with the reporters that this fixed their problems).

The tree is at

bk://linux-scsi.bkbits.net/scsi-for-linus

and the short changelog is:


<rask:sygehus.dk>:
  o aha1740.c: Allow level triggered interrupts to be shared

Andi Kleen:
  o Mark Ninja SCSI driver as !64BIT
  o Mark aha152x as ISA and !64BIT driver II
  o Mark correct aha152x driver (PCMCIA) as !64BIT
  o Fix 64bit warnings in BusLogic driver

Christoph Hellwig:
  o aacraid updates for new probing APIs
  o convert inia100 to new probing API

Douglas Gilbert:
  o sg Bugfixes
  o scsi_debug lk 2.6.0t6

James Bottomley:
  o Megaraid compile fix
  o Make aic7xxx -Werror conditional on make flag WARNINGS_BECOME_ERRORS
  o Update aic79xx to 1.3.11, aic7xxx to 6.2.36
  o Updated osst driver for 2.6.x
  o More Initio 9100u fixes
  o [v2] aha152x cmnd->device oops
  o SCSI: Fix tmscsim driver
  o Fix another sg mismerge
  o sg: fix hch/dougg mismerge
  o sg: char_devs + seq_file lk2.6.0t9
  o MPT Fusion driver 2.05.00.05 update
  o sym 2.1.18f

Kai Makisara:
  o Add char_devs to st This patch adds support for cdevs to the st
driver. The changes are based on Doug Gilbert's corresponding changes to
the sg driver. Using cdevs brings the following advantanges:

Mike Christie:
  o [RFC]  fix compile erros in ini9100 driver

Patrick Mansfield:
  o consolidate and log scsi command on send and completion

Randy Dunlap:
  o buslogic: use EH, remove some dup. docs
  o cpqfcTSinit cleanup

James



