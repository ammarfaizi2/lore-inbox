Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263735AbREYMvG>; Fri, 25 May 2001 08:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263736AbREYMu4>; Fri, 25 May 2001 08:50:56 -0400
Received: from ns1.antas.de ([62.225.191.178]:30480 "EHLO FW10001.antas.de")
	by vger.kernel.org with ESMTP id <S263735AbREYMuk>;
	Fri, 25 May 2001 08:50:40 -0400
Message-ID: <90B7827C9407D4118C360000D11C1ACB219FE2@S10002>
From: "Chobeiry, Parto" <Parto.Chobeiry@ANTAS.DE>
To: linux-kernel@vger.kernel.org
Subject: PDC20265 causes panic on 2.4.4
Date: Fri, 25 May 2001 14:50:37 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

just purchased a mainboard from MSI (694D Pro-IR 2.0, MS-6321 2.0) with an
on-board RAID-controller from Promise. Booting with a 2.4.4 kernel causes a
panic right after detection of the PDC20265.

I checked the source code in ide-pci.c and saw that there is a special
handling for this chip although MSI states that PDC20265 and PDC20267 are
the same. The only difference is the point of production.

Exchanging the detection codes between the defines of 20265 and 20267 helped
thus causing Linux to handle my 20265 as a 20267.

Could somebody tell my why there is this special handling of the 20265 in
the kernel source code?

BTW, error message was something like "could not dereference NULL pointer".

Thanks -- Parto
