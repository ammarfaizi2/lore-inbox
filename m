Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263110AbVCXPis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263110AbVCXPis (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 10:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263098AbVCXPgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 10:36:33 -0500
Received: from [217.222.53.238] ([217.222.53.238]:387 "EHLO mail.gts.it")
	by vger.kernel.org with ESMTP id S262805AbVCXPbk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 10:31:40 -0500
From: Stefano Rivoir <s.rivoir@gts.it>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Subject: Re: 2.6.12-rc1-mm2
Date: Thu, 24 Mar 2005 16:31:30 +0100
User-Agent: KMail/1.8
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Dave Airlie <airlied@gmail.com>
References: <20050324044114.5aa5b166.akpm@osdl.org> <200503241540.33012.s.rivoir@gts.it> <4242DA5A.4020904@ens-lyon.org>
In-Reply-To: <4242DA5A.4020904@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200503241631.30681.s.rivoir@gts.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 16:18, giovedì 24 marzo 2005, Brice Goglin ha scritto:
> Stefano Rivoir a écrit :
> > Alle 13:41, giovedì 24 marzo 2005, Andrew Morton ha scritto:
> >>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc1/
> >>2. 6.12-rc1-mm2/
> >>
> >>
> >>- Some fixes for the recent DRM problems.
> >
> > Hi Andrew,
> >
> > While I was OK with DRM up to 2.6.12-rc1-mm1, now I get this at startup,
> > and Xorg fails to enable DRI (attached, lspci and .config):

> --- linux-mm/include/linux/agp_backend.h.old    2005-03-24
> 16:17:25.000000000 +0100
> +++ linux-mm/include/linux/agp_backend.h        2005-03-24
> 16:10:25.000000000 +0100
> @@ -100,6 +100,7 @@
>   extern int agp_bind_memory(struct agp_memory *, off_t);
>   extern int agp_unbind_memory(struct agp_memory *);
>   extern void agp_enable(struct agp_bridge_data *, u32);
> +extern struct agp_bridge_data * (*agp_find_bridge)(struct pci_dev *);
>   extern struct agp_bridge_data *agp_backend_acquire(struct pci_dev *);
>   extern void agp_backend_release(struct agp_bridge_data *);

Right, that fixed it for me.

Thank you.

-- 
Stefano Rivoir
