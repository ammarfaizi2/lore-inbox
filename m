Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271522AbRHPIjR>; Thu, 16 Aug 2001 04:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271523AbRHPIjH>; Thu, 16 Aug 2001 04:39:07 -0400
Received: from finch-post-12.mail.demon.net ([194.217.242.41]:40710 "EHLO
	finch-post-12.mail.demon.net") by vger.kernel.org with ESMTP
	id <S271522AbRHPIiz>; Thu, 16 Aug 2001 04:38:55 -0400
Date: Thu, 16 Aug 2001 09:37:58 +0100 (BST)
From: Steve Hill <steve@navaho.co.uk>
To: Andreas Dilger <adilger@turbolinux.com>
cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org
Subject: Re: /dev/random in 2.4.6
In-Reply-To: <200108151713.f7FHDg0n013420@webber.adilger.int>
Message-ID: <Pine.LNX.4.21.0108160934340.2107-100000@sorbus.navaho>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Aug 2001, Andreas Dilger wrote:

> Yes, it is possible to increase the size of the in-kernel entropy pool
> by changing the value in linux/drivers/char/random.c.  You will likely
> also need to fix up the user-space scripts that save and restore the
> entropy on shutdown/startup (they can check /proc/sys/kernel/random/poolsize,
> if available, to see how many bytes to read/write).

It didn't help - there just isn't enough entropy data being generated
between boot time and when I extract the random numbers.  This is
basically a system to install a linux distribution, so it's booted off the
network with a readonly root NFS, so there is no saved entropy data to
load, so I'm starting off with an empty entropy pool and having to rely on
the kernel to generate the data from scratch.  The random numbers are used
to initialise the ssh and VPN keys.

-- 

- Steve Hill
System Administrator         Email: steve@navaho.co.uk
Navaho Technologies Ltd.       Tel: +44-870-7034015

        ... Alcohol and calculus don't mix - Don't drink and derive! ...


