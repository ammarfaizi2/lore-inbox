Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264083AbTE0UIF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 16:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264106AbTE0UIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 16:08:05 -0400
Received: from Hell.WH8.tu-dresden.de ([141.30.225.3]:52688 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id S264083AbTE0UIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 16:08:00 -0400
Date: Tue, 27 May 2003 22:21:11 +0200
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.70 Massive ACPI Error Scroll
Message-Id: <20030527222111.5c40911b.us15@os.inf.tu-dresden.de>
Organization: Fiasco Core Team
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
X-Fiasco-Rulez: Yes
X-Mailer: X-Mailer 5.0 Gold
X-Outlook: <html><form><input type crash></form></html>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="tX(o=.YQ)C1Br?Rs"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--tX(o=.YQ)C1Br?Rs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Hi,

I've tested 2.5.70 with ACPI on a new Dual-Xeon Box and I get massive scroll
from ACPI errors during bootup. The backtrace below is printed exactly
100 times during each bootup, which is not a nice sight. When booting with
a slow serial console, the system takes ages to boot.

The whole dmesg output of the boot process can be found at the following
URL: http://hell.wh8.tu-dresden.de/cerberus.txt

Regards,
-Udo.


ACPI: Subsystem revision 20030522
irq 9: nobody cared!
Call Trace:
 [<c010b4a2>] handle_IRQ_event+0x87/0xf7
 [<c010b758>] do_IRQ+0xbe/0x17b
 [<c0109b78>] common_interrupt+0x18/0x20
 [<c010be45>] setup_irq+0xc3/0xff
 [<c022bb36>] acpi_irq+0x0/0x16
 [<c022bb36>] acpi_irq+0x0/0x16
 [<c010b8be>] request_irq+0xa9/0xde
 [<c022bb86>] acpi_os_install_interrupt_handler+0x3a/0x59
 [<c022bb36>] acpi_irq+0x0/0x16
 [<c022bb36>] acpi_irq+0x0/0x16
 [<c022fb49>] acpi_ev_install_sci_handler+0x1a/0x1e
 [<c022fb0c>] acpi_ev_sci_xrupt_handler+0x0/0x18
 [<c022f58b>] acpi_ev_handler_initialize+0x6/0x6e
 [<c024056e>] acpi_enable_subsystem+0x2b/0x58
 [<c03e964c>] acpi_bus_init+0x7a/0x115
 [<c03e973d>] acpi_init+0x56/0xa6
 [<c03d685a>] do_initcalls+0x28/0x94
 [<c0130660>] init_workqueues+0xf/0x26
 [<c01050c9>] init+0x5a/0x1d1
 [<c010506f>] init+0x0/0x1d1
 [<c0107075>] kernel_thread_helper+0x5/0xb

handlers:
[<c022bb36>] (acpi_irq+0x0/0x16)


--tX(o=.YQ)C1Br?Rs
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.3.1 (GNU/Linux)

iD8DBQE+08i6nhRzXSM7nSkRAjOVAJ9FBbRqDaJEjvZkr0ttcWlIHo1mAACeOzX+
SQwsVYUgSYi6MOFsDZXspvY=
=WcwO
-----END PGP SIGNATURE-----

--tX(o=.YQ)C1Br?Rs--
