Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290310AbSBFIrW>; Wed, 6 Feb 2002 03:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290309AbSBFIrL>; Wed, 6 Feb 2002 03:47:11 -0500
Received: from pizda.ninka.net ([216.101.162.242]:6797 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S290302AbSBFIqx>;
	Wed, 6 Feb 2002 03:46:53 -0500
Date: Wed, 06 Feb 2002 00:45:03 -0800 (PST)
Message-Id: <20020206.004503.118628125.davem@redhat.com>
To: hch@caldera.de
Cc: davidm@hpl.hp.com, mmadore@turbolinux.com, linux-ia64@linuxia64.org,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [Linux-ia64] Proper fix for sym53c8xx_2 driver and dma64_addr_t
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020206093558.A9445@caldera.de>
In-Reply-To: <20020206092129.A8739@caldera.de>
	<20020206.002906.94555802.davem@redhat.com>
	<20020206093558.A9445@caldera.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Christoph Hellwig <hch@caldera.de>
   Date: Wed, 6 Feb 2002 09:35:58 +0100

   On Wed, Feb 06, 2002 at 12:29:06AM -0800, David S. Miller wrote:
   > So who needs it? :-)
   
   The new sym53c8xx driver (sym2), and that one only if is actually is
   configured for DAC-mode (SYM_CONF_DMA_ADDRESSING_MODE > 0).

It is not using the DMA apis correctly then, it should be using
dma_addr_t which may or may not be 64-bits on a given platform.

The sym2 driver needs to be fixed.

Franks a lot,
David S. Miller
davem@redhat.com
