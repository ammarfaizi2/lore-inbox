Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267321AbSLKWU1>; Wed, 11 Dec 2002 17:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267322AbSLKWU1>; Wed, 11 Dec 2002 17:20:27 -0500
Received: from air-2.osdl.org ([65.172.181.6]:3456 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S267321AbSLKWU1>;
	Wed, 11 Dec 2002 17:20:27 -0500
Date: Wed, 11 Dec 2002 14:28:10 -0800
From: Bob Miller <rem@osdl.org>
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL PATCH 2.5.51] Remove compile warning from  drivers/ide/pci/cs5520.c
Message-ID: <20021211222810.GA1067@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The function, cs5520_tune_chipset() is declared to return an int.
Added a return statement instead of just falling of off the bottom.

diff -Nru a/drivers/ide/pci/cs5520.c b/drivers/ide/pci/cs5520.c
--- a/drivers/ide/pci/cs5520.c	Wed Dec 11 13:41:51 2002
+++ b/drivers/ide/pci/cs5520.c	Wed Dec 11 13:41:51 2002
@@ -166,6 +166,8 @@
 	/* ATAPI is harder so leave it for now */
 	if(!error && drive->media == ide_disk)
 		error = hwif->ide_dma_on(drive);
+
+	return error;
 }	
 	
 static void cs5520_tune_drive(ide_drive_t *drive, u8 pio)

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
