Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265470AbTBPAl4>; Sat, 15 Feb 2003 19:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265480AbTBPAl4>; Sat, 15 Feb 2003 19:41:56 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:42720 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S265470AbTBPAlz>; Sat, 15 Feb 2003 19:41:55 -0500
Date: Sun, 16 Feb 2003 01:51:01 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] pcmcia: small bugfix & cleanup
Message-ID: <20030216005101.GA6758@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded function declarations and correct /proc-directory name for
> 1 pcmcia_socket_class devices.

	Dominik

diff -ruN linux-original/drivers/pcmcia/cs.c linux-pcmcia/drivers/pcmcia/cs.c
--- linux-original/drivers/pcmcia/cs.c	2003-02-16 01:28:50.000000000 +0100
+++ linux-pcmcia/drivers/pcmcia/cs.c	2003-02-16 01:30:04.000000000 +0100
@@ -356,7 +356,7 @@
 #ifdef CONFIG_PROC_FS
 		if (proc_pccard) {
 			char name[3];
-			sprintf(name, "%02d", i);
+			sprintf(name, "%02d", j);
 			s->proc = proc_mkdir(name, proc_pccard);
 			if (s->proc)
 				s->ss_entry->proc_setup(i, s->proc);
diff -ruN linux-original/drivers/pcmcia/pci_socket.c linux-pcmcia/drivers/pcmcia/pci_socket.c
--- linux-original/drivers/pcmcia/pci_socket.c	2003-02-16 01:28:50.000000000 +0100
+++ linux-pcmcia/drivers/pcmcia/pci_socket.c	2003-02-16 01:28:16.000000000 +0100
@@ -31,9 +31,6 @@
 #include "pci_socket.h"
 
 
-extern struct socket_info_t *pcmcia_register_socket (int slot,
-		struct pccard_operations *vtable, int use_bus_pm);
-extern void pcmcia_unregister_socket (struct socket_info_t *socket);
 extern void pcmcia_suspend_socket (struct socket_info_t *socket);
 extern void pcmcia_resume_socket (struct socket_info_t *socket);
 
