Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267193AbSLECnJ>; Wed, 4 Dec 2002 21:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267194AbSLECnJ>; Wed, 4 Dec 2002 21:43:09 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:14570 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S267193AbSLECnI>; Wed, 4 Dec 2002 21:43:08 -0500
To: David Gibson <david@gibson.dropbear.id.au>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, jgarzik@pobox.com,
       davem@redhat.com, James.Bottomley@SteelEye.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] generic device DMA implementation
References: <200212050121.RAA03254@adam.yggdrasil.com>
	<20021205024039.GB1500@zax.zax>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 05 Dec 2002 11:49:52 +0900
In-Reply-To: <20021205024039.GB1500@zax.zax>
Message-ID: <buolm35rxgv.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson <david@gibson.dropbear.id.au> writes:
> For cases like this, I'm talking about replacing the
> consistent_alloc() with a kmalloc(), then using the cache flush
> macros.  Is there any machine for which this is not sufficient?

I'm not entirely sure what you mean by `using the cache flush macros,'
but on one of my platforms, PCI consistent memory must be allocated from
a special area.

It's also not clear what you mean by `for cases like this' -- do you
mean, replace _all_ uses of xxx_alloc_consistent with kmalloc, or do you
mean just those cases where pci_alloc_consistent currently returns 0?

If the former, it obviously doesn't work on my platform; if the latter,
I guess this is what James' patch assumes the platform-specific
dma_alloc_consistent function will do.

-Miles
-- 
I'd rather be consing.
