Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932292AbVJQM5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbVJQM5d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 08:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbVJQM5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 08:57:33 -0400
Received: from xproxy.gmail.com ([66.249.82.199]:40144 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932292AbVJQM5c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 08:57:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=QZ2FZiiiGL3UyzdeV2YxaFdXRNzsOyXlM352ePbUuO3CouG8Y57J5BSs41dn1gSkwDXu0nmslq5gIK6CyXaqrqvTY/wPgEbG1DUsnT3m+KiMpD7k6e8yNxZtD/1lshVbAq0X97cu4NMnlB6AhNsLPpwGsqQfUhI1tCQQEnH9qy8=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] EDAC: make default 'Y' to match Kconfig recommendation
Date: Mon, 17 Oct 2005 15:00:36 +0200
User-Agent: KMail/1.8.2
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510171500.36350.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The help text for EDAC has a clear "If unsure, select 'Y'" note, yet the
default is 'N' - that doesn't add up.
This patch makes DEAC default to 'Y' to match the recommendation.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/edac/Kconfig |    1 +
 1 files changed, 1 insertion(+)

--- linux-2.6.14-rc4-mm1-orig/drivers/edac/Kconfig	2005-10-17 12:00:36.000000000 +0200
+++ linux-2.6.14-rc4-mm1/drivers/edac/Kconfig	2005-10-17 14:55:28.000000000 +0200
@@ -10,6 +10,7 @@
 
 config EDAC
 	tristate "EDAC core system error reporting"
+	default y
 	help
 	  EDAC is designed to report errors in the core system.
 	  These are low-level errors that are reported in the CPU or



