Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265285AbTGCTFI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 15:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265295AbTGCTFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 15:05:08 -0400
Received: from h-67-100-114-146.SNVACAID.covad.net ([67.100.114.146]:22170
	"EHLO scl-ims.phoenix.com") by vger.kernel.org with ESMTP
	id S265285AbTGCTE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 15:04:58 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C34198.007888AB"
Subject: VIA PCI IRQ router bug fix
Date: Thu, 3 Jul 2003 12:19:19 -0700
Message-ID: <5F106036E3D97448B673ED7AA8B2B6B36C352C@scl-exch2k.phoenix.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: VIA PCI IRQ router bug fix
Thread-Index: AcNBl//lo2TqGnCRQryQT2UD244DEw==
From: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>
To: <linux-kernel@vger.kernel.org>
Cc: <mj@ucw.cz>
X-OriginalArrivalTime: 03 Jul 2003 19:19:19.0718 (UTC) FILETIME=[00962460:01C34198]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C34198.007888AB
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi.

  I found & fixed a problem with #PIRQD line setup for VIA PCI IRQ
router. Kernel was not able to receive any interrupts from network card,
which PCI slot IRQ pin A was routed to PIRQ line D of VIA PCI IRQ
router. According to VIA specs, PIRQ D routing is out of standard
'nibble' scheme.
  I tested patch with 2.4.20 kernel, it can be applied to 2.4.22-pre2 as
well.
  Thanks to my employer (Phoenix Technologies) who kindly allowed me to
make this patch public.

Aleks.


------_=_NextPart_001_01C34198.007888AB
Content-Type: text/plain;
	name="pci-irq-patch.txt"
Content-Transfer-Encoding: base64
Content-Description: pci-irq-patch.txt
Content-Disposition: attachment;
	filename="pci-irq-patch.txt"

LS0tIGxpbnV4LTIuNC4yMC9hcmNoL2kzODYva2VybmVsL3BjaS1pcnFfb2xkLmMJMjAwMi0xMS0y
OCAxNTo1MzowOS4wMDAwMDAwMDAgLTA4MDAKKysrIGxpbnV4LTIuNC4yMC9hcmNoL2kzODYva2Vy
bmVsL3BjaS1pcnEuYwkyMDAzLTA1LTIxIDE3OjI3OjQwLjAwMDAwMDAwMCAtMDcwMApAQCAtMTk4
LDEyICsxOTgsMjcgQEAKICAqLwogc3RhdGljIGludCBwaXJxX3ZpYV9nZXQoc3RydWN0IHBjaV9k
ZXYgKnJvdXRlciwgc3RydWN0IHBjaV9kZXYgKmRldiwgaW50IHBpcnEpCiB7Ci0JcmV0dXJuIHJl
YWRfY29uZmlnX255YmJsZShyb3V0ZXIsIDB4NTUsIHBpcnEpOworICAgIHU4IHg7CisKKyAgICBp
ZiAoIHBpcnEgPT0gNCApIHsKKyAgICAgICAgcGNpX3JlYWRfY29uZmlnX2J5dGUocm91dGVyLCAw
eDU3LCAmeCk7CisgICAgICAgIHJldHVybiAoeCA+PiA0KTsKKyAgICB9IGVsc2UgeworICAgICAg
ICByZXR1cm4gcmVhZF9jb25maWdfbnliYmxlKHJvdXRlciwgMHg1NSwgcGlycSk7CisgICAgfQog
fQogCiBzdGF0aWMgaW50IHBpcnFfdmlhX3NldChzdHJ1Y3QgcGNpX2RldiAqcm91dGVyLCBzdHJ1
Y3QgcGNpX2RldiAqZGV2LCBpbnQgcGlycSwgaW50IGlycSkKIHsKLQl3cml0ZV9jb25maWdfbnli
YmxlKHJvdXRlciwgMHg1NSwgcGlycSwgaXJxKTsKKyAgCXU4IHg7CisKKyAgICBpZiAoIHBpcnEg
PT0gNCApIHsKKyAgICAgICAgcGNpX3JlYWRfY29uZmlnX2J5dGUocm91dGVyLCAweDU3LCAmeCk7
CisgICAgICAgIHggPSAoeCAmIDB4MGYpIHwgKGlycSA8PCA0KTsKKyAgICAgICAJcGNpX3dyaXRl
X2NvbmZpZ19ieXRlKHJvdXRlciwgMHg1NywgeCk7CisgICAgfSBlbHNlIHsKKyAgICAgICAgd3Jp
dGVfY29uZmlnX255YmJsZShyb3V0ZXIsIDB4NTUsIHBpcnEsIGlycSk7CisgICAgfQogCXJldHVy
biAxOwogfQogCg==

------_=_NextPart_001_01C34198.007888AB--
