Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265824AbRF2J5w>; Fri, 29 Jun 2001 05:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265828AbRF2J5n>; Fri, 29 Jun 2001 05:57:43 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:63492 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265824AbRF2J5c>; Fri, 29 Jun 2001 05:57:32 -0400
Subject: Re: (reposting) how to get DMA'able memory within 4GB on 64-bit m achi ne
To: davem@redhat.com (David S. Miller)
Date: Fri, 29 Jun 2001 10:56:45 +0100 (BST)
Cc: jes@sunsite.dk (Jes Sorensen), bcrl@redhat.com (Ben LaHaise),
        hiren_mehta@agilent.com ("MEHTA,HIREN (A-SanJose,ex1)"),
        linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
In-Reply-To: <15164.18270.460245.219060@pizda.ninka.net> from "David S. Miller" at Jun 29, 2001 02:16:14 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Fv14-0008TB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > as well, when doing large allocs and the IOMMU is full you return a
>  > full 64 bit address.
> 
> And when the IOMMU is "full" what happens to all the SAC only
> cards in the machine?  pci_map_{single,sg}() are not allowed
> to fail.

Thats something we already know has to be fixed. Its true with or without
an IOMMU that there may be cases where there is no free mapping space

