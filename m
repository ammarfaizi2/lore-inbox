Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272665AbTHELdz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 07:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272670AbTHELdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 07:33:55 -0400
Received: from verein.lst.de ([212.34.189.10]:30123 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S272665AbTHELdy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 07:33:54 -0400
Date: Tue, 5 Aug 2003 13:33:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] simplify i386 mca Kconfig bits
Message-ID: <20030805113351.GA23754@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, James.Bottomley@steeleye.com,
	linux-kernel@vger.kernel.org
References: <20030805113154.GA23728@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030805113154.GA23728@lst.de>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4 () IN_REP_TO,PATCH_UNIFIED_DIFF,REFERENCES,USER_AGENT_MUTT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I should better attach the patch :)


diff -Nru a/include/linux/mca.h b/include/linux/mca.h
--- a/include/linux/mca.h	Sun Jul 13 05:23:15 2003
+++ b/include/linux/mca.h	Sun Jul 13 05:23:15 2003
@@ -10,9 +10,9 @@
  * included mca.h to compile.  Take it out later when the MCA #includes
  * are sorted out */
 #include <linux/device.h>
-
-/* get the platform specific defines */
+#ifdef CONFIG_MCA
 #include <asm/mca.h>
+#endif
 
 /* The detection of MCA bus is done in the real mode (using BIOS).
  * The information is exported to the protected code, where this
