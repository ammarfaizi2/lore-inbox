Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318232AbSHPHHU>; Fri, 16 Aug 2002 03:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318237AbSHPHHU>; Fri, 16 Aug 2002 03:07:20 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:11280
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S318232AbSHPHHT>; Fri, 16 Aug 2002 03:07:19 -0400
Date: Fri, 16 Aug 2002 00:01:52 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Markus Plail <plail@web.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: ide-2.4.19-ac4.11.patch, late but stable
In-Reply-To: <87elcz5mgi.fsf@plailis.homelinux.net>
Message-ID: <Pine.LNX.4.10.10208152353190.12468-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greetings Markus,

It is a fair question of which I do not have a nice answer.
I am working on fresh atapi-packet-generic engine but it is not a joy.
There are oddities like bus-phases or bus-states which their setup and
feeding of the DMA engine requires a more eligant hammer.

As much as I hate to concept of a DMA mempool, it looks like the direction
to follow.  Games such as HOST<>DEVICE || feast<>famine of buffer streams
appear to be the norm to push vast amounts of atapi-dma.  The alternative
is to have device level request queues and have the queues carry the SG or
PRD list for that portion.

I am open to suggestions for direction.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Fri, 16 Aug 2002, Markus Plail wrote:

> Hi Andre!
> 
> * Andre Hedrick writes:
> >It is out, require 2.4.19 plus -ac4
> >http://www.linuxdiskcert.org/ide-2.4.19-ac4.11.patch.bz2
> 
> How are chances that DMA will get enabled for higher blocksizes
> (c2scans, DAO cd writing, audio CD ripping)?
> Is there any progress on that field in 2.5.* kernels?
> 
> regards
> Markus
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

