Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266790AbUHOPEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266790AbUHOPEw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 11:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266781AbUHOPC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 11:02:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25822 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266763AbUHOPBt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 11:01:49 -0400
Date: Sun, 15 Aug 2004 11:00:52 -0400
From: Alan Cox <alan@redhat.com>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: restore raw_taskfile in hwif_restore
Message-ID: <20040815150052.GA11639@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.8-rc3/drivers/ide/ide.c linux-2.6.8-rc3/drivers/ide/ide.c
--- linux.vanilla-2.6.8-rc3/drivers/ide/ide.c	2004-08-09 15:51:00.000000000 +0100
+++ linux-2.6.8-rc3/drivers/ide/ide.c	2004-08-12 17:55:05.000000000 +0100
@@ -618,6 +710,7 @@
 	hwif->maskproc			= tmp_hwif->maskproc;
 	hwif->quirkproc			= tmp_hwif->quirkproc;
 	hwif->busproc			= tmp_hwif->busproc;
+	hwif->raw_taskfile		= tmp_hwif->raw_taskfile;
 
 	hwif->ata_input_data		= tmp_hwif->ata_input_data;
 	hwif->ata_output_data		= tmp_hwif->ata_output_data;

Signed-off-by: Alan Cox <alan@redhat.com>

