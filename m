Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQKHW6U>; Wed, 8 Nov 2000 17:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129211AbQKHW6J>; Wed, 8 Nov 2000 17:58:09 -0500
Received: from msgbas1tx.cos.agilent.com ([192.6.9.34]:1789 "HELO
	msgbas1t.cos.agilent.com") by vger.kernel.org with SMTP
	id <S129183AbQKHW6C>; Wed, 8 Nov 2000 17:58:02 -0500
Message-ID: <FEEBE78C8360D411ACFD00D0B74779718808E5@xsj02.sjs.agilent.com>
From: hiren_mehta@agilent.com
To: jgarzik@mandrakesoft.com
Cc: linux-kernel@vger.kernel.org
Subject: RE: accessing on-card ram/rom
Date: Wed, 8 Nov 2000 15:57:59 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I looked at the IO-mapping.txt file. It says that
on x86 architecture it should not make any difference.
It also says that "on x86 it _is_ the same memory space. So
on x86 it actually works to just dereference a pointer".

Any inputs on this ?

Thanks and regards,
-hiren

> -----Original Message-----
> From: Jeff Garzik [mailto:jgarzik@mandrakesoft.com]
> Sent: Wednesday, November 08, 2000 2:53 PM
> To: MEHTA,HIREN (A-SanJose,ex1)
> Cc: 'linux-kernel@vger.kernel.org'
> Subject: Re: accessing on-card ram/rom
> 
> 
> "MEHTA,HIREN (A-SanJose,ex1)" wrote:
> > I have a PCI card which has on-card ram/rom which gets mapped
> > into pci address space and there is a separate base register
> > for this memory. Now the question is : can I access this on-card
> > memory by converting the pci base address into the virtual address
> > using bus_to_virt and adding the required offset ? Or do I need
> > to use ioremap function to map the physical address space starting
> > from the pci base address into the kernel virtual address space ?
> > Or is there any other interface to access the on-card memory ?
> > Is it that bus_to_virt can be used only for the normal RAM ?
> 
> Use ioremap.
> 
> For more details, read linux/Documentation/IO-mapping.txt.
> 
> 	Jeff
> 
> 
> -- 
> Jeff Garzik             | "When I do this, my computer freezes."
> Building 1024           |          -user
> MandrakeSoft            | "Don't do that."
>                         |          -level 1
> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
