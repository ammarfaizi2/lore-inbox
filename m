Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132757AbREBL1Z>; Wed, 2 May 2001 07:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132765AbREBL1R>; Wed, 2 May 2001 07:27:17 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:20751 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132760AbREBL0v>; Wed, 2 May 2001 07:26:51 -0400
Subject: Re: 2.4.4, 2.4.4-ac1 and -ac3: oops loading future domain scsi module
To: fluido@fluido.as (Carlo E. Prelz)
Date: Wed, 2 May 2001 12:30:21 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010502090359.A484@qn-212-127-137-79.fluido.as> from "Carlo E. Prelz" at May 02, 2001 09:03:59 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14uupr-0003RH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     shpnt->io_port = port_base;
> +	 if(pdev!=NULL)
>     scsi_set_pci_device(shpnt->pci_dev, pdev);
>     shpnt->n_io_port = 0x10;
>     print_banner( shpnt );
> 
> I hope this is the right way...

I suspect it should be

	if(shpnt->pci_dev)

but the effect is identical
