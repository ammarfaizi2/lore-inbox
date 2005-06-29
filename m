Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262604AbVF2QUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262604AbVF2QUQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 12:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262596AbVF2QT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 12:19:29 -0400
Received: from node-40240a4a.sjc.onnet.us.uu.net ([64.36.10.74]:3848 "EHLO
	sphinx.zankel.net") by vger.kernel.org with ESMTP id S262506AbVF2QPh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 12:15:37 -0400
Message-ID: <42C2CAB8.1080402@zankel.net>
Date: Wed, 29 Jun 2005 09:22:16 -0700
From: Christian Zankel <chris@zankel.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050210)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Xtensa syscalls (Was: Re: 2.6.12-rc5-mm1)
References: <20050525134933.5c22234a.akpm@osdl.org> <200505272313.20734.arnd@arndb.de> <20050528070714.GB17005@infradead.org> <200506291542.02618.arnd@arndb.de>
In-Reply-To: <200506291542.02618.arnd@arndb.de>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
>>>Chris, are there any existing binaries that rely on your implementations
>>>of old_mmap, sys_fork, sys_vfork, sys_olduname or sys_ipc and need to
>>>work with future kernels? Otherwise, you should probably drop these.
>>>For sys_ipc, you would need to add the subcalls directly to the table,
>>>like parisc does.
> Hmm, xtensa is now in -rc1, with the obsolete syscalls still in there,
> so I guess this about the last chance to correct the ABI. Applying the
> patch obviously breaks all sorts of user space binaries and probably
> also requires the appropriate changes to be made to libc.

I have to admit, the -rc1 caught me a bit by surprise; I have a few 
patches pending that I want to send out today.

The question is, if we had to break glibc compatibility, shouldn't we 
use the opportunity to clean-up the syscall list? It was copied from 
MIPS and, thus, has inherited a lot of legacy from there. As a new 
architecture, maybe we should even go as far as removing all ni-syscalls 
and start fresh?

> On the other hand, if a decision is made to keep the broken interface,
> it should at least be a conscious one instead of an oversight.

I will try out your patch and see if there are any obvious problems.

Thanks,
~Chris
