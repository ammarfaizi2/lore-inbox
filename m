Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310164AbSB1WOA>; Thu, 28 Feb 2002 17:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310160AbSB1WMo>; Thu, 28 Feb 2002 17:12:44 -0500
Received: from chaos.analogic.com ([204.178.40.224]:4224 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S310158AbSB1WMC>; Thu, 28 Feb 2002 17:12:02 -0500
Date: Thu, 28 Feb 2002 17:12:30 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Hua Zhong <hzhong@cisco.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: question about running program from a RAM disk
In-Reply-To: <009e01c1c091$43426460$bb3147ab@amer.cisco.com>
Message-ID: <Pine.LNX.3.95.1020228170705.2670A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2002, Hua Zhong wrote:

> Hi all:
> 
> If I run a program from a RAM disk, will Linux be able to run it directly
> from
> the disk itself (as the image is already in memory), or do it the same way
> as running from a disk?
> 
> Thanks.
> 
> Hua

It does it the same was as from a mechanical disk. If it uses
dynamic linking, the default, the runtime libraries are
memory-mapped and shared. In a perfect system, a very large
program is not read into user's virtual address space all at
once. Page-faults bring in, or discard, pages as required.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

        111,111,111 * 111,111,111 = 12,345,678,987,654,321

