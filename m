Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263741AbUD0D6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263741AbUD0D6J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 23:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263746AbUD0D6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 23:58:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:25216 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263741AbUD0D6G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 23:58:06 -0400
Date: Mon, 26 Apr 2004 20:57:11 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: rusty@rustcorp.com.au, akpm <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] doc: specifiying module parameters
Message-Id: <20040426205711.64b7e72c.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


// linux-266-rc2
// kernel-parameters.txt doc. only:  add info on how to specify
//	loadable module parameters vs. built-in module parameters

diffstat:=
 Documentation/kernel-parameters.txt |   11 +++++++++++
 1 files changed, 11 insertions(+)


diff -Naurp ./Documentation/kernel-parameters.txt~doc_module_prms ./Documentation/kernel-parameters.txt
--- ./Documentation/kernel-parameters.txt~doc_module_prms	2004-04-03 19:38:27.000000000 -0800
+++ ./Documentation/kernel-parameters.txt	2004-04-26 20:06:31.000000000 -0700
@@ -6,6 +6,17 @@ The following is a consolidated list of 
 (defined as ignoring all punctuation and sorting digits before letters in a
 case insensitive manner), and with descriptions where known.
 
+Module parameters for loadable modules are specified only as the
+parameter name with optional '=' and value as appropriate, such as:
+
+	modprobe usbcore blinkenlights=1
+
+Module parameters for modules that are built into the kernel image
+are specified on the kernel command line with the module name plus
+'.' plus parameter name, with '=' and value if appropriate, such as:
+
+	usbcore.blinkenlights=1
+
 The text in square brackets at the beginning of the description state the
 restrictions on the kernel for the said kernel parameter to be valid. The
 restrictions referred to are that the relevant option is valid if:


--
