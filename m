Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbTDHARc (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 20:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263829AbTDHAPc (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 20:15:32 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:21121
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263806AbTDGXWW (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 19:22:22 -0400
Date: Tue, 8 Apr 2003 01:41:12 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080041.h380fCEd009324@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: another C99 and version casd
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/i810_audio.c linux-2.5.67-ac1/sound/oss/i810_audio.c
--- linux-2.5.67/sound/oss/i810_audio.c	2003-03-26 20:00:02.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/i810_audio.c	2003-04-03 23:52:57.000000000 +0100
@@ -79,7 +79,6 @@
  */
  
 #include <linux/module.h>
-#include <linux/version.h>
 #include <linux/string.h>
 #include <linux/ctype.h>
 #include <linux/ioport.h>
@@ -2554,15 +2553,15 @@
 }
 
 static /*const*/ struct file_operations i810_audio_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	read:		i810_read,
-	write:		i810_write,
-	poll:		i810_poll,
-	ioctl:		i810_ioctl,
-	mmap:		i810_mmap,
-	open:		i810_open,
-	release:	i810_release,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= i810_read,
+	.write		= i810_write,
+	.poll		= i810_poll,
+	.ioctl		= i810_ioctl,
+	.mmap		= i810_mmap,
+	.open		= i810_open,
+	.release	= i810_release,
 };
 
 /* Write AC97 codec registers */
@@ -2690,10 +2689,10 @@
 }
 
 static /*const*/ struct file_operations i810_mixer_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	ioctl:		i810_ioctl_mixdev,
-	open:		i810_open_mixdev,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.ioctl		= i810_ioctl_mixdev,
+	.open		= i810_open_mixdev,
 };
 
 /* AC97 codec initialisation.  These small functions exist so we don't
@@ -3430,13 +3429,13 @@
 #define I810_MODULE_NAME "intel810_audio"
 
 static struct pci_driver i810_pci_driver = {
-	name:		I810_MODULE_NAME,
-	id_table:	i810_pci_tbl,
-	probe:		i810_probe,
-	remove:		__devexit_p(i810_remove),
+	.name		= I810_MODULE_NAME,
+	.id_table	= i810_pci_tbl,
+	.probe		= i810_probe,
+	.remove		= __devexit_p(i810_remove),
 #ifdef CONFIG_PM
-	suspend:	i810_pm_suspend,
-	resume:		i810_pm_resume,
+	.suspend	= i810_pm_suspend,
+	.resume		= i810_pm_resume,
 #endif /* CONFIG_PM */
 };
 
