Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751037AbWJETsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbWJETsl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 15:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbWJETsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 15:48:41 -0400
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:21664 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1751037AbWJETsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 15:48:40 -0400
To: balagi@justmail.de
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "akpm@osdl.org" <akpm@osdl.org>
Subject: Re: [PATCH 7/11] 2.6.18-mm3 pktcdvd: make procfs interface optional
References: <op.tguqh5r2iudtyh@master>
From: Peter Osterlund <petero2@telia.com>
Date: 05 Oct 2006 21:48:29 +0200
In-Reply-To: <op.tguqh5r2iudtyh@master>
Message-ID: <m3k63emtma.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Thomas Maier" <balagi@justmail.de> writes:

> this patch makes the procfs interface optional and groups
> the procfs functions together.
> New kernel config parameter: CDROM_PKTCDVD_PROCINTF

The Kconfig help text update looks good (slightly modified). Andrew,
please apply:


From: Thomas Maier <balagi@justmail.de>

pktcdvd: Update Kconfig help text.

Signed-off-by: Thomas Maier <balagi@justmail.de>
Signed-off-by: Peter Osterlund <petero2@telia.com>

---

 drivers/block/Kconfig |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 17dc222..f7eb08b 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -429,14 +429,18 @@ config CDROM_PKTCDVD
 	tristate "Packet writing on CD/DVD media"
 	depends on !UML
 	help
-	  If you have a CDROM drive that supports packet writing, say Y to
-	  include preliminary support. It should work with any MMC/Mt Fuji
-	  compliant ATAPI or SCSI drive, which is just about any newer CD
-	  writer.
+	  If you have a CDROM/DVD drive that supports packet writing, say
+	  Y to include support. It should work with any MMC/Mt Fuji
+	  compliant ATAPI or SCSI drive, which is just about any newer
+	  DVD/CD writer.
 
-	  Currently only writing to CD-RW, DVD-RW and DVD+RW discs is possible.
+	  Currently only writing to CD-RW, DVD-RW, DVD+RW and DVDRAM discs
+	  is possible.
 	  DVD-RW disks must be in restricted overwrite mode.
 
+	  See the file <file:Documentation/cdrom/packet-writing.txt>
+	  for further information on the use of this driver.
+
 	  To compile this driver as a module, choose M here: the
 	  module will be called pktcdvd.
 

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
