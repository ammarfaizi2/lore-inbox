Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261581AbVB1M6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbVB1M6Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 07:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbVB1M6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 07:58:24 -0500
Received: from imag.imag.fr ([129.88.30.1]:61641 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S261581AbVB1M6E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 07:58:04 -0500
Message-ID: <1109595479.422315570842d@webmail.imag.fr>
Date: Mon, 28 Feb 2005 13:57:59 +0100
From: colbuse@ensisun.imag.fr
To: linux-kernel@vger.kernel.org
Cc: akpm@zip.com.au
Subject: [patch 3/2] drivers/char/vt.c: remove unnecessary code
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 193.49.124.107
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (imag.imag.fr [129.88.30.1]); Mon, 28 Feb 2005 13:58:00 +0100 (CET)
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



We could change an affectation into an incrementation by this patch, and,
so far I know, incrementing is quicker than or as quick as setting
a variable (depends on the architecture).

Please _don't_ apply this, but tell me what you think about it.
Note that npar is unsigned.

Signed-off-by: Emmanuel Colbus <emmanuel.colbus@ensimag.imag.fr>

--- old/drivers/char/vt.c       2004-12-24 22:35:25.000000000 +0100
+++ new/drivers/char/vt.c       2005-02-28 12:53:57.933256631 +0100
@@ -1655,9 +1655,9 @@
                        vc_state = ESnormal;
                return;
        case ESsquare:
-               for(npar = 0 ; npar < NPAR ; npar++)
+               for(npar = NPAR-1; npar < NPAR; npar--)
                        par[npar] = 0;
+               npar++;
-               npar = 0;
                vc_state = ESgetpars;
                if (c == '[') { /* Function key */
                        vc_state=ESfunckey;


--
Emmanuel Colbus
Club GNU/Linux
ENSIMAG - departement telecoms


-------------------------------------------------
envoyé via Webmail/IMAG !

