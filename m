Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289832AbSBKQAE>; Mon, 11 Feb 2002 11:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289834AbSBKP75>; Mon, 11 Feb 2002 10:59:57 -0500
Received: from h108-129-61.datawire.net ([207.61.129.108]:3855 "HELO
	mail.datawire.net") by vger.kernel.org with SMTP id <S289832AbSBKP7q>;
	Mon, 11 Feb 2002 10:59:46 -0500
Subject: Re: IBM ThinkPad - Redundant entry in serial pci_table
From: Shawn Starr <shawn.starr@datawire.net>
To: Andrey Panin <pazke@orbita1.ru>
Cc: Linux <linux-kernel@vger.kernel.org>
In-Reply-To: <20020211125453.GA429@pazke.ipt>
In-Reply-To: <1013029931.15007.2.camel@unaropia>
	<20020208103353.GA741@pazke.ipt> <1013178614.369.7.camel@unaropia> 
	<20020211125453.GA429@pazke.ipt>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1.99 (Preview Release)
Date: 11 Feb 2002 11:02:49 -0500
Message-Id: <1013443369.19792.155.camel@unaropia>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll, try this out. Thanks.

On Mon, 2002-02-11 at 07:54, Andrey Panin wrote:
> Hi Shawn,
> 
> can you try the attached patch ?
> 
> Best regards.
> 
> -- 
> Andrey Panin            | Embedded systems software engineer
> pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
> ----
> 

> diff -urN -X /usr/dontdiff /linux.vanilla/drivers/char/serial.c /linux/drivers/char/serial.c
> --- /linux.vanilla/drivers/char/serial.c	Sat Feb  9 19:24:23 2002
> +++ /linux/drivers/char/serial.c	Sun Feb 10 17:00:21 2002
> @@ -4852,6 +4859,10 @@
>  
>  	/* Xircom Cardbus/Ethernet combos */
>  	{	PCI_VENDOR_ID_XIRCOM, PCI_DEVICE_ID_XIRCOM_X3201_MDM,
> +		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> +		pbn_xircom_combo },
> +
> +	{	PCI_VENDOR_ID_XIRCOM, 0x000c,
>  		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>  		pbn_xircom_combo },
>  
-- 
Shawn Starr
Developer Support Engineer
Datawire Communication Networks Inc.
10 Carlson Court, Suite 300
Toronto, ON, M9W 6L2
T: 416-213-2001 ext 179  F: 416-213-2008

