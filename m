Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278667AbRJSVhm>; Fri, 19 Oct 2001 17:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278668AbRJSVhX>; Fri, 19 Oct 2001 17:37:23 -0400
Received: from toad.com ([140.174.2.1]:13583 "EHLO toad.com")
	by vger.kernel.org with ESMTP id <S278666AbRJSVhF>;
	Fri, 19 Oct 2001 17:37:05 -0400
Message-ID: <3BD09D29.2ACF840E@mandrakesoft.com>
Date: Fri, 19 Oct 2001 17:37:45 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>
CC: "'Ralf Baechle'" <ralf@uni-koblenz.de>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: pci_alloc_consistent question
In-Reply-To: <01A7DAF31F93D511AEE300D0B706ED9208E4A5@axcs13.cos.agilent.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"MEHTA,HIREN (A-SanJose,ex1)" wrote:
> so, what is the conservative number ? 1MB ?

FWIW, if you need more than 1-4MB, you can use alloc_bootmem at system
boot to reserve huge amounts of contiguous memory...  (not that anything
but lame hardware requires that anymore)

> -----Original Message-----
> On Fri, Oct 19, 2001 at 12:32:19PM -0600, MEHTA,HIREN (A-SanJose,ex1) wrote:
> 
> > Is there any limitation on the amount of contiguous dmaable memory that
> > can be allocated using a single call to pci_alloc_consistent() ?
> 
> Entirely platform dependant.  On some systems the total available DMA memory
> for DMA may be as limited as 1mb, others have limits like 16mb yet other can
> support the entire 32-bit address space for DMA.  So in case of doubt be
> conservative.

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno
