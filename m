Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261620AbUK2C3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbUK2C3q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 21:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbUK2C3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 21:29:45 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:33549 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261620AbUK2C3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 21:29:37 -0500
Date: Mon, 29 Nov 2004 03:29:35 +0100
From: Adrian Bunk <bunk@stusta.de>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] ALSA: remove unused functions (fwd)
Message-ID: <20041129022935.GP4390@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch forwarded below still applies and compiles against 
2.6.10-rc2-mm3.

Please apply or comment on it.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Fri, 29 Oct 2004 02:14:04 +0200
From: Adrian Bunk <bunk@stusta.de>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] ALSA: remove unused functions

[ this time without the problems due to a digital signature... ]

The patch below removes two unused ALSA functions.


diffstat output:
 sound/pci/cmipci.c             |    7 +------
 sound/pci/ymfpci/ymfpci_main.c |    5 -----
 2 files changed, 1 insertion(+), 11 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm1-full/sound/pci/cmipci.c.old	2004-10-28 23:48:17.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/sound/pci/cmipci.c	2004-10-28 23:48:38.000000000 +0200
@@ -499,17 +499,12 @@
 	return inw(cm->iobase + cmd);
 }
 
-/* read/write operations for byte register */
+/* write operations for byte register */
 inline static void snd_cmipci_write_b(cmipci_t *cm, unsigned int cmd, unsigned char data)
 {
 	outb(data, cm->iobase + cmd);
 }
 
-inline static unsigned char snd_cmipci_read_b(cmipci_t *cm, unsigned int cmd)
-{
-	return inb(cm->iobase + cmd);
-}
-
 /* bit operations for dword register */
 static void snd_cmipci_set_bit(cmipci_t *cm, unsigned int cmd, unsigned int flag)
 {
--- linux-2.6.10-rc1-mm1-full/sound/pci/ymfpci/ymfpci_main.c.old	2004-10-28 23:49:00.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/sound/pci/ymfpci/ymfpci_main.c	2004-10-28 23:49:11.000000000 +0200
@@ -52,11 +52,6 @@
 
 static void snd_ymfpci_irq_wait(ymfpci_t *chip);
 
-static inline u8 snd_ymfpci_readb(ymfpci_t *chip, u32 offset)
-{
-	return readb(chip->reg_area_virt + offset);
-}
-
 static inline void snd_ymfpci_writeb(ymfpci_t *chip, u32 offset, u8 val)
 {
 	writeb(val, chip->reg_area_virt + offset);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

