Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267392AbSLLAoi>; Wed, 11 Dec 2002 19:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267393AbSLLAoi>; Wed, 11 Dec 2002 19:44:38 -0500
Received: from pc2-cwma1-4-cust129.swan.cable.ntl.com ([213.105.254.129]:43972
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267392AbSLLAo0>; Wed, 11 Dec 2002 19:44:26 -0500
Subject: Re: [TRIVIAL PATCH 2.5.51] Remove compile warning from 
	drivers/ide/pci/cs5520.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bob Miller <rem@osdl.org>
Cc: trivial@rustcorp.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021211222810.GA1067@doc.pdx.osdl.net>
References: <20021211222810.GA1067@doc.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 12 Dec 2002 01:29:45 +0000
Message-Id: <1039656585.18467.61.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-11 at 22:28, Bob Miller wrote:
> The function, cs5520_tune_chipset() is declared to return an int.
> Added a return statement instead of just falling of off the bottom.
> 
> diff -Nru a/drivers/ide/pci/cs5520.c b/drivers/ide/pci/cs5520.c
> --- a/drivers/ide/pci/cs5520.c	Wed Dec 11 13:41:51 2002
> +++ b/drivers/ide/pci/cs5520.c	Wed Dec 11 13:41:51 2002
> @@ -166,6 +166,8 @@
>  	/* ATAPI is harder so leave it for now */
>  	if(!error && drive->media == ide_disk)
>  		error = hwif->ide_dma_on(drive);
> +
> +	return error;

Eep thats a nasty little bug, lucky my compiler left the error value in
%eax anyway good spotting

