Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263441AbTDSTtt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 15:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263444AbTDSTtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 15:49:49 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:37900 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S263441AbTDSTts
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 15:49:48 -0400
Date: Sat, 19 Apr 2003 21:55:26 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/net/rcpci45 DMA mapping API conversion
Message-ID: <20030419215526.A3020@electric-eye.fr.zoreil.com>
References: <20030105144559.A2835@se1.cogenit.fr> <3EA19CF8.8030109@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3EA19CF8.8030109@pobox.com>; from jgarzik@pobox.com on Sat, Apr 19, 2003 at 03:01:12PM -0400
X-Organisation: Marie's fan club - III
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Re,

Jeff Garzik <jgarzik@pobox.com> :
[...]
> Ok, I finally got around to attacking this one.  Your patch looked ok to 
> me until I noticed one detail:
> 
>          pDpa->msgbuf = kmalloc (MSG_BUF_SIZE, GFP_DMA | GFP_KERNEL);
> 
> The GFP_DMA tag indicates that we can't just use pci_alloc_consistent in 
> the normal way, as we lose the GFP_DMA designator.

Does it mean the usual pci_set_dma_mask() cooking or something more elaborate ?

--
Ueimor
