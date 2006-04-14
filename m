Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751322AbWDNRkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbWDNRkM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 13:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbWDNRkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 13:40:12 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:27814 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1751322AbWDNRkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 13:40:11 -0400
Date: Fri, 14 Apr 2006 09:39:56 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Michael Madore <michael.madore@gmail.com>
cc: discuss@amd64.org, linux-kernel@vger.kernel.org
Subject: Re: Lockup/reboots on multiple dual core Opteron systems
In-Reply-To: <d4b6d3ea0604140948l36c8048ha819a6611c8fdad3@mail.gmail.com>
Message-ID: <Pine.LNX.4.62.0604140937440.17345@qynat.qvtvafvgr.pbz>
References: <d4b6d3ea0604140948l36c8048ha819a6611c8fdad3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Apr 2006, Michael Madore wrote:

> Hi,
>
> I have several dozen systems based on the AMD 8111/8131 chipset which
> are experiencing lockups or reboots while under heavy stress.  All
> systems are configured identically:
>
> (2) dual core Opteron 285 processors
> 8 GB RAM
> 1 IDE hard disk
>
> When the lockup occurs, there is no information printed to the screen,
> and magic sysrq does not work.   The systems will often lockup within
> a matter of hours, but sometimes they can run for several days before
> locking up.
>
> The testing involves:
>
> 1) Allocate several GB of memory from each node and read/write to it.
> 2) Perform lots of disk I/O
> 3) Keep all cores busy
>
> I see the lockup no matter which kernel I try:
>
> 2.6.5 (SLES 9)
> 2.6.9 (RHEL 4)
> 2.6.16 (kernel.org)
>
> The systems will run perfectly stable under the following conditions:
>
> 1) Use a 32-bit kernel
> or
> 2) Boot 64-bit kernel with mem=3000M
> or
> 3) Don't perform any disk I/O during the test
>
> I have also tested the dual core 8GB combination on both NForce and
> Serverworks based motherboards with the same results.  In this case
> both systems were using SATA hard disks instead of IDE.
>
> Any ideas what the culprit could be?
>
> Mike

I'm fighting similar problems on one machine at home (single dual core, 4G 
ram nforce 939 motherboard, 1 ide, 10 3ware, 1 adaptec controlled drives). 
It's locked up under the ubuntu and gentoo install disk kernels. I did 
have it running for a day and a half under 2.6.17-rc1, but I managed to 
corrupt the install and haven't gotten back to that kernel yet to confirm 
it's long-term stability.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare

