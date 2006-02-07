Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965021AbWBGLK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965021AbWBGLK1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 06:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965020AbWBGLK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 06:10:27 -0500
Received: from math.ut.ee ([193.40.36.2]:27114 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S965021AbWBGLK0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 06:10:26 -0500
Date: Tue, 7 Feb 2006 13:10:16 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: libATA  PATA status report, new patch
In-Reply-To: <1139310335.18391.2.camel@localhost.localdomain>
Message-ID: <Pine.SOC.4.61.0602071305310.10491@math.ut.ee>
References: <20060207084347.54CD01430C@rhn.tartu-labor>
 <1139310335.18391.2.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Very strange trace indeed. I'll take a look at this. At least since it
> came from Qemu I should be able to "build" a suitable PC to match yours.
>
> Original Intel PIIX devices are handled by "OLDPIIX" (0x8086, 0x1230).
> The later ones by ata_piix. The only oddity I see is that you have no
> PCI bus mastering address base assigned (bmdma)

I also tried VMWare 5.5 that emulated PIIX4. It works if I only put 
ata_piix driver in. With the same kernel that Qemu gets the error, 
VMWare gets another oops during generic ide initialisation. I relooked 
and found that I have both generic PCI ide and generic ISA ide drivers 
compiled in, so I disabled them and it works using ata_piix (with PATA 
and ATAPI enabled). Even ATAPI cdrom worked as the root partition.

But, the different oops that I got in vmware with generic ide:
http://www.cs.ut.ee/~mroos/atacrash.png

-- 
Meelis Roos (mroos@linux.ee)
