Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261367AbSJCUWl>; Thu, 3 Oct 2002 16:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261376AbSJCUWl>; Thu, 3 Oct 2002 16:22:41 -0400
Received: from air-2.osdl.org ([65.172.181.6]:28310 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S261367AbSJCUWk>;
	Thu, 3 Oct 2002 16:22:40 -0400
Date: Thu, 3 Oct 2002 13:29:18 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Bryan Hundven <bryanh@nventure.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: SMP: errors.
In-Reply-To: <3D9B85A8.4050803@nventure.com>
Message-ID: <Pine.LNX.4.44.0210031325530.1871-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 2 Oct 2002, Bryan Hundven wrote:

> The dmesg for my kernel is attached, which should explain it all.
> 
> The errors that I am concerned about are:
>     bad: scheduling while atomic!
> and...
>     Debug: sleeping function called from illegal context at slab.c:1374
> 
> This next one really isn't an error, but I have seen this in 2.4 as 
> well... The motherboard is an asus p2b-d.
>     mtrr: v2.0 (20020519)
>     mtrr: your CPUs had inconsistent fixed MTRR settings
>     mtrr: your CPUs had inconsistent variable MTRR settings
>     mtrr: probably your BIOS does not setup all CPUs
> 
> When my computer starts up it says it found 2 cpu's. So if the bios says 
> it found 2 cpu's, it doesn't mean that it set them up?

Most SMP boxes I've seen emit the same warning. It's because the mtrr 
settings aren't the same on every CPU, which doesn't really matter anyway, 
since we reinitialize the other CPUs on boot anyway. Just another silly 
warning..

	-pat

