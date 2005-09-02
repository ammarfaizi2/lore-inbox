Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161061AbVIBVpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161061AbVIBVpA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 17:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161062AbVIBVpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 17:45:00 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:25734 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1161061AbVIBVo7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 17:44:59 -0400
Date: Fri, 2 Sep 2005 23:44:54 +0200
Message-Id: <200509022144.j82LisdZ031334@wscnet.wsc.cz>
In-reply-to: <200509022122.j82LMMwV030426@wscnet.wsc.cz>
Subject: [PATCH 6/6] include, sound: pci_find_device remove (s/pci/via82xx.c)
From: Jiri Slaby <jirislaby@gmail.com>
To: Greg KH <gregkh@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, alsa-devel@alsa-project.org,
       perex@suse.cz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Generated in 2.6.13-mm1 kernel version.

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

 via82xx.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/via82xx.c b/sound/pci/via82xx.c
--- a/sound/pci/via82xx.c
+++ b/sound/pci/via82xx.c
@@ -1933,11 +1933,12 @@ static int snd_via82xx_chip_init(via82xx
 		 * DXS channels don't work properly with VRA if MC97 is disabled.
 		 */
 		struct pci_dev *pci;
-		pci = pci_find_device(0x1106, 0x3068, NULL); /* MC97 */
+		pci = pci_get_device(0x1106, 0x3068, NULL); /* MC97 */
 		if (pci) {
 			unsigned char data;
 			pci_read_config_byte(pci, 0x44, &data);
 			pci_write_config_byte(pci, 0x44, data | 0x40);
+			pci_dev_put(pci);
 		}
 	}
 
