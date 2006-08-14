Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751588AbWHNQtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588AbWHNQtN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 12:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWHNQtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 12:49:13 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:56021 "EHLO
	fmmailgate01.web.de") by vger.kernel.org with ESMTP
	id S1751588AbWHNQtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 12:49:13 -0400
Message-ID: <44E0A98D.9040203@web.de>
Date: Mon, 14 Aug 2006 18:49:17 +0200
From: "jens m. noedler" <noedler@web.de>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] [resend] update Documentation/kernel-parameters.txt
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is just a little documentation update which applies to 2.6.18-rc4.
The patch was first send on 27. July 2006 to the LKML but nobody picked
it up, so here is the second chance. :-)

By the way: Does anybody know _why_ COMMAND_LINE_SIZE depends
on the architecture? Wouldn't it make sense to generalize it
for all platforms to e.g. 2048 characters?

Kind regards, Jens


Signed-off-by: jens m. noedler <noedler@web.de>

---

--- linux/Documentation/kernel-parameters.txt.orig	2006-08-13 23:40:31.000000000 +0200
+++ linux/Documentation/kernel-parameters.txt	2006-08-13 23:40:55.000000000 +0200
@@ -110,6 +110,13 @@ be entered as an environment variable, w
 it will appear as a kernel argument readable via /proc/cmdline by programs
 running once the system is up.
 
+The number of kernel parameters is not limited, but the length of the
+complete command line (parameters including spaces etc.) is limited to
+a fixed number of characters. This limit depends on the architecture
+and is between 256 and 4096 characters. It is defined in the file
+./include/asm/setup.h as COMMAND_LINE_SIZE.
+
+
 	53c7xx=		[HW,SCSI] Amiga SCSI controllers
 			See header of drivers/scsi/53c7xx.c.
 			See also Documentation/scsi/ncr53c7xx.txt.


-- 
jens m. noedler
  noedler@web.de
  pgp: 0x9f0920bb
  http://noedler.de



