Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964971AbVLFMPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971AbVLFMPk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 07:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964967AbVLFMP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 07:15:27 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:32388 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S964968AbVLFMPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 07:15:12 -0500
Date: Tue, 6 Dec 2005 10:04:18 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       ehabkost@mandriva.com
Subject: [PATCH 10/10] usb-serial: adds initialization code for all ports.
Message-Id: <20051206100418.0fe255ff.lcapitulino@mandriva.com.br>
Organization: Mandriva
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Initialize the write URB lock for all ports.

Signed-off-by: Luiz Capitulino <lcapitulino@mandriva.com.br>

 drivers/usb/serial/usb-serial.c |    1 +
 1 file changed, 1 insertion(+)

diff -Nparu -X /home/lcapitulino/kernels/dontdiff a/drivers/usb/serial/usb-serial.c a~/drivers/usb/serial/usb-serial.c
--- a/drivers/usb/serial/usb-serial.c	2005-12-04 20:12:18.000000000 -0200
+++ a~/drivers/usb/serial/usb-serial.c	2005-12-04 20:12:55.000000000 -0200
@@ -784,6 +784,7 @@ int usb_serial_probe(struct usb_interfac
 		port->number = i + serial->minor;
 		port->serial = serial;
 		sema_init(&port->sem, 1);
+		usb_serial_write_urb_lock_init(port);
 		INIT_WORK(&port->work, usb_serial_port_softint, port);
 		serial->port[i] = port;
 	}


-- 
Luiz Fernando N. Capitulino
