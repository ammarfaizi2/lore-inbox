Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbUBZWyj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 17:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbUBZWxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 17:53:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34963 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261221AbUBZWxH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 17:53:07 -0500
Date: Thu, 26 Feb 2004 14:53:03 -0800
From: "David S. Miller" <davem@redhat.com>
To: Ricky Beam <jfbeam@bluetronic.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel/signal.c rev 1.101
Message-Id: <20040226145303.31067b62.davem@redhat.com>
In-Reply-To: <Pine.GSO.4.33.0402261719590.28488-100000@sweetums.bluetronic.net>
References: <Pine.GSO.4.33.0402261719590.28488-100000@sweetums.bluetronic.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Feb 2004 17:29:03 -0500 (EST)
Ricky Beam <jfbeam@bluetronic.net> wrote:

> Quote the changeset:
>   ======== kernel/signal.c 1.101 ========
>   D 1.101 04/02/26 03:26:02-08:00 akpm@osdl.org[torvalds] 116 115 0/3/2549
>   P kernel/signal.c
>   C Kill bogus __KERNEL_SYSCALLS usage
>   ------------------------------------------------
> 
> That's not "bogus usage" on sparc and sparc64 who's asm/signal.h requires
> __NR_restart_syscall.  Removing that breaks things in a way that's very
> non-trivial to fix without touching many more files.

Actually, it is sparc's responsibility to get the right stuff wherever
it defines ptrace_signal_deliver(), which is exactly how I'm going to
fix this.

Andrew's change is correct.
