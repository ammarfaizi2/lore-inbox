Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265805AbUJLOuD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265805AbUJLOuD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 10:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265697AbUJLOrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 10:47:52 -0400
Received: from ipx20189.ipxserver.de ([80.190.249.56]:64645 "EHLO
	ipx20189.ipxserver.de") by vger.kernel.org with ESMTP
	id S264980AbUJLOq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 10:46:57 -0400
Date: Tue, 12 Oct 2004 17:47:06 +0300 (EAT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Nathan Lynch <nathanl@austin.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] i386 CPU hotplug updated for -mm
In-Reply-To: <1097560787.6557.99.camel@biclops>
Message-ID: <Pine.LNX.4.61.0410121743420.4190@musoma.fsmlabs.com>
References: <20041001204533.GA18684@elte.hu>  <20041001204642.GA18750@elte.hu>
 <20041001143332.7e3a5aba.akpm@osdl.org>  <Pine.LNX.4.61.0410091550300.2870@musoma.fsmlabs.com>
  <Pine.LNX.4.61.0410102302170.2745@musoma.fsmlabs.com> <1097560787.6557.99.camel@biclops>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Oct 2004, Nathan Lynch wrote:

> Unable to handle kernel NULL pointer dereference at virtual address 00000004
>  printing eip:
> c0145703
> *pde = 00000000
> Oops: 0000 [#1]
> PREEMPT SMP
> Modules linked in:
> CPU:    1

Ok, cpu1 took an interrupt and exploded, perhaps put a printk in 
show_regs() to say whether it was offline, an interrupt must have snuck in 
whilst it was offline.

>  [<c029f6cd>] ide_intr+0xbd/0x160
>  [<c0139d44>] handle_IRQ_event+0x34/0x70
>  [<c0139e6c>] __do_IRQ+0xec/0x170
>  [<c0108570>] do_IRQ+0x60/0xa0

Thanks,
	Zwane
