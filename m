Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270451AbTGNQa7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 12:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270465AbTGNQa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 12:30:58 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:62684 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S270451AbTGNQar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 12:30:47 -0400
Date: Mon, 14 Jul 2003 13:43:00 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: James Bourne <jbourne@hardrock.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       marcelo@conectiva.com
Subject: Re: PATCH: fix agpgart list
In-Reply-To: <Pine.LNX.4.44.0307140939540.24584-100000@cafe.hardrock.org>
Message-ID: <Pine.LNX.4.55L.0307141342420.28660@freak.distro.conectiva>
References: <Pine.LNX.4.44.0307140939540.24584-100000@cafe.hardrock.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 14 Jul 2003, James Bourne wrote:

> On Mon, 14 Jul 2003, Alan Cox wrote:
>
> > diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.22-pre5/include/linux/agp_backend.h linux.22-pre5-ac1/include/linux/agp_backend.h
> > --- linux.22-pre5/include/linux/agp_backend.h	2003-07-14 12:27:43.000000000 +0100
> > +++ linux.22-pre5-ac1/include/linux/agp_backend.h	2003-07-14 13:05:58.000000000 +0100
> > @@ -66,6 +66,7 @@
> >  	VIA_APOLLO_KM266,
> >  	VIA_APOLLO_KT400,
> >  	VIA_APOLLO_P4M266,
> > +	VIA_APOLLO_P4X400,
> >  	SIS_GENERIC,
> >  	AMD_GENERIC,
> >  	AMD_IRONGATE,
>
> Hi,
> you'll also note a missing break; at the end of the case statement in
> agpsupport.c as follows
>
> --- linux-2.4.22pre5/drivers/char/drm-4.0/agpsupport.c~	2003-07-12 14:36:59.000000000 +0700
> +++ linux-2.4.22pre5/drivers/char/drm-4.0/agpsupport.c	2003-07-12 14:36:59.000000000 +0700
> @@ -278,6 +278,7 @@
>  		case VIA_APOLLO_KT400:  head->chipset = "VIA Apollo KT400";
>  			break;
>  		case VIA_APOLLO_P4X400:	head->chipset = "VIA Apollo P4X400";
> +			break;
>  #endif
>
>  		case VIA_APOLLO_PRO: 	head->chipset = "VIA Apollo Pro";

Patch applied, thanks.
