Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261427AbSKYRGq>; Mon, 25 Nov 2002 12:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261645AbSKYRGq>; Mon, 25 Nov 2002 12:06:46 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:23175 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261427AbSKYRGo> convert rfc822-to-8bit; Mon, 25 Nov 2002 12:06:44 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: WOLK - Working Overloaded Linux Kernel
To: Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [BUG] 2.4.20-rc2-ac3 oops (causer is DRM 4.3.x code)
Date: Mon, 25 Nov 2002 18:12:43 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@nl.linux.org>
References: <200211251711.59882.m.c.p@wolk-project.de> <1038243747.1372.0.camel@localhost.localdomain>
In-Reply-To: <1038243747.1372.0.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211251810.57377.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 November 2002 18:02, Arjan van de Ven wrote:

Hi Arjan,

> @ -622,16 +615,20 @@
>         if ( dev->dev_private ) {
>                 drm_r128_private_t *dev_priv = dev->dev_private;
>
> +#if __REALLY_HAVE_SG
>                 if ( !dev_priv->is_pci ) {
> +#endif
>                         DRM_IOREMAPFREE( dev_priv->cce_ring );
>                         DRM_IOREMAPFREE( dev_priv->ring_rptr );
>                         DRM_IOREMAPFREE( dev_priv->buffers );
> +#if __REALLY_HAVE_SG
>                 } else {
>                         if (!DRM(ati_pcigart_cleanup)( dev,
>                                                 dev_priv->phys_pci_gart,
>                                                 dev_priv->bus_pci_gart
> ))
>                                 DRM_ERROR( "failed to cleanup PCI
> GART!\n" );
>                 }
> +#endif
sorry for eventually stupidity, but? ... REALLY_HAVE_SG?

ciao, Marc


