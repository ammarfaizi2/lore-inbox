Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760562AbWLFMrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760562AbWLFMrA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 07:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760566AbWLFMrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 07:47:00 -0500
Received: from gw-eur4.philips.com ([161.85.125.10]:22084 "EHLO
	gw-eur4.philips.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760562AbWLFMq7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 07:46:59 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: typo in init/initramfs.c
MIME-Version: 1.0
X-Mailer: Lotus Notes Release 6.0.3 September 26, 2003
Message-ID: <OF1FFE915F.B0D1E7ED-ONC125723C.00457279-C125723C.00463203@philips.com>
From: Jean-Paul Saman <jean-paul.saman@nxp.com>
Date: Wed, 6 Dec 2006 13:46:37 +0100
X-MIMETrack: Serialize by Router on ehvrmh02/H/SERVER/PHILIPS(Release 6.5.5HF805 | August
 26, 2006) at 06/12/2006 13:46:40,
	Serialize complete at 06/12/2006 13:46:40
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In populate_rootfs() the printk on line 554. It says "Unpacking 
initramfs..", which is confusing because if that line is reached the code 
has already decided that the image is an initrd image. The printk is thus 
wrong in stating that it is unpacking an "initramfs". It should says 
"initrd" instead. The attached patch corrects this typo.

Signed-off-by: Jean-Paul Saman <jean-paul.saman@nxp.com>

diff --git a/init/initramfs.c b/init/initramfs.c
index d28c109..f6020db 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -551,7 +551,7 @@ #ifdef CONFIG_BLK_DEV_RAM
                        free_initrd();
                }
 #else
-               printk(KERN_INFO "Unpacking initramfs...");
+              printk(KERN_INFO "Unpacking initrd...");
                err = unpack_to_rootfs((char *)initrd_start,
                        initrd_end - initrd_start, 0);
                if (err)

-
Kind greetings,

Jean-Paul Saman

NXP Semiconductors CTO/RTG DesignIP/OKC
