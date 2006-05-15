Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964975AbWEOPO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964975AbWEOPO3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 11:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbWEOPO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 11:14:28 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60622 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964975AbWEOPO1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 11:14:27 -0400
Subject: Re: [PATCH] ide_dma_speed() fixes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, bzolnier@gmail.com,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060515080053.296c4c55.akpm@osdl.org>
References: <4463F4C8.9080608@ru.mvista.com>
	 <20060514050548.5399e3f4.akpm@osdl.org> <446885BE.4090404@ru.mvista.com>
	 <20060515080053.296c4c55.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 15 May 2006 16:27:04 +0100
Message-Id: <1147706824.26686.66.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-05-15 at 08:00 -0700, Andrew Morton wrote:
>  
>  	/* Capable of UltraDMA modes? */
> -	if (id->field_valid & 4)
> -		ultra_mask = id->dma_ultra & hwif->ultra_mask;
> -	else
> +	ultra_mask = id->dma_ultra & hwif->ultra_mask;
> +
> +	if (!(id->field_valid & 4))
>  		mode = 0;	/* fallback to MW/SW DMA if no UltraDMA */
>  

Looks fine to me, id-> is always the full 512 bytes of data so its safe
to do that.

