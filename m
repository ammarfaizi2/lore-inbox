Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261732AbTCLPhV>; Wed, 12 Mar 2003 10:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261734AbTCLPhU>; Wed, 12 Mar 2003 10:37:20 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:15826 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP
	id <S261732AbTCLPhT>; Wed, 12 Mar 2003 10:37:19 -0500
Date: Wed, 12 Mar 2003 16:47:13 +0100 (CET)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: alan@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][TRIVIAL] Linux 2.4.21pre5-ac3 - remove unused var in ide-proc.c
In-Reply-To: <200303121500.h2CF0U2F000852@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.4.51.0303121645130.10932@dns.toxicfilms.tv>
References: <200303121500.h2CF0U2F000852@81-2-122-30.bradfords.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Linux 2.4.21pre5-ac3

(ide_driver_t *) drive->driver is called in the sprintf instead of
ide_driver_t *driver, so the var is not necessary.


--- linux-2.4.20/drivers/ide/ide-proc.c~	2003-03-12 16:13:36.000000000 +0100
+++ linux-2.4.20/drivers/ide/ide-proc.c	2003-03-12 16:39:08.000000000 +0100
@@ -623,7 +623,6 @@
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
 	ide_drive_t	*drive = (ide_drive_t *) data;
-	ide_driver_t    *driver = (ide_driver_t *) drive->driver;
 	int		len;

 	len = sprintf(page,"%llu\n",
