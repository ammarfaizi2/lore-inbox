Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290679AbSBFRQb>; Wed, 6 Feb 2002 12:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290684AbSBFRQW>; Wed, 6 Feb 2002 12:16:22 -0500
Received: from ns.caldera.de ([212.34.180.1]:43921 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S290679AbSBFRQN>;
	Wed, 6 Feb 2002 12:16:13 -0500
Date: Wed, 6 Feb 2002 18:15:16 +0100
From: Christoph Hellwig <hch@caldera.de>
Cc: "David S. Miller" <davem@redhat.com>, davidm@hpl.hp.com,
        mmadore@turbolinux.com, linux-ia64@linuxia64.org,
        linux-kernel@vger.kernel.org, groudier@free.fr
Subject: Re: [Linux-ia64] Proper fix for sym53c8xx_2 driver and dma64_addr_t
Message-ID: <20020206181516.A11872@caldera.de>
In-Reply-To: <20020206092129.A8739@caldera.de> <20020206.002906.94555802.davem@redhat.com> <20020206093558.A9445@caldera.de> <20020206.004503.118628125.davem@redhat.com> <20020206181042.A11683@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020206181042.A11683@caldera.de>; from hch@caldera.de on Wed, Feb 06, 2002 at 06:10:42PM +0100
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2002 at 06:10:42PM +0100, Christoph Hellwig wrote:
> On Wed, Feb 06, 2002 at 12:45:03AM -0800, David S. Miller wrote:
> > It is not using the DMA apis correctly then, it should be using
> > dma_addr_t which may or may not be 64-bits on a given platform.
> 
> When the sym2 driver is configured with SYM_CONF_DMA_ADDRESSING_MOD > 1
> it uses DAC accessing and needs dma64_addr_t.  It doesn't use it
> when using the default addressing mode.

Sorry, it doesn't use the _dac_ APIs.  Still I'm the opinion that either
architecture should support dma64_addr_t or we need a HAVE_PCI_DAC_API
define.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
