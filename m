Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263681AbTDTTa2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 15:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263686AbTDTTa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 15:30:28 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:53716
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263681AbTDTTa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 15:30:28 -0400
Subject: Re: [PATCH] hpt366.c compilation fix
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andries.Brouwer@cwi.nl
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <UTC200304201823.h3KINFi18073.aeb@smtp.cwi.nl>
References: <UTC200304201823.h3KINFi18073.aeb@smtp.cwi.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050864264.11658.2.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 20 Apr 2003 19:44:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-04-20 at 19:23, Andries.Brouwer@cwi.nl wrote:
> Remove declaration of unused variables.
> 
> diff -u --recursive --new-file -X /linux/dontdiff a/drivers/ide/pci/hpt366.c b/drivers/ide/pci/hpt366.c
> --- a/drivers/ide/pci/hpt366.c	Sun Apr 20 12:59:31 2003
> +++ b/drivers/ide/pci/hpt366.c	Sun Apr 20 20:11:59 2003
> @@ -1105,7 +1105,6 @@
>  		    (findev->device == dev->device) &&
>  		    ((findev->devfn - dev->devfn) == 1) &&
>  		    (PCI_FUNC(findev->devfn) & 1)) {
> -			u8 irq = 0, irq2 = 0;
>  			if (findev->irq != dev->irq) {
>  				/* FIXME: we need a core pci_set_interrupt() */
>  				findev->irq = dev->irq;

Well it compiles regardless but yes that seems right to me

