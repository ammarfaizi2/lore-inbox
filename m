Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265126AbTAXT5J>; Fri, 24 Jan 2003 14:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265108AbTAXT5J>; Fri, 24 Jan 2003 14:57:09 -0500
Received: from havoc.daloft.com ([64.213.145.173]:6335 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S265095AbTAXT4b>;
	Fri, 24 Jan 2003 14:56:31 -0500
Date: Fri, 24 Jan 2003 15:05:38 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: "Wiedemeier, Jeff" <Jeff.Wiedemeier@hp.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       "David S. Miller" <davem@redhat.com>, willy@debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2.5] tg3.c: pci_{save,restore}_extended_state
Message-ID: <20030124200538.GB30884@gtf.org>
References: <20030124212748.C25285@jurassic.park.msu.ru> <20030124193135.GA30884@gtf.org> <20030124150006.A2882@dsnt25.mro.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030124150006.A2882@dsnt25.mro.cpqcorp.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2003 at 03:00:06PM -0500, Wiedemeier, Jeff wrote:
> The problem is that if the chip is configured for MSI (through config
> space) and the platform's irq mapping code therefore filled in
> pci_dev->irq with an appropriate vector for the MSI interrupt the chip
> is assigned instead of the LSI interrupt it may also be assigned, then
> unless MSGINT_MODE matches PCI_MSI_FLAGS_ENABLE, the driver will grab
> wrong interrupt.

That implies we should be disabling PCI_MSI_FLAGS_ENABLE when we first
initialize each board, if hardware reset does not automatically do that
for us...

	Jeff



