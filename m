Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751487AbWIXWkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbWIXWkE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 18:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbWIXWkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 18:40:04 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:39365 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751400AbWIXWkD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 18:40:03 -0400
Date: Sun, 24 Sep 2006 23:40:00 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] libata won't build on m68k and m32r
Message-ID: <20060924224000.GV29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

no ioread*(), for one thing

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/ata/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 5a8bdac..702fcc3 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -6,6 +6,7 @@ menu "Serial ATA (prod) and Parallel ATA
 
 config ATA
 	tristate "ATA device support"
+	depends on !(M32R || M68K) || BROKEN
 	select SCSI
 	---help---
 	  If you want to use a ATA hard disk, ATA tape drive, ATA CD-ROM or
-- 
1.4.2.GIT
