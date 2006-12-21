Return-Path: <linux-kernel-owner+w=401wt.eu-S1422695AbWLUE4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422695AbWLUE4H (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 23:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422717AbWLUE4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 23:56:07 -0500
Received: from smtp.osdl.org ([65.172.181.25]:37971 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422695AbWLUE4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 23:56:05 -0500
Date: Wed, 20 Dec 2006 20:55:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-mips@linux-mips.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc1 05/10] if_fddi.h: Add a missing inclusion
Message-Id: <20061220205555.9a48c327.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64N.0612201113410.11005@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0612201113410.11005@blysk.ds.pg.gda.pl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Dec 2006 12:01:55 +0000 (GMT)
"Maciej W. Rozycki" <macro@linux-mips.org> wrote:

>  This is a change to include <linux/netdevice.h> in <linux/if_fddi.h> 
> which is needed for "struct fddi_statistics".
> 
> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
> ---
> 
>  Please apply.
> 
>   Maciej
> 
> patch-mips-2.6.18-20060920-if_fddi-netdev-0
> diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/include/linux/if_fddi.h linux-mips-2.6.18-20060920/include/linux/if_fddi.h
> --- linux-mips-2.6.18-20060920.macro/include/linux/if_fddi.h	2006-09-20 20:51:20.000000000 +0000
> +++ linux-mips-2.6.18-20060920/include/linux/if_fddi.h	2006-12-14 04:36:58.000000000 +0000
> @@ -103,6 +103,8 @@ struct fddihdr
>  	} __attribute__ ((packed));
>  
>  #ifdef __KERNEL__
> +#include <linux/netdevice.h>
> +
>  /* Define FDDI statistics structure */
>  struct fddi_statistics {
>  

I'll treat this a a bugfix, unrelated to the turbochannel changes.

Which may be wrong, but I doubt it.
