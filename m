Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289114AbSBDRMC>; Mon, 4 Feb 2002 12:12:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289117AbSBDRLx>; Mon, 4 Feb 2002 12:11:53 -0500
Received: from 120-VALL-X8.libre.retevision.es ([62.83.212.120]:45316 "EHLO
	ragnar-hojland.com") by vger.kernel.org with ESMTP
	id <S289114AbSBDRLi>; Mon, 4 Feb 2002 12:11:38 -0500
Date: Mon, 4 Feb 2002 11:19:28 +0100
From: Ragnar Hojland Espinosa <ragnar@jazzfree.com>
To: Oliver Feiler <kiza@gmx.net>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] (was: Re: fixup descriptions in pci-pc.c)
Message-ID: <20020204111928.A2356@ragnar-hojland.com>
In-Reply-To: <20020203152913.A533@gmx.net> <Pine.LNX.4.30.0202032342400.1158-100000@rtlab.med.cornell.edu> <20020204114644.A331@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020204114644.A331@gmx.net>; from kiza@gmx.net on Mon, Feb 04, 2002 at 11:46:44AM +0100
Organization: Mediocrity Naysayers Ltd
X-Homepage: http://lightside.eresmas.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2002 at 11:46:44AM +0100, Oliver Feiler wrote:
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

Even more meaningful:

	"Disabling VIA Northbridge broken memory write queue.\n"

-- 
____/|  Ragnar Højland      Freedom - Linux - OpenGL |    Brainbench MVP
\ o.O|  PGP94C4B2F0D27DE025BE2302C104B78C56 B72F0822 | for Unix Programming
 =(_)=  "Thou shalt not follow the NULL pointer for  | (www.brainbench.com)
   U     chaos and madness await thee at its end."      [56 pend. Jan  8]
