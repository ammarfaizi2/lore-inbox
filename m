Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261519AbSJMNF4>; Sun, 13 Oct 2002 09:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261520AbSJMNF4>; Sun, 13 Oct 2002 09:05:56 -0400
Received: from steve.prima.de ([62.72.84.2]:25227 "HELO steve.prima.de")
	by vger.kernel.org with SMTP id <S261519AbSJMNFy>;
	Sun, 13 Oct 2002 09:05:54 -0400
Date: Sun, 13 Oct 2002 15:11:27 +0200
From: Patrick Mau <mau@oscar.prima.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Compile fix for current 2.5 BK.
Message-ID: <20021013131127.GA29158@oscar.homelinux.net>
Reply-To: Patrick Mau <mau@oscar.prima.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,

I need the patch below to make the scsi subsystem compile on
my machine. It's against a bk 2.5 snapshot of today.

Please apply,
Patrick

--- ./bk-2.5/include/scsi/scsi_ioctl.h	2002-10-13 15:07:52.000000000 +0200
+++ ./copy/include/scsi/scsi_ioctl.h	2002-10-13 15:02:25.000000000 +0200
@@ -39,11 +39,11 @@
 	unsigned char host_wwn[8]; // include NULL term.
 } Scsi_FCTargAddress;
 
+extern int scsi_set_medium_removal(Scsi_Device *dev, char state);
 extern int scsi_ioctl (Scsi_Device *dev, int cmd, void *arg);
 extern int kernel_scsi_ioctl (Scsi_Device *dev, int cmd, void *arg);
 extern int scsi_ioctl_send_command(Scsi_Device *dev,
 				   Scsi_Ioctl_Command *arg);
-
 #endif
 
 #endif

