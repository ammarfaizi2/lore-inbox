Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289010AbSBDPJr>; Mon, 4 Feb 2002 10:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289012AbSBDPJh>; Mon, 4 Feb 2002 10:09:37 -0500
Received: from rtlab.med.cornell.edu ([140.251.145.175]:11392 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S289010AbSBDPJT>;
	Mon, 4 Feb 2002 10:09:19 -0500
Date: Mon, 4 Feb 2002 10:09:19 -0500 (EST)
From: "Calin A. Culianu" <calin@ajvar.org>
To: Oliver Feiler <kiza@gmx.net>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] (was: Re: fixup descriptions in pci-pc.c)
In-Reply-To: <20020204114644.A331@gmx.net>
Message-ID: <Pine.LNX.4.30.0202041007260.2423-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Woo hoo!  The new message is much better!!

Also, speaking of the pci-pc.c fixup for via.. I hear for some people it
causes massive system instability.. :(  Although for me it was the
answer to my woes.  What to do about that?

-Calin

On Mon, 4 Feb 2002, Oliver Feiler wrote:

> Hello,
>
> 	This just changes the printk in the via_northbridge_bug fixup to some
> more meaningful output as it is already in 2.5.3. Please apply.
>
> Oliver
>
> --- linux-2.4.18-pre7/arch/i386/kernel/pci-pc.c	Sun Feb  3 14:56:48 2002
> +++ linux-2.4.18-pre7_testing/arch/i386/kernel/pci-pc.c	Mon Feb  4 11:30:37 2002
> @@ -1129,7 +1129,7 @@
>
>  	pci_read_config_byte(d, where, &v);
>  	if (v & 0xe0) {
> -		printk("Trying to stomp on VIA Northbridge bug...\n");
> +		printk("Disabling broken memory write queue.\n");
>  		v &= 0x1f; /* clear bits 5, 6, 7 */
>  		pci_write_config_byte(d, where, v);
>  	}
>
>
>

