Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290118AbSBFRMB>; Wed, 6 Feb 2002 12:12:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290570AbSBFRLx>; Wed, 6 Feb 2002 12:11:53 -0500
Received: from ns.caldera.de ([212.34.180.1]:34193 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S290118AbSBFRLr>;
	Wed, 6 Feb 2002 12:11:47 -0500
Date: Wed, 6 Feb 2002 18:10:42 +0100
From: Christoph Hellwig <hch@caldera.de>
To: "David S. Miller" <davem@redhat.com>
Cc: davidm@hpl.hp.com, mmadore@turbolinux.com, linux-ia64@linuxia64.org,
        linux-kernel@vger.kernel.org, groudier@free.fr
Subject: Re: [Linux-ia64] Proper fix for sym53c8xx_2 driver and dma64_addr_t
Message-ID: <20020206181042.A11683@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	"David S. Miller" <davem@redhat.com>, davidm@hpl.hp.com,
	mmadore@turbolinux.com, linux-ia64@linuxia64.org,
	linux-kernel@vger.kernel.org, groudier@free.fr
In-Reply-To: <20020206092129.A8739@caldera.de> <20020206.002906.94555802.davem@redhat.com> <20020206093558.A9445@caldera.de> <20020206.004503.118628125.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020206.004503.118628125.davem@redhat.com>; from davem@redhat.com on Wed, Feb 06, 2002 at 12:45:03AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2002 at 12:45:03AM -0800, David S. Miller wrote:
> It is not using the DMA apis correctly then, it should be using
> dma_addr_t which may or may not be 64-bits on a given platform.

When the sym2 driver is configured with SYM_CONF_DMA_ADDRESSING_MOD > 1
it uses DAC accessing and needs dma64_addr_t.  It doesn't use it
when using the default addressing mode.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
