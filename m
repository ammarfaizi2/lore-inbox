Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318346AbSG3QfV>; Tue, 30 Jul 2002 12:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318348AbSG3QfV>; Tue, 30 Jul 2002 12:35:21 -0400
Received: from sys-209.inet6.fr ([62.210.110.209]:27535 "EHLO ns1.inet6.fr")
	by vger.kernel.org with ESMTP id <S318346AbSG3QfT>;
	Tue, 30 Jul 2002 12:35:19 -0400
Message-ID: <3D46C112.5070003@inet6.fr>
Date: Tue, 30 Jul 2002 18:38:42 +0200
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a) Gecko/20020702
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SiS 5513 ATA133 support patch for 2.4.19-rc3-ac3
References: <Pine.LNX.4.44.0207291612160.2270-100000@freak.distro.conectiva>
Content-Type: multipart/mixed;
 boundary="------------070006010401000107090904"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070006010401000107090904
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Marcelo Tosatti wrote:

>On Mon, 29 Jul 2002, Lionel Bouton wrote:
>
>  
>
>>Before releasing 2.4.19 I think we should either :
>>- completely remove the affected northbridges (645, 650, 745, 750)
>>support in v0.13, this is a simple patch. Then we wait for 2.4.20 to
>>include v0.14.
>>- put v0.14 in.
>>    
>>
>
>Lets do that. Please send me a patch ASAP so I can release 2.4.19.
>
>  
>
First one disables UDMA support for problematic chipsets.
Second upgrades to v0.14 (gziped for less linux-kernel bloat, original 
Lui-Chen material).

Choice is yours.

Sorry for the delay, relocation just finished, everything isn't up and 
running yet at home...

LB

-- 
Lionel Bouton - inet6
---------------------------------------------------------------------
   o              Siege social: 51, rue de Verdun - 92158 Suresnes
  /      _ __ _   Acces Bureaux: 33 rue Benoit Malon - 92150 Suresnes
 / /\  /_  / /_   France
 \/  \/_  / /_/   Tel. +33 (0) 1 41 44 85 36
  Inetsys S.A.    Fax  +33 (0) 1 46 97 20 10
 


--------------070006010401000107090904
Content-Type: text/plain;
 name="2.4.19-rc3.disable.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.19-rc3.disable.patch"

diff -urN linux-2.4.19-rc3/drivers/ide/sis5513.c linux-2.4.19-rc3-sis/drivers/ide/sis5513.c
--- linux-2.4.19-rc3/drivers/ide/sis5513.c	Tue Jul 30 18:10:31 2002
+++ linux-2.4.19-rc3-sis/drivers/ide/sis5513.c	Tue Jul 30 18:27:29 2002
@@ -169,13 +169,13 @@
 	unsigned char chipset_family;
 	unsigned char flags;
 } SiSHostChipInfo[] = {
-	{ "SiS750",	PCI_DEVICE_ID_SI_750,	ATA_100,	SIS5513_LATENCY },
-	{ "SiS745",	PCI_DEVICE_ID_SI_745,	ATA_100,	SIS5513_LATENCY },
+//	{ "SiS750",	PCI_DEVICE_ID_SI_750,	ATA_100,	SIS5513_LATENCY },
+//	{ "SiS745",	PCI_DEVICE_ID_SI_745,	ATA_100,	SIS5513_LATENCY },
 	{ "SiS740",	PCI_DEVICE_ID_SI_740,	ATA_100,	SIS5513_LATENCY },
 	{ "SiS735",	PCI_DEVICE_ID_SI_735,	ATA_100,	SIS5513_LATENCY },
 	{ "SiS730",	PCI_DEVICE_ID_SI_730,	ATA_100a,	SIS5513_LATENCY },
-	{ "SiS650",	PCI_DEVICE_ID_SI_650,	ATA_100,	SIS5513_LATENCY },
-	{ "SiS645",	PCI_DEVICE_ID_SI_645,	ATA_100,	SIS5513_LATENCY },
+//	{ "SiS650",	PCI_DEVICE_ID_SI_650,	ATA_100,	SIS5513_LATENCY },
+//	{ "SiS645",	PCI_DEVICE_ID_SI_645,	ATA_100,	SIS5513_LATENCY },
 	{ "SiS635",	PCI_DEVICE_ID_SI_635,	ATA_100,	SIS5513_LATENCY },
 	{ "SiS640",	PCI_DEVICE_ID_SI_640,	ATA_66,		SIS5513_LATENCY },
 	{ "SiS630",	PCI_DEVICE_ID_SI_630,	ATA_66,		SIS5513_LATENCY },

--------------070006010401000107090904
Content-Type: application/x-gzip;
 name="linux-2.4.19-rc3.sis.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="linux-2.4.19-rc3.sis.patch.gz"

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
Xaq1LEd06nR3OhFgky1gjgBz9v4LhCJXXZ1RAAA=
--------------070006010401000107090904--

