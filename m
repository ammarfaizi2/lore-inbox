Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272622AbTHFWO3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 18:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272623AbTHFWO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 18:14:28 -0400
Received: from smtp1.libero.it ([193.70.192.51]:41091 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id S272585AbTHFWOT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 18:14:19 -0400
From: Willy Gardiol <gardiol@libero.it>
Reply-To: gardiol@libero.it
To: Michael Buesch <fsdeveloper@yahoo.de>,
       Frank Van Damme <frank.vandamme@student.kuleuven.ac.be>
Subject: Re: [2.6] system is very slow during disk access
Date: Thu, 7 Aug 2003 00:19:16 +0200
User-Agent: KMail/1.5.1
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
References: <200308062052.10752.fsdeveloper@yahoo.de> <200308062129.26371.frank.vandamme@student.kuleuven.ac.be> <200308062131.46017.fsdeveloper@yahoo.de>
In-Reply-To: <200308062131.46017.fsdeveloper@yahoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200308070019.17442.gardiol@libero.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Try to unmask IRQ, this should realy help... 
hdparm -u1 /dev/hda

I usually do on my disks:
hdparm -c1 -u1 -d1 -X69 /dev/hda
(note: use -X69 only for for an UDMA 100 or 133 drive)

> > Maybe you just didn't enable DMA on them. Use hdparm -v /dev/foo to find
> > out.
>
> DMA is on.
>
> root@lfs:/home/mb> hdparm -v /dev/hda
>
> /dev/hda:
>  multcount    = 16 (on)
>  IO_support   =  1 (32-bit)
>  unmaskirq    =  0 (off)
>  using_dma    =  1 (on)
>  keepsettings =  0 (off)
>  readonly     =  0 (off)
>  readahead    = 256 (on)
>  geometry     = 14244/16/63, sectors = 80418240, start = 0
>
>
> root@lfs:/home/mb> hdparm -v /dev/hdc
>
> /dev/hdc:
>  multcount    = 16 (on)
>  IO_support   =  1 (32-bit)
>  unmaskirq    =  0 (off)
>  using_dma    =  1 (on)
>  keepsettings =  0 (off)
>  readonly     =  0 (off)
>  readahead    = 256 (on)
>  geometry     = 14244/16/63, sectors = 80418240, start = 0

- -- 

! 
 Willy Gardiol - gardiol@libero.it
 gardiol.eu.org
 Use linux for your freedom.

   "La guerra non farà mai finire 
    alcuna guerra, nel migliore dei
    casi sarà stata una guerra in più."

      Gino Strada, Buskashì

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/MX7kQ9qolN/zUk4RApDfAJ9RG7HO3j1rHI/A7ZpfljJdNtzIsgCcC+PS
hQofsS2lrTLMFh4JwgzAVp4=
=0g9b
-----END PGP SIGNATURE-----

