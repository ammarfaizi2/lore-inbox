Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267853AbTAHTdT>; Wed, 8 Jan 2003 14:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267854AbTAHTdT>; Wed, 8 Jan 2003 14:33:19 -0500
Received: from chaos.analogic.com ([204.178.40.224]:4738 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S267853AbTAHTdS>; Wed, 8 Jan 2003 14:33:18 -0500
Date: Wed, 8 Jan 2003 14:44:42 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: tenth post about PCI code, need help
In-Reply-To: <avhtlu$qr9$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.3.95.1030108143728.31888A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 Jan 2003, H. Peter Anvin wrote:

> Followup to:  <Pine.LNX.3.95.1030108132812.28791A-100000@chaos.analogic.com>
> By author:    "Richard B. Johnson" <root@chaos.analogic.com>
> In newsgroup: linux.dev.kernel
> > 
> > The problem is that he's discovered something that's not supposed
> > to be in the code. Only 32-bit accesses are supposed to be made to
> > the PCI controller ports. He has discovered that somebody has made
> > some 8-bit accesses that will not become configuration 'transactions'
> > because they are not 32 bits.
> > 
> 
> Right.  That's what the code is checking for.
> 
> 	-hpa

Somebody is very lucky the designer of the bus interface state-machine
let him get away with it. This is a borderline "insane instruction" that
could, on some (future?) machine, require a power-off to recover. This is
NotGood(tm). It's like testing a fuse by shorting out a circuit. If it
works, the circuit no longer works. If I doesn't, the circuit no longer
works. Some things should not be tested.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


