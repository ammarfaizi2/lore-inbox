Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964879AbWFSUwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964879AbWFSUwr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 16:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWFSUwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 16:52:47 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:1962 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932308AbWFSUwq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 16:52:46 -0400
Subject: Re: PATA driver patch for 2.6.17
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: furlongm@hotmail.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <e76uv1$g1s$1@sea.gmane.org>
References: <1150740947.2871.42.camel@localhost.localdomain>
	 <e76uv1$g1s$1@sea.gmane.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 19 Jun 2006 22:07:58 +0100
Message-Id: <1150751279.2871.46.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-06-19 am 20:46 +0100, ysgrifennodd Marcus Furlong:
> Alan Cox wrote:
> 
> > http://zeniv.linux.org.uk/~alan/IDE
> > 
> > This is basically a resync versus 2.6.17, the head of the PATA tree is
> > now built against Jeffs tree with revised error handling and the like.
> > 
> > Alan
> 
> I get the following bug while booting: 

Sorry about that. I messed up a patch segment in the merge

--- drivers/scsi/ata_piix.c~	2006-06-19 21:38:43.746144712 +0100
+++ drivers/scsi/ata_piix.c	2006-06-19 21:38:43.747144560 +0100
@@ -360,6 +360,8 @@
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 
+	.data_xfer		= ata_pio_data_xfer,
+
 	.eng_timeout		= ata_eng_timeout,
 
 	.irq_handler		= ata_interrupt,

