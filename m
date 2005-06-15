Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbVFOTLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbVFOTLI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 15:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbVFOTLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 15:11:08 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:63873 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S261385AbVFOTKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 15:10:49 -0400
Date: Wed, 15 Jun 2005 21:10:26 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
cc: "Richard B. Johnson" <linux-os@analogic.com>,
       Gene Heskett <gene.heskett@verizon.net>, cutaway@bellsouth.net,
       linux-kernel@vger.kernel.org
Subject: Re: .../asm-i386/bitops.h  performance improvements
In-Reply-To: <Pine.LNX.4.61L.0506151723460.13835@blysk.ds.pg.gda.pl>
Message-ID: <Pine.LNX.4.58.0506152053010.3184@be1.lrz>
References: <4fB8l-73q-9@gated-at.bofh.it> <4fF2j-1Lo-19@gated-at.bofh.it>
 <E1DiZKe-0000em-58@be1.7eggert.dyndns.org> <Pine.LNX.4.61L.0506151629270.13835@blysk.ds.pg.gda.pl>
 <Pine.LNX.4.61.0506151200490.24211@chaos.analogic.com>
 <Pine.LNX.4.61L.0506151723460.13835@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jun 2005, Maciej W. Rozycki wrote:
> On Wed, 15 Jun 2005, Richard B. Johnson wrote:

> > Well the __documented__ '486 LEA instruction doesn't
> > even allow the double-register indirect. It's just
> > 
> > LEA r16,m
> > LEA r32,m
> > 
> > ... repeated twice
> > 
> > Page 26-190,  Intel486(tm) Microprocessor Programmer's Reference
> > Manual. ISBN 1-55512-195-4. The instruction may have been one
> > of those "immature features", read broken.
> 
>  And "m" is presumably described in details elsewhere as the semantics is 
> common for all instructions involving address calculation.

My documentation says:

lea reg16, mem
Available on 8086, 80186, 80286, 80386, 80486
32-bit-extension available
Opcode: 8D mod reg r/m

reg will be the target register (AX .. DI), and mod and r/m will select
something like a direct address, a register or a combination like 
BP+DI+ofs (I won't copy the table). A multiplier is not mentioned there.
-- 
Microwave: Signal from a friendly micro... 
