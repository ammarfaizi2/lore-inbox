Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131339AbQLUWBd>; Thu, 21 Dec 2000 17:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131241AbQLUWBX>; Thu, 21 Dec 2000 17:01:23 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:35087 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131339AbQLUWBL>; Thu, 21 Dec 2000 17:01:11 -0500
Subject: Re: bigphysarea support in 2.2.19 and 2.4.0 kernels
To: jmerkey@vger.timpanogas.org (Jeff V. Merkey)
Date: Thu, 21 Dec 2000 21:32:46 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20001221144247.A10273@vger.timpanogas.org> from "Jeff V. Merkey" at Dec 21, 2000 02:42:47 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E149DKS-0003cX-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A question related to bigphysarea support in the native Linux
> 2.2.19 and 2.4.0 kernels.
> 
> I know there are patches for this support, but is it planned for 
> rolling into the kernel by default to support Dolphin SCI and 
> some of the NUMA Clustering adapters.  I see it there for some 
> of the video adapters.

bigphysarea is the wrong model for 2.4. The bootmem allocator means that
drivers could do early claims via the bootmem interface during boot up. That
would avoid all the cruft.

For 2.2 bigphysarea is a hack, but a neccessary add on patch and not one you
can redo cleanly as we don't have bootmem

I belive Pauline Middelink had a patch implementing bigphysarea in terms of
bootmem

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
