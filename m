Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278661AbRJSVYB>; Fri, 19 Oct 2001 17:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278662AbRJSVXv>; Fri, 19 Oct 2001 17:23:51 -0400
Received: from msgbas1x.cos.agilent.com ([192.25.240.36]:56564 "HELO
	msgbas1.cos.agilent.com") by vger.kernel.org with SMTP
	id <S278661AbRJSVXn>; Fri, 19 Oct 2001 17:23:43 -0400
Message-ID: <01A7DAF31F93D511AEE300D0B706ED9208E4A5@axcs13.cos.agilent.com>
From: "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>
To: "'Ralf Baechle'" <ralf@uni-koblenz.de>,
        "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: pci_alloc_consistent question
Date: Fri, 19 Oct 2001 15:24:14 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

so, what is the conservative number ? 1MB ?

-hiren

-----Original Message-----
From: Ralf Baechle [mailto:ralf@uni-koblenz.de]
Sent: Friday, October 19, 2001 1:58 PM
To: MEHTA,HIREN (A-SanJose,ex1)
Cc: 'linux-kernel@vger.kernel.org'
Subject: Re: pci_alloc_consistent question


On Fri, Oct 19, 2001 at 12:32:19PM -0600, MEHTA,HIREN (A-SanJose,ex1) wrote:

> Is there any limitation on the amount of contiguous dmaable memory that
> can be allocated using a single call to pci_alloc_consistent() ?

Entirely platform dependant.  On some systems the total available DMA memory
for DMA may be as limited as 1mb, others have limits like 16mb yet other can
support the entire 32-bit address space for DMA.  So in case of doubt be
conservative.

  Ralf
