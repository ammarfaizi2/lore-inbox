Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284285AbRLMPnJ>; Thu, 13 Dec 2001 10:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284282AbRLMPm7>; Thu, 13 Dec 2001 10:42:59 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:36622 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S284285AbRLMPmt>; Thu, 13 Dec 2001 10:42:49 -0500
Date: Thu, 13 Dec 2001 16:42:05 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: <roman@serv>
To: Alexander Viro <viro@math.psu.edu>
cc: "David C. Hansen" <haveblue@us.ibm.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Change locking in block_dev.c:do_open()
In-Reply-To: <Pine.GSO.4.21.0112122101350.17470-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0112131629280.12325-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 12 Dec 2001, Alexander Viro wrote:

> that area is not BKL.  It's *!@& damn devfs=only mess and code that does
> direct assignment of ->bd_op before calling blkdev_get().  Until it's solved
> (and the only decent way I see is to remove this misfeature) I'd seriously
> recommend to leave the damn thing as is.

If it prevents a blkdev cleanup, I'd say we disable it at least and if it
should be really needed, we can still fix it later. Is anyone actually
using "devfs=only"? What's the use of it anyway? It only disables the
ability to address a driver by dev_t, I didn't know we want to go that
far.

bye, Roman

