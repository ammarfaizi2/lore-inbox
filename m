Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbTFXROY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 13:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262299AbTFXROX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 13:14:23 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:34002 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262562AbTFXROT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 13:14:19 -0400
Date: Tue, 24 Jun 2003 19:28:21 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: dmo@osdl.org
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [2.5 patch] postfix a constant in DAC960.h with ULL
Message-ID: <20030624172821.GS3710@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below postfixes a constant in DAC960.h with ULL, on 32 bit
archs this constant is too big for an int.


Please apply
Adrian

--- linux-2.5.73-not-full/drivers/block/DAC960.h.old	2003-06-23 21:38:16.000000000 +0200
+++ linux-2.5.73-not-full/drivers/block/DAC960.h	2003-06-23 21:38:34.000000000 +0200
@@ -65,7 +65,7 @@
  */
 
 #define DAC690_V1_PciDmaMask	0xffffffff
-#define DAC690_V2_PciDmaMask	0xffffffffffffffff
+#define DAC690_V2_PciDmaMask	0xffffffffffffffffULL
 
 /*
   Define a Boolean data type.
