Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290570AbSBFRPl>; Wed, 6 Feb 2002 12:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290679AbSBFRPb>; Wed, 6 Feb 2002 12:15:31 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:15060 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S290570AbSBFRP3>;
	Wed, 6 Feb 2002 12:15:29 -0500
From: David Mosberger <davidm@hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15457.25770.707397.595744@napali.hpl.hp.com>
Date: Wed, 6 Feb 2002 09:15:22 -0800
To: Christoph Hellwig <hch@caldera.de>
Cc: "David S. Miller" <davem@redhat.com>, davidm@hpl.hp.com,
        mmadore@turbolinux.com, linux-ia64@linuxia64.org,
        linux-kernel@vger.kernel.org, groudier@free.fr
Subject: Re: [Linux-ia64] Proper fix for sym53c8xx_2 driver and dma64_addr_t
In-Reply-To: <20020206181042.A11683@caldera.de>
In-Reply-To: <20020206092129.A8739@caldera.de>
	<20020206.002906.94555802.davem@redhat.com>
	<20020206093558.A9445@caldera.de>
	<20020206.004503.118628125.davem@redhat.com>
	<20020206181042.A11683@caldera.de>
X-Mailer: VM 7.00 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 6 Feb 2002 18:10:42 +0100, Christoph Hellwig <hch@caldera.de> said:

  Christoph> On Wed, Feb 06, 2002 at 12:45:03AM -0800, David S. Miller
  Christoph> wrote:
  >> It is not using the DMA apis correctly then, it should be using
  >> dma_addr_t which may or may not be 64-bits on a given platform.

  Christoph> When the sym2 driver is configured with
  Christoph> SYM_CONF_DMA_ADDRESSING_MOD > 1 it uses DAC accessing and
  Christoph> needs dma64_addr_t.  It doesn't use it when using the
  Christoph> default addressing mode.

The driver never uses the pci_dac* interface, hence it should not use
dma64_addr_t.  If the driver needs a 64-bit wide type, u64 will do
fine.

	--david
