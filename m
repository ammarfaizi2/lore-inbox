Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261579AbVB1MzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbVB1MzI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 07:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbVB1MzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 07:55:07 -0500
Received: from imag.imag.fr ([129.88.30.1]:35017 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S261579AbVB1MzB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 07:55:01 -0500
Message-ID: <1109595069.422313bd9f782@webmail.imag.fr>
Date: Mon, 28 Feb 2005 13:51:09 +0100
From: colbuse@ensisun.imag.fr
To: linux-kernel@vger.kernel.org
Cc: akpm@zip.com.au
Subject: [Patch 1/2] drivers/char/vt.c: remove unnecessary code
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 193.49.124.107
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (imag.imag.fr [129.88.30.1]); Mon, 28 Feb 2005 13:51:12 +0100 (CET)
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In the palette escape sequence, setting the elems of par[] at 0 is not needed,
since its values are every time overwritten in this case.

Signed-off-by: Emmanuel Colbus <emmanuel.colbus@ensimag.imag.fr>

--- old/drivers/char/vt.c       2004-12-24 22:35:25.000000000 +0100
+++ new/drivers/char/vt.c       2005-02-28 12:51:43.910651512 +0100
@@ -1626,8 +1626,6 @@
                return;
        case ESnonstd:
                if (c=='P') {   /* palette escape sequence */
-                       for (npar=0; npar<NPAR; npar++)
-                               par[npar] = 0 ;
                        npar = 0 ;
                        vc_state = ESpalette;
                        return;


--
Emmanuel Colbus
Club GNU/Linux
ENSIMAG - departement telecoms



-------------------------------------------------
envoyé via Webmail/IMAG !

