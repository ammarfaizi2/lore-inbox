Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267129AbTAURmi>; Tue, 21 Jan 2003 12:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267134AbTAURmi>; Tue, 21 Jan 2003 12:42:38 -0500
Received: from mta1.srv.hcvlny.cv.net ([167.206.5.4]:17870 "EHLO
	mta1.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S267129AbTAURmh>; Tue, 21 Jan 2003 12:42:37 -0500
Date: Tue, 21 Jan 2003 12:51:38 -0500
From: Mace Moneta <mace@monetafamily.org>
Subject: Re: [Problem] PCI resource conflicts in recent 2.4 kernels -	second try
In-reply-to: <20030121185222.A1359@jurassic.park.msu.ru>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org
Reply-to: mmoneta@optonline.net
Message-id: <1043171498.20312.27.camel@optonline.net>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.0
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <1042989167.7294.31.camel@optonline.net>
 <1043154817.25168.4.camel@optonline.net>
 <20030121185222.A1359@jurassic.park.msu.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, confirming that this corrected the problem.  Tested in 2.4.21-pre3.
Thanks for your help!


On Tue, 2003-01-21 at 10:52, Ivan Kokshaysky wrote:
> On Tue, Jan 21, 2003 at 08:13:38AM -0500, Mace Moneta wrote:
> > > 00:06.0 PCI bridge: Toshiba America Info Systems: Unknown device 0605 (rev 04)
> > > (prog-if 00 [Normal decode])
> 
> Yet another broken bridge...
> Does this patch help?
> 
> Ivan.
> 
> --- linux/drivers/pci/quirks.c.orig	Tue Jan 21 18:45:55 2003
> +++ linux/drivers/pci/quirks.c	Tue Jan 21 18:43:13 2003
> @@ -586,6 +586,7 @@ static struct pci_fixup pci_fixups[] __i
>  	 * instead of 0x01.
>  	 */
>  	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82380FB,	quirk_transparent_bridge },
> +	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_TOSHIBA,	0x605,				quirk_transparent_bridge },
>  
>  	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_CYRIX,	PCI_DEVICE_ID_CYRIX_PCI_MASTER, quirk_mediagx_master },
>  

