Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266401AbRGFL1h>; Fri, 6 Jul 2001 07:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266410AbRGFL11>; Fri, 6 Jul 2001 07:27:27 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:55485 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S266404AbRGFL1S>;
	Fri, 6 Jul 2001 07:27:18 -0400
Message-ID: <3B45A08D.408D56@mandrakesoft.com>
Date: Fri, 06 Jul 2001 07:27:09 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Steffen Persvold <sp@scali.no>, Helge Hafting <helgehaf@idb.hist.no>,
        Vasu Varma P V <pvvvarma@techmas.hcltech.com>,
        linux-kernel@vger.kernel.org
Subject: Re: DMA memory limitation?
In-Reply-To: <E15ITTf-0004Dz-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> No ifdefs are needed
> 
>         GFP_DMA - ISA dma reachable
>         pci_alloc_* and friends - PCI usable memory

pci_alloc_* is designed to support ISA.

Pass pci_dev==NULL to pci_alloc_* for ISA devices, and it allocs GFP_DMA
for you.

-- 
Jeff Garzik      | A recent study has shown that too much soup
Building 1024    | can cause malaise in laboratory mice.
MandrakeSoft     |
