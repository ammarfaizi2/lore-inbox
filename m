Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946456AbWJSU1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946456AbWJSU1U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 16:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946454AbWJSU0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 16:26:50 -0400
Received: from cacti.profiwh.com ([85.93.165.66]:30620 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S1946452AbWJSU0r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 16:26:47 -0400
Message-id: <27770221971423522931@wsc.cz>
Subject: [PATCH 4/7] Char: isicom, remove unneeded memset
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Thu, 19 Oct 2006 22:26:58 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

isicom, remove unneeded memset

Memsetting of global static variables is not needed in the init code.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit a2d2f722e0d805a57d7835e715c520ca7a7580a7
tree 5bf84122a37ff113797c54f122f0144b3a302237
parent a11b72a2838aa7dfee930168faeebf25a23c70d4
author Jiri Slaby <jirislaby@gmail.com> Thu, 19 Oct 2006 19:28:14 +0200
committer Jiri Slaby <jirislaby@gmail.com> Thu, 19 Oct 2006 19:28:14 +0200

 drivers/char/isicom.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/char/isicom.c b/drivers/char/isicom.c
index 8cd6cc2..1b9ef44 100644
--- a/drivers/char/isicom.c
+++ b/drivers/char/isicom.c
@@ -1835,7 +1835,6 @@ static int __init isicom_init(void)
 	struct isi_port *port;
 
 	card = 0;
-	memset(isi_ports, 0, sizeof(isi_ports));
 
 	for(idx = 0; idx < BOARD_COUNT; idx++) {
 		port = &isi_ports[idx * 16];
