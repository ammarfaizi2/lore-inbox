Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129999AbQLTVdC>; Wed, 20 Dec 2000 16:33:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130070AbQLTVcw>; Wed, 20 Dec 2000 16:32:52 -0500
Received: from ja.ssi.bg ([193.68.177.189]:55300 "EHLO u.domain.uli")
	by vger.kernel.org with ESMTP id <S129999AbQLTVck>;
	Wed, 20 Dec 2000 16:32:40 -0500
Date: Wed, 20 Dec 2000 23:00:55 +0000 (GMT)
From: Julian Anastasov <ja@ssi.bg>
To: Robert Högberg <robho956@student.liu.se>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Extreme IDE slowdown with 2.2.18
Message-ID: <Pine.LNX.4.21.0012202246510.6151-100000@u>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

On Wed, 20 Dec 2000, Robert HÃgberg wrote:

> hda: QUANTUM FIREBALL ST6.4A, 6149MB w/81kB Cache, CHS=784/255/63
> hdb: QUANTUM FIREBALL SE4.3A, 4110MB w/80kB Cache, CHS=524/255/63
> hdc: IBM-DJNA-352030, 19470MB w/1966kB Cache, CHS=39560/16/63
>
> When I performed the tests I used similiar .17 and .18 kernels with a
> minimum components included. No network, SCSI, sound and such things.
> .config files can be supplied if needed.
>
> Does anyone know what could be wrong? Have I forgot something? Is this a
> known problem with the 2.2.18 kernel?

	Yes, 2.2.18 is not friendly to all MVP3 users. The autodma
detection was disabled for the all *VP3 users in drivers/block/ide-pci.c.

	If you don't experience any problems with the DMA you can:

1. Add append="ide0=dma ide1=dma" in lilo.conf

2. Use ide patches:

http://www.kernel.org/pub/linux/kernel/people/hedrick/ide-2.2.18/ide.2.2.18.1209.patch.bz2


Regards

--
Julian Anastasov <ja@ssi.bg>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
