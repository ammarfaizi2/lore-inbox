Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264132AbTKZKry (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 05:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264141AbTKZKry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 05:47:54 -0500
Received: from hazard.jcu.cz ([160.217.1.6]:14747 "EHLO hazard.jcu.cz")
	by vger.kernel.org with ESMTP id S264132AbTKZKrs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 05:47:48 -0500
Date: Wed, 26 Nov 2003 11:47:46 +0100
From: Jan Marek <linux@hazard.jcu.cz>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH][TRIVIAL] 2.6.0-test[9,10] Bug (typo) in smsc-ircc2.c
Message-ID: <20031126104746.GA31328@hazard.jcu.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hallo l-k,

I have patch, which repair small, but important bug in smsc-ircc2.c.

Without this patch driver tried release one region twice.

Please apply...

Sincerely
Jan Marek
-- 
Ing. Jan Marek
University of South Bohemia
Academic Computer Centre
Phone: +420-38-7772080

--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="smsc-ircc2.c.diff"

--- linux-2.6.0-test9/drivers/net/irda/smsc-ircc2.c	2003-10-25 20:43:57.000000000 +0200
+++ linux-2.6.0-test9-new/drivers/net/irda/smsc-ircc2.c	2003-11-05 23:07:37.000000000 +0100
@@ -524,7 +524,7 @@
 
 	return 0;
  out3:
-	release_region(fir_base, SMSC_IRCC2_FIR_CHIP_IO_EXTENT);
+	release_region(sir_base, SMSC_IRCC2_SIR_CHIP_IO_EXTENT);
  out2:
 	release_region(fir_base, SMSC_IRCC2_FIR_CHIP_IO_EXTENT);
  out1:

--ZPt4rx8FFjLCG7dd--
