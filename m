Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129933AbQKHWx5>; Wed, 8 Nov 2000 17:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129666AbQKHWxr>; Wed, 8 Nov 2000 17:53:47 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:47624 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129211AbQKHWx2>;
	Wed, 8 Nov 2000 17:53:28 -0500
Message-ID: <3A09D957.4BC6F0@mandrakesoft.com>
Date: Wed, 08 Nov 2000 17:53:11 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: accessing on-card ram/rom
In-Reply-To: <FEEBE78C8360D411ACFD00D0B74779718808E4@xsj02.sjs.agilent.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"MEHTA,HIREN (A-SanJose,ex1)" wrote:
> I have a PCI card which has on-card ram/rom which gets mapped
> into pci address space and there is a separate base register
> for this memory. Now the question is : can I access this on-card
> memory by converting the pci base address into the virtual address
> using bus_to_virt and adding the required offset ? Or do I need
> to use ioremap function to map the physical address space starting
> from the pci base address into the kernel virtual address space ?
> Or is there any other interface to access the on-card memory ?
> Is it that bus_to_virt can be used only for the normal RAM ?

Use ioremap.

For more details, read linux/Documentation/IO-mapping.txt.

	Jeff


-- 
Jeff Garzik             | "When I do this, my computer freezes."
Building 1024           |          -user
MandrakeSoft            | "Don't do that."
                        |          -level 1
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
