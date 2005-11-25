Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161087AbVKYOKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161087AbVKYOKd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 09:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161091AbVKYOKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 09:10:33 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:12504 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161087AbVKYOKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 09:10:32 -0500
Subject: Assorted bugs in the PIIX drivers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 25 Nov 2005 14:43:28 +0000
Message-Id: <1132929808.3298.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I finally got all the documents rounded up to try and redo Jgarzik's
PIIX driver a bit more completely (I'm short MPIIX if anyone has it ?)

I then started reading the docs and the code and noticing a couple of
problems

1.	We set IE1 on PIO0-2 which the docs say is for PIO3+

2.	The ata_piix one (but not the ide/pci one) have shifts wrong so that
the secondary slave timings are half loaded into the primary slave


I'm also not clear if the "no MWDMA0" list has been updated correctly
for the newer chipsets.

I've yet to review the DMA programming, just the PIO so far.

