Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286174AbRLJHax>; Mon, 10 Dec 2001 02:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286180AbRLJHai>; Mon, 10 Dec 2001 02:30:38 -0500
Received: from gw.lowendale.com.au ([203.26.242.120]:60952 "EHLO
	marina.lowendale.com.au") by vger.kernel.org with ESMTP
	id <S286174AbRLJHaQ>; Mon, 10 Dec 2001 02:30:16 -0500
Date: Mon, 10 Dec 2001 18:45:44 +1100 (EST)
From: Neale Banks <neale@lowendale.com.au>
To: Hein Roehrig <hein@acm.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: network interface names ethX and renaming interfaces
In-Reply-To: <E16C7a8-00014B-00@qaip3>
Message-ID: <Pine.LNX.4.05.10112101829060.8110-100000@marina.lowendale.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Dec 2001, Hein Roehrig wrote:

> in Linux 2.2.20 I have a problem renaming the network interface dummy0
> to eth0 and then starting a regular ethernet driver --- I would like
> it to come up as eth1 but it comes up as eth0, messing up the dummy0
> interface.
> 
> Reading the source, it appears that in init_ethernev(), ethernet
> drivers claim device names according to the array ethdev_index and
> shoot down any device name eth0 claimed by a non-ethernet driver.

I presume you are refering to init_etherdev() in drivers/net/net_init.c ?

> Therefore it appears to me that SIOCSIFNAME should either disallow
> renaming to ethX or it should adjust ethdev_index.

I wonder why it doesn't either use dev_alloc_name() from
net/core/dev.c , or implement similar logic?

Regards,
Neale.

