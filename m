Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262128AbTCHSBZ>; Sat, 8 Mar 2003 13:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262129AbTCHSBZ>; Sat, 8 Mar 2003 13:01:25 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:53003 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262128AbTCHSBY>; Sat, 8 Mar 2003 13:01:24 -0500
Date: Sat, 8 Mar 2003 18:12:00 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Lukas@Razik.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG 380][PATCHv2] SB16 compile errors
Message-ID: <20030308181200.A30342@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, Lukas@Razik.de,
	linux-kernel@vger.kernel.org
References: <3E6A3FAE.26113.1A49791@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E6A3FAE.26113.1A49791@localhost>; from Lukas@Razik.de on Sat, Mar 08, 2003 at 07:08:30PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 08, 2003 at 07:08:30PM +0100, Lukas@Razik.de wrote:
>  #include <linux/slab.h>
>  #ifndef LINUX_ISAPNP_H
>  #include <linux/isapnp.h>
> -#define isapnp_card pci_bus
> -#define isapnp_dev pci_dev
> +#define isapnp_card pnp_card
> +#define isapnp_dev pnp_dev
>  #endif

No, no, no - this is a mess!  Rip out those ugly ifdefs and just use
the native typedefs directly.

IT might be worth to switch over to 2.5-style drivers completly, btw.
