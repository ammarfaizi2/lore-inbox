Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262212AbSJQVoJ>; Thu, 17 Oct 2002 17:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262213AbSJQVoH>; Thu, 17 Oct 2002 17:44:07 -0400
Received: from fmr02.intel.com ([192.55.52.25]:47096 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S262212AbSJQVoC>; Thu, 17 Oct 2002 17:44:02 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C7806CAC7F0@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'justin T. Gibbs'" <gibbs@scsiguy.com>,
       "lkml (E-mail)" <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix Linux 2.5.43 build of aic7xxx
Date: Thu, 17 Oct 2002 14:49:47 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi there

Pretty simple patch, fixes [at least for me] the building of aic7xxx on
2.5.43

diff -u -r1.1.1.1 linux/drivers/scsi/aic7xxx/Makefile
--- linux/drivers/scsi/aic7xxx/Makefile	9 Oct 2002 02:47:02 -0000
+++ linux/drivers/scsi/aic7xxx/Makefile	17 Oct 2002 21:40:03 -0000
@@ -33,7 +33,7 @@
 $(obj)/aic7xxx_seq.h $(obj)/aic7xxx_reg.h: $(src)/aic7xxx.seq \
 					   $(src)/aic7xxx.reg \
 					   $(obj)/aicasm/aicasm
-	$(obj)/aicasm/aicasm -I. -r $(obj)/aic7xxx_reg.h \
+	$(obj)/aicasm/aicasm -I$(obj) -r $(obj)/aic7xxx_reg.h \
 				 -o $(obj)/aic7xxx_seq.h $(src)/aic7xxx.seq
 
 $(obj)/aicasm/aicasm: $(src)/aicasm/*.[chyl]

Inaky Perez-Gonzalez -- Not speaking for Intel - opinions are my own [or my
fault]


