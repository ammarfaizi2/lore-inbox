Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135755AbRAVXgR>; Mon, 22 Jan 2001 18:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135742AbRAVXf7>; Mon, 22 Jan 2001 18:35:59 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:30478 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135716AbRAVXfn>; Mon, 22 Jan 2001 18:35:43 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Partition IDs in the New World TM
Date: 22 Jan 2001 15:35:14 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <94ig3i$4lg$1@cesium.transmeta.com>
In-Reply-To: <200101222139.f0MLd8r01730@flint.arm.linux.org.uk> <3A6CB49E.75B8937D@conectiva.com.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3A6CB49E.75B8937D@conectiva.com.br>
By author:    Andrew Clausen <clausen@conectiva.com.br>
In newsgroup: linux.dev.kernel
> 
> > Apart from
> > that, the kernel couldn't care.  You could set all your Ext2 partitions
> > as ID 82, your swap as ID 83 and Linux would carry on as if nothing had
> > changed.
> 
> Exactly.  So, for new disk labels, or whatever, we should recommend to
> the relevant hackers that we have exactly one number for Linux.  Or
> what?
> 

We have:

   0x82 - Linux swap
   0x83 - Linux filesystem
   0x85 - Linux extended partition (yes, this one does matter!)

0x81 isn't Linux, but rather a Minix partition ID.

There seems to be some value in having a different value for swap.  It
lets an automatic program find a partition that does not contain data.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
