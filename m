Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265093AbTAXUYz>; Fri, 24 Jan 2003 15:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265276AbTAXUYz>; Fri, 24 Jan 2003 15:24:55 -0500
Received: from havoc.daloft.com ([64.213.145.173]:12479 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S265093AbTAXUYy>;
	Fri, 24 Jan 2003 15:24:54 -0500
Date: Fri, 24 Jan 2003 15:34:02 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: "Wiedemeier, Jeff" <Jeff.Wiedemeier@hp.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       "David S. Miller" <davem@redhat.com>, willy@debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2.5] tg3.c: pci_{save,restore}_extended_state
Message-ID: <20030124203402.GA4975@gtf.org>
References: <20030124212748.C25285@jurassic.park.msu.ru> <20030124193135.GA30884@gtf.org> <20030124150006.A2882@dsnt25.mro.cpqcorp.net> <20030124200538.GB30884@gtf.org> <20030124152453.A4081@dsnt25.mro.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030124152453.A4081@dsnt25.mro.cpqcorp.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2003 at 03:24:53PM -0500, Wiedemeier, Jeff wrote:
> On Fri, Jan 24, 2003 at 03:05:38PM -0500, Jeff Garzik wrote:
> > That implies we should be disabling PCI_MSI_FLAGS_ENABLE when we first
> > initialize each board, if hardware reset does not automatically do that
> > for us...
> 
> A true hardware reset does reset this bit. It should only be disabled
> arbitrarily if the intent is to *never* use MSI. 

Yes, that's the intent :)


> If the intent is to just not use MSI on tg3 devices, I can use the pci
> quirks to make sure that MSI gets turned off for tg3 devices.

hmmm, maybe I am missing something?

AFAICS, this is a per-driver decision, and needs to be done at the
driver level, in the tg3 driver source.

A quirk would need to be carried to every other PCI-capable
architecture, and every PCI-capable arch would need to be changed if
tg3 suddenly started using MSI again.

	Jeff



