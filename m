Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263413AbUDPQzs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 12:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263419AbUDPQzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 12:55:48 -0400
Received: from chaos.analogic.com ([204.178.40.224]:4992 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263413AbUDPQzq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 12:55:46 -0400
Date: Fri, 16 Apr 2004 12:55:33 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Ross Biro <ross.biro@gmail.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel writes to RAM it doesn't own on 2.4.24
In-Reply-To: <73979326.58EE2AD2@mail.gmail.com>
Message-ID: <Pine.LNX.4.53.0404161251570.10809@chaos>
References: <Pine.LNX.4.53.0404161150450.542@chaos> <73979326.58EE2AD2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Apr 2004, Ross Biro wrote:

> mem= isn't there to tell the kernel what ram it owns and what ram it
> doesn't own.  It's there to tell the kernel what ram is in the system.
>  Since you told the system it only has 500m, it assumes the rest of
> the 3.5G of address space is available for things like memory mapped
> i/o.  If you cat /proc/iomem, you'll probably see something has
> reserved the memory range in question.
>

No!  This is address space, not RAM. Whether or not a PCI device
or whatever has internal RAM that's mapped makes no difference.

I told the kernel that it has 500m of RAM. It better not assume
I don't know what I'm talking about. I might have reserved that
RAM because it's bad or I may have something else important to
do with that RAM (which I do).

> I added a hack to make the kernel assume the greater of the mem= and
> what is passed to in from the BIOS via the e820 maps is where the
> unused address space starts.  It seems to eliminate such problems.
>
>     Ross
>
> On Fri, 16 Apr 2004 11:55:28 -0400 (EDT), Richard B. Johnson
> <root@chaos.analogic.com> wrote:


Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (5596.77 BogoMips).
            Note 96.31% of all statistics are fiction.


