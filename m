Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274955AbTHAVrk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 17:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274957AbTHAVrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 17:47:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:1740 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S274955AbTHAVrR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 17:47:17 -0400
Date: Fri, 1 Aug 2003 14:35:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Lenar =?ISO-8859-1?Q?L=F5hmus?= <lenar@vision.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops with 2.6.0-test2-mm2
Message-Id: <20030801143517.1cea7ccb.akpm@osdl.org>
In-Reply-To: <1059740447.28249.11.camel@vision.dev>
References: <1059740447.28249.11.camel@vision.dev>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lenar Lõhmus <lenar@vision.ee> wrote:
>
> Found following oops in my logs. Machine runs as if nothing happened.
> Kernel 2.6.0-test2-mm2. .config attached and utilversions appended.
> 
> AMD 2500+ barton with 1GB of memory (HIGHMEM enabled) on NF2 board.
> 
> Unable to handle kernel paging request at virtual address 02000014
> c0169e46
> *pde = 00000000
> Oops: 0000 [#1]
> CPU:    0
> EIP:    0060:[<c0169e46>]    Not tainted VLI
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010206
> eax: 02000000   ebx: c8454980   ecx: c8450e48   edx: c8450e48
> esi: c8450e38   edi: c1b56000   ebp: 0000000c   esp: c1b57e78

A single bit got set in %eax.  You probably have bad hardware.  Try running
memtest86 for 12 hours.


