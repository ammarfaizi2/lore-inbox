Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278492AbRJPB73>; Mon, 15 Oct 2001 21:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278493AbRJPB7X>; Mon, 15 Oct 2001 21:59:23 -0400
Received: from mercury.Sun.COM ([192.9.25.1]:53419 "EHLO mercury.Sun.COM")
	by vger.kernel.org with ESMTP id <S278492AbRJPB6w>;
	Mon, 15 Oct 2001 21:58:52 -0400
Message-ID: <3BCB93BE.B165246C@sun.com>
Date: Mon, 15 Oct 2001 18:56:14 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alan@redhat.com,
        torvalds@transmeta.com
Subject: PIRQ for ServerWorks CSB5
Content-Type: multipart/mixed;
 boundary="------------0951EF777EBD7E2EB0C4F5E3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------0951EF777EBD7E2EB0C4F5E3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Linus, Alan,

This is a simple 2-liner to add PIRQ support for the ServerWorks CSB5 chip.

Please apply, or let me know :)

Tim
-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
--------------0951EF777EBD7E2EB0C4F5E3
Content-Type: text/plain; charset=us-ascii;
 name="csb5-pirq.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="csb5-pirq.diff"

diff -ruN dist-2.4.12+patches/arch/i386/kernel/pci-irq.c cvs-2.4.12+patches/arch/i386/kernel/pci-irq.c
--- dist-2.4.12+patches/arch/i386/kernel/pci-irq.c	Mon Oct 15 10:20:41 2001
+++ cvs-2.4.12+patches/arch/i386/kernel/pci-irq.c	Mon Oct 15 10:20:51 2001
@@ -458,6 +458,8 @@
 	{ "VLSI 82C534", PCI_VENDOR_ID_VLSI, PCI_DEVICE_ID_VLSI_82C534, pirq_vlsi_get, pirq_vlsi_set },
 	{ "ServerWorks", PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_OSB4,
 	  pirq_serverworks_get, pirq_serverworks_set },
+	{ "ServerWorks", PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB5,
+	  pirq_serverworks_get, pirq_serverworks_set },
 	{ "AMD756 VIPER", PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_VIPER_740B,
 		pirq_amd756_get, pirq_amd756_set },
 

--------------0951EF777EBD7E2EB0C4F5E3--

