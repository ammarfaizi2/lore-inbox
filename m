Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965154AbWECLfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965154AbWECLfh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 07:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965155AbWECLfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 07:35:37 -0400
Received: from server6.greatnet.de ([83.133.96.26]:61395 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP id S965154AbWECLfg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 07:35:36 -0400
Message-ID: <445896E1.4000000@nachtwindheim.de>
Date: Wed, 03 May 2006 13:41:21 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060411)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Update an code example
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henrik Kretzschmar <henne@nachtwindheim.de>

Update an example function in the deviceiobook to be in sync with
actual qla1280c .
The change in the driver happend in Aug-2005 and is a bit clearer.
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>
---

--- linux-2.6.17-rc3/Documentation/DocBook/deviceiobook.tmpl	2006-04-27 08:39:13.000000000 +0200
+++ linux/Documentation/DocBook/deviceiobook.tmpl	2006-04-30 15:18:02.000000000 +0200
@@ -176,18 +176,13 @@
  static inline void
  qla1280_disable_intrs(struct scsi_qla_host *ha)
  {
-	struct device_reg *reg;
-
-	reg = ha->iobase;
-	/* disable risc and host interrupts */
-	WRT_REG_WORD(&amp;reg->ictrl, 0);
+	WRT_REG_WORD(&amp;ha->iobase->ictrl, 0);
  	/*
  	 * The following read will ensure that the above write
  	 * has been received by the device before we return from this
  	 * function.
  	 */
-	RD_REG_WORD(&amp;reg->ictrl);
-	ha->flags.ints_enabled = 0;
+	RD_REG_WORD(&amp;ha->iobase->ictrl);
  }
  </programlisting>

