Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266876AbUI0Rw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266876AbUI0Rw6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 13:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266888AbUI0RwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 13:52:03 -0400
Received: from linares.terra.com.br ([200.154.55.228]:11475 "EHLO
	linares.terra.com.br") by vger.kernel.org with ESMTP
	id S266876AbUI0Rus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 13:50:48 -0400
Date: Mon, 27 Sep 2004 13:54:48 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@conectiva.com.br>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/5]: usb-serial: return_serial() trivial cleanup.
Message-Id: <20040927135448.3f0e5cb6.lcapitulino@conectiva.com.br>
Organization: Conectiva S/A.
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-conectiva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 return_serial() trivial cleanup:

1) CodingStyle fix;
2) The `return' is not necessary, we are at the end of a function
which don't return nothing (void).

(against 2.6.9-rc2-mm4).

Signed-off-by: Luiz Capitulino <lcapitulino@conectiva.com.br>

 drivers/usb/serial/usb-serial.c |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)


diff -X /home/lcapitulino/kernels/2.6/dontdiff -Nparu a/drivers/usb/serial/usb-serial.c a~/drivers/usb/serial/usb-serial.c
--- a/drivers/usb/serial/usb-serial.c	2004-09-26 13:30:50.000000000 -0300
+++ a~/drivers/usb/serial/usb-serial.c	2004-09-26 13:31:27.000000000 -0300
@@ -405,7 +405,7 @@ static struct usb_serial *get_free_seria
 	return NULL;
 }
 
-static void return_serial (struct usb_serial *serial)
+static void return_serial(struct usb_serial *serial)
 {
 	int i;
 
@@ -417,8 +417,6 @@ static void return_serial (struct usb_se
 	for (i = 0; i < serial->num_ports; ++i) {
 		serial_table[serial->minor + i] = NULL;
 	}
-
-	return;
 }
 
 static void destroy_serial(struct kref *kref)
