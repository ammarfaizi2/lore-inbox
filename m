Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313588AbSDHMlF>; Mon, 8 Apr 2002 08:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313602AbSDHMlF>; Mon, 8 Apr 2002 08:41:05 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:19381 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S313588AbSDHMlD>; Mon, 8 Apr 2002 08:41:03 -0400
From: "Jochen Barth" <jochen.barth@bib.uni-mannheim.de>
Organization: UB Mannheim
To: mj@ucw.cz, linux-kernel@vger.kernel.org
Date: Mon, 8 Apr 2002 14:42:07 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: VIA vt82c686b chipset "quirk_vialatency" not enabled in drivers/pci/quirk.c
Message-ID: <3CB1AC3F.7439.1898BC2@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Reader,

i've got some PCs with the VIA vt82c686b southbridge on board.
As i've read, it has an Bug. (Did VIA gave an useful official statement that can 
i citate to exchange those buggy boards?)

And - there is an workaround in drivers/pci/quirk.c named "quirk_vialatency".
But in table "static struct pci_fixup pci_fixups[] __initdata = {"
isn't an entry for that chipset.
I think the following line should be added:
{ PCI_FIXUP_FINAL, PCI_VENDOR_ID_VIA, 
PCI_DEVICE_ID_VIA_82C686, quirk_vialatency },

then it worked (form /var/log/boot.msg):
<6>Applying VIA southbridge workaround.

But I don't have enough time, to test all systems, if the workaround 
"quirk_vialatency" really works.

Thanks in Advance,

  J. Barth
      jochen barth / dipl.-inform. (fh) / jochen.barth@bib.uni-mannheim.de
        universitaetsbibliothek mannheim / edv-abteilung / 0621-181-2969
