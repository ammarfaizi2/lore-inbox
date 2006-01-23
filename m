Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbWAWQMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbWAWQMY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 11:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWAWQMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 11:12:24 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:37511 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S932306AbWAWQMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 11:12:23 -0500
Date: Mon, 23 Jan 2006 13:36:23 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: akpm <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm: Fixes sparse warnings in via_dmablit.c.
Message-Id: <20060123133623.475aea95.lcapitulino@mandriva.com.br>
Organization: Mandriva
X-Mailer: Sylpheed version 2.2.0beta4 (GTK+ 2.8.10; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Fixes the following sparse warnings:

 drivers/char/drm/via_dmablit.c:111:35: warning: Using plain integer as NULL pointer
 drivers/char/drm/via_dmablit.c:584:23: warning: Using plain integer as NULL pointer

Signed-off-by: Luiz Capitulino <lcapitulino@mandriva.com.br>

 drivers/char/drm/via_dmablit.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/drm/via_dmablit.c b/drivers/char/drm/via_dmablit.c
index 9d5e027..a28eece 100644
--- a/drivers/char/drm/via_dmablit.c
+++ b/drivers/char/drm/via_dmablit.c
@@ -108,7 +108,7 @@ via_map_blit_for_device(struct pci_dev *
 	int num_desc = 0;
 	int cur_line;
 	dma_addr_t next = 0 | VIA_DMA_DPR_EC;
-	drm_via_descriptor_t *desc_ptr = 0;
+	drm_via_descriptor_t *desc_ptr = NULL;
 
 	if (mode == 1) 
 		desc_ptr = vsg->desc_pages[cur_descriptor_page];
@@ -581,7 +581,7 @@ via_build_sg_info(drm_device_t *dev, drm
 	int ret = 0;
 	
 	vsg->direction = (draw) ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
-	vsg->bounce_buffer = 0;
+	vsg->bounce_buffer = NULL;
 
 	vsg->state = dr_via_sg_init;
 


-- 
Luiz Fernando N. Capitulino
