Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288038AbSAUTxq>; Mon, 21 Jan 2002 14:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288010AbSAUTxg>; Mon, 21 Jan 2002 14:53:36 -0500
Received: from zeus.kernel.org ([204.152.189.113]:5514 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S288038AbSAUTx0>;
	Mon, 21 Jan 2002 14:53:26 -0500
Date: Mon, 21 Jan 2002 16:37:10 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18-pre4 bonding driver...
In-Reply-To: <15431.16084.190369.177282@charged.uio.no>
Message-ID: <Pine.LNX.4.21.0201211636300.1218-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 17 Jan 2002, Trond Myklebust wrote:

> 
> Marcelo,
> 
>  Is this code from linux-2.4.18-pre4/drivers/net/bonding.c safe?
> 
> static int bond_close(struct net_device *master)
> {
>        write_lock_irqsave(&bond->lock, flags);
> <snip>
>        bond_release_all(master);
> 
>        write_unlock_irqrestore(&bond->lock, flags);
> 
> AFAICS 'bond_release_all()' calls a bunch of lower level networking
> functions some of which do sleep. It does nothing to release the
> bond->lock when this occurs.

They are not safe, indeed.

Have you tried to contact the driver authors ? 

