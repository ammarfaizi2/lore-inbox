Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263418AbTJBRFf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 13:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263423AbTJBRFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 13:05:34 -0400
Received: from cpc3-hitc2-5-0-cust152.lutn.cable.ntl.com ([81.99.82.152]:41963
	"EHLO zog.reactivated.net") by vger.kernel.org with ESMTP
	id S263418AbTJBRFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 13:05:23 -0400
Message-ID: <3F7C5AF0.40103@reactivated.net>
Date: Thu, 02 Oct 2003 18:05:52 +0100
From: Daniel Drake <dan@reactivated.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030905 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mcalinux@acc.umu.se
Cc: tao@acc.umu.se, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: [PATCH] (2.6.0-test6) MCA: Janitorial
Content-Type: multipart/mixed;
 boundary="------------050601020703040205030604"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050601020703040205030604
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Quick janitorial work:

Janitorial updates, to remove a DocBook warning from "make htmldocs",
to fix a layout problem in DocBook's interpretation of the source.

Added description of pos parameter to mca_read_and_store_pos() (mca.c) function in order to remove a DocBook warning,
and updated the annotation to reflect the correct function name.

Removed a colon from annotation in mca_dma.h, because DocBook was incorrectly processing the line "set are:" as a heading.

Patch attached and available from
http://www.reactivated.net/patches/linux-kernel/2.6.0-test6/mca-janitorial.patch

Daniel.

--------------050601020703040205030604
Content-Type: text/plain;
 name="mca-janitorial.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mca-janitorial.patch"

--- linux-2.6.0-test6/arch/i386/kernel/mca.c	2003-09-28 11:34:13.000000000 +0100
+++ linux/arch/i386/kernel/mca.c	2003-10-02 16:59:44.660172168 +0100
@@ -132,7 +132,8 @@
 #define MCA_STANDARD_RESOURCES	(sizeof(mca_standard_resources)/sizeof(struct resource))
 
 /**
- *	mca_read_pos - read the POS registers into a memory buffer
+ *	mca_read_and_store_pos - read the POS registers into a memory buffer
+ *	@pos: The POS registers to read from
  *
  *	Returns 1 if a card actually exists (i.e. the pos isn't
  *	all 0xff) or 0 otherwise

--- linux-2.6.0-test6/include/asm-i386/mca_dma.h	2003-09-28 11:34:13.000000000 +0100
+++ linux/include/asm-i386/mca_dma.h	2003-10-02 17:03:20.895299432 +0100
@@ -181,7 +181,7 @@
  *	@mode: mode to set
  *
  *	The DMA controller supports several modes. The mode values you can
- *	set are :
+ *	set are
  *
  *	%MCA_DMA_MODE_READ when reading from the DMA device.
  *

--------------050601020703040205030604--

