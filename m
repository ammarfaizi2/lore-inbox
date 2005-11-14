Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbVKNLyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbVKNLyf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 06:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbVKNLyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 06:54:35 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:2253 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1751088AbVKNLye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 06:54:34 -0500
Date: Mon, 14 Nov 2005 09:54:32 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: akpm <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, abhay_salunke@dell.com
Subject: [PATCH] - Fixes sparse warnings in dell_rbu driver.
Message-Id: <20051114095432.5b53ad5d.lcapitulino@mandriva.com.br>
Organization: Mandriva
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-conectiva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The patch below fixes the following sparse warnings:

drivers/firmware/dell_rbu.c:108:37: warning: Using plain integer as NULL pointer
drivers/firmware/dell_rbu.c:109:31: warning: Using plain integer as NULL pointer
drivers/firmware/dell_rbu.c:181:27: warning: Using plain integer as NULL pointer

Signed-off-by: Luiz Capitulino <lcapitulino@mandriva.com.br>

 drivers/firmware/dell_rbu.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/dell_rbu.c b/drivers/firmware/dell_rbu.c
--- a/drivers/firmware/dell_rbu.c
+++ b/drivers/firmware/dell_rbu.c
@@ -105,8 +105,8 @@ static int create_packet(void *data, siz
 	int ordernum = 0;
 	int retval = 0;
 	unsigned int packet_array_size = 0;
-	void **invalid_addr_packet_array = 0;
-	void *packet_data_temp_buf = 0;
+	void **invalid_addr_packet_array = NULL;
+	void *packet_data_temp_buf = NULL;
 	unsigned int idx = 0;
 
 	pr_debug("create_packet: entry \n");
@@ -178,7 +178,7 @@ static int create_packet(void *data, siz
 						packet_data_temp_buf),
 					allocation_floor);
 			invalid_addr_packet_array[idx++] = packet_data_temp_buf;
-			packet_data_temp_buf = 0;
+			packet_data_temp_buf = NULL;
 		}
 	}
 	spin_lock(&rbu_data.lock);

-- 
Luiz Fernando N. Capitulino
