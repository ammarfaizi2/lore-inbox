Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263109AbUJ1WNn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263109AbUJ1WNn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 18:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263111AbUJ1WNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 18:13:43 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:34830 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263041AbUJ1WJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 18:09:25 -0400
Date: Fri, 29 Oct 2004 00:08:53 +0200
From: Adrian Bunk <bunk@stusta.de>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] ALSA: remove unused functions
Message-ID: <20041028220853.GH3207@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The patch below removes two unused ALSA functions.


diffstat output:
 sound/pci/cmipci.c             |    7 +------
 sound/pci/ymfpci/ymfpci_main.c |    5 -----
 2 files changed, 1 insertion(+), 11 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

- --- linux-2.6.10-rc1-mm1-full/sound/pci/cmipci.c.old	2004-10-28 23:48:17.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/sound/pci/cmipci.c	2004-10-28 23:48:38.000000000 +0200
@@ -499,17 +499,12 @@
 	return inw(cm->iobase + cmd);
 }
 
- -/* read/write operations for byte register */
+/* write operation for byte register */
 inline static void snd_cmipci_write_b(cmipci_t *cm, unsigned int cmd, unsigned char data)
 {
 	outb(data, cm->iobase + cmd);
 }
 
- -inline static unsigned char snd_cmipci_read_b(cmipci_t *cm, unsigned int cmd)
- -{
- -	return inb(cm->iobase + cmd);
- -}
- -
 /* bit operations for dword register */
 static void snd_cmipci_set_bit(cmipci_t *cm, unsigned int cmd, unsigned int flag)
 {
- --- linux-2.6.10-rc1-mm1-full/sound/pci/ymfpci/ymfpci_main.c.old	2004-10-28 23:49:00.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/sound/pci/ymfpci/ymfpci_main.c	2004-10-28 23:49:11.000000000 +0200
@@ -52,11 +52,6 @@
 
 static void snd_ymfpci_irq_wait(ymfpci_t *chip);
 
- -static inline u8 snd_ymfpci_readb(ymfpci_t *chip, u32 offset)
- -{
- -	return readb(chip->reg_area_virt + offset);
- -}
- -
 static inline void snd_ymfpci_writeb(ymfpci_t *chip, u32 offset, u8 val)
 {
 	writeb(val, chip->reg_area_virt + offset);

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBgW31mfzqmE8StAARArTeAJ9lT46xFgZ6muJjWM5wxD9JYYwMswCeN49M
ycYCKqQnXeVjf7cvX4fOsWA=
=U50D
-----END PGP SIGNATURE-----
