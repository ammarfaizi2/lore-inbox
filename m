Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267632AbSLFWOF>; Fri, 6 Dec 2002 17:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267633AbSLFWOF>; Fri, 6 Dec 2002 17:14:05 -0500
Received: from h-64-105-35-8.SNVACAID.covad.net ([64.105.35.8]:53992 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S267632AbSLFWOE>; Fri, 6 Dec 2002 17:14:04 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 6 Dec 2002 14:17:21 -0800
Message-Id: <200212062217.OAA07073@adam.yggdrasil.com>
To: willy@debian.org
Subject: Re: [RFC] generic device DMA implementation
Cc: davem@redhat.com, James.Bottomley@steeleye.com,
       linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Dec 2002, Matthew Wilcox wrote:
>Leaving aside the T-class, machines that don't support io consistent memory
>generally have:
>
>(drivers that need io consistent memory):
[...]
> - zero to four EISA slots

	So it sounds like any EISA or ISA card could be plugged into
these machines.

	This makes me lean infinitesmally more toward a parameter
to dma_alloc rather than a separate dma_alloc_not_necessarily_consistent
function, because if there ever are other dma_alloc variations that
we want to support, it is more likely that there may be overlap
between the users of those features and then the number of
different function calls would have to grow exponentially (or
we might then talk about changing the API again, which is not
the end of the world, but is certainly more difficult than not
having to do so).

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
