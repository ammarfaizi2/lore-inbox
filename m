Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129632AbQLDGTq>; Mon, 4 Dec 2000 01:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130562AbQLDGTf>; Mon, 4 Dec 2000 01:19:35 -0500
Received: from ns1.crl.go.jp ([133.243.3.1]:59088 "EHLO ns1.crl.go.jp")
	by vger.kernel.org with ESMTP id <S129632AbQLDGTd>;
	Mon, 4 Dec 2000 01:19:33 -0500
Date: Mon, 4 Dec 2000 14:49:04 +0900 (JST)
From: Tom Holroyd <tomh@po.crl.go.jp>
To: kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: test12-pre4
Message-ID: <Pine.LNX.4.30.0012041447440.10480-100000@holly.crl.go.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mno-fp-regs -ffixed-8 -mcpu=ev6 -Wa,-mev6    -DEXPORT_SYMTAB -c pci.c
pci.c: In function `pci_read_bases':
pci.c:576: `tmp' undeclared (first use in this function)
pci.c:576: (Each undeclared identifier is reported only once
pci.c:576: for each function it appears in.)

--- drivers/pci/#pci.c  Mon Dec  4 14:30:40 2000
+++ drivers/pci/pci.c   Mon Dec  4 14:44:29 2000
@@ -540,7 +540,7 @@
 static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
 {
        unsigned int pos, reg, next;
-       u32 l, sz;
+       u32 l, sz, tmp;
        struct resource *res;

        for(pos=0; pos<howmany; pos = next) {

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
