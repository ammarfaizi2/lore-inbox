Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317422AbSFXGa7>; Mon, 24 Jun 2002 02:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317418AbSFXGa6>; Mon, 24 Jun 2002 02:30:58 -0400
Received: from se1.cogenit.fr ([195.68.53.173]:2268 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S317416AbSFXGa4>;
	Mon, 24 Jun 2002 02:30:56 -0400
Date: Mon, 24 Jun 2002 08:30:36 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: Frank Davis <fdavis@si.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.24 : drivers/scsi/inia100.c
Message-ID: <20020624083036.A22534@fafner.intra.cogenit.fr>
References: <Pine.LNX.4.44.0206232343280.909-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0206232343280.909-100000@localhost.localdomain>; from fdavis@si.rr.com on Sun, Jun 23, 2002 at 11:46:23PM -0400
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Frank Davis <fdavis@si.rr.com> :
> Hello all,
>   This patch adds the DMA mapping check (1st step for 
> Documentation/DMA-mapping.txt compliance). Please review.

- please take a look at Documentation/CodingStyle
- if pci_set_dma_mask() fails, the driver shouldn't go on as if nothing 
  happened. See what other drivers do (net/acenic.c for example)
- the interesting part of DMA mapping conversion is more a matter of
  memory descriptor handling (and phys_to_virt/friends removal)

-- 
Ueimor
