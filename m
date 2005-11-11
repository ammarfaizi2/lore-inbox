Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbVKKT0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbVKKT0F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 14:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbVKKT0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 14:26:05 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:1774 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1751098AbVKKTZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 14:25:58 -0500
Date: Fri, 11 Nov 2005 17:25:57 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [PATCH 2/2] pl2303: updates pl2303_update_line_status()
Message-Id: <20051111172557.64ed6d7a.lcapitulino@mandriva.com.br>
Organization: Mandriva
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-conectiva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi again,

Updates pl2303_update_line_status() to handle X75 and SX1 Siemens mobiles

Signed-off-by: Luiz Capitulino <lcapitulino@mandriva.com.br>

 drivers/usb/serial/pl2303.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff -Nparu -X /home/lcapitulino/tmp/dontdiff a/drivers/usb/serial/pl2303.c a~/drivers/usb/serial/pl2303.c
--- a/drivers/usb/serial/pl2303.c	2005-11-11 16:57:13.000000000 -0200
+++ a~/drivers/usb/serial/pl2303.c	2005-11-11 16:44:48.000000000 -0200
@@ -813,7 +813,9 @@ static void pl2303_update_line_status(st
 	u8 length = UART_STATE;
 
 	if ((le16_to_cpu(port->serial->dev->descriptor.idVendor) == SIEMENS_VENDOR_ID) &&
-	    (le16_to_cpu(port->serial->dev->descriptor.idProduct) == SIEMENS_PRODUCT_ID_X65)) {
+	    (le16_to_cpu(port->serial->dev->descriptor.idProduct) == SIEMENS_PRODUCT_ID_X65 ||
+	     le16_to_cpu(port->serial->dev->descriptor.idProduct) == SIEMENS_PRODUCT_ID_SX1 ||
+	     le16_to_cpu(port->serial->dev->descriptor.idProduct) == SIEMENS_PRODUCT_ID_X75)) {
 		length = 1;
 		status_idx = 0;
 	}


-- 
Luiz Fernando N. Capitulino
