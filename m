Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270717AbRHPC6b>; Wed, 15 Aug 2001 22:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270716AbRHPC6V>; Wed, 15 Aug 2001 22:58:21 -0400
Received: from ns.caldera.de ([212.34.180.1]:42399 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S270715AbRHPC6F>;
	Wed, 15 Aug 2001 22:58:05 -0400
Date: Thu, 16 Aug 2001 04:57:34 +0200
Message-Id: <200108160257.f7G2vYA18080@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: kaos@ocs.com.au (Keith Owens)
Cc: linux-kernel@vger.kernel.org
Subject: Re: daddr_t is inconsistent and barely used
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <9980.997929632@kao2.melbourne.sgi.com>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <9980.997929632@kao2.melbourne.sgi.com> you wrote:
> daddr_t is barely used in the kernel.  2.4.8.
>
> The use of daddr_t in freevxfs may give different in core and disk
> layouts on different machines.  Is that intended?.

No, it may not.  Please double check.

> Do we still need daddr_t?

I think so, in fact we really should use daddr_t for all incore disk
addessing.

> This question was raised when I saw patches for ia64 that replaced u32
> with unsigned long because ia64 needs 64 bit.  Shouldn't we be using a
> consistent type that holds kernel addresses as numbers?  off_t and
> loff_t are not suitable.  caddr_t is close but uses char *, sometimes
> you want just a number.  What about defining kaddr_t?

vaddr_t?  That's consintant to virt_to_phys, virt_to_bus, etc.. and
what SVR5 uses.

	Christoph


-- 
Whip me.  Beat me.  Make me maintain AIX.
