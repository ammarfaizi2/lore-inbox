Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270459AbTGNP2n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 11:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268476AbTGNP17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 11:27:59 -0400
Received: from s161-184-77-200.ab.hsia.telus.net ([161.184.77.200]:20162 "EHLO
	cafe.hardrock.org") by vger.kernel.org with ESMTP id S270111AbTGNP0i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 11:26:38 -0400
Date: Mon, 14 Jul 2003 09:41:12 -0600 (MDT)
From: James Bourne <jbourne@hardrock.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org, <marcelo@conectiva.com>
Subject: Re: PATCH: fix agpgart list
In-Reply-To: <200307141233.h6ECXfDN030980@hraefn.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0307140939540.24584-100000@cafe.hardrock.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jul 2003, Alan Cox wrote:

> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.22-pre5/include/linux/agp_backend.h linux.22-pre5-ac1/include/linux/agp_backend.h
> --- linux.22-pre5/include/linux/agp_backend.h	2003-07-14 12:27:43.000000000 +0100
> +++ linux.22-pre5-ac1/include/linux/agp_backend.h	2003-07-14 13:05:58.000000000 +0100
> @@ -66,6 +66,7 @@
>  	VIA_APOLLO_KM266,
>  	VIA_APOLLO_KT400,
>  	VIA_APOLLO_P4M266,
> +	VIA_APOLLO_P4X400,
>  	SIS_GENERIC,
>  	AMD_GENERIC,
>  	AMD_IRONGATE,

Hi,
you'll also note a missing break; at the end of the case statement in
agpsupport.c as follows

--- linux-2.4.22pre5/drivers/char/drm-4.0/agpsupport.c~	2003-07-12 14:36:59.000000000 +0700
+++ linux-2.4.22pre5/drivers/char/drm-4.0/agpsupport.c	2003-07-12 14:36:59.000000000 +0700
@@ -278,6 +278,7 @@
 		case VIA_APOLLO_KT400:  head->chipset = "VIA Apollo KT400";
 			break;
 		case VIA_APOLLO_P4X400:	head->chipset = "VIA Apollo P4X400";
+			break;
 #endif
 
 		case VIA_APOLLO_PRO: 	head->chipset = "VIA Apollo Pro";

------------------

regards

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
James Bourne                  | Email:            jbourne@hardrock.org          
Unix Systems Administrator    | WWW:           http://www.hardrock.org
Custom Unix Programming       | Linux:  The choice of a GNU generation
----------------------------------------------------------------------
 "All you need's an occasional kick in the philosophy." Frank Herbert  

