Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268002AbTAIT7l>; Thu, 9 Jan 2003 14:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268003AbTAIT7k>; Thu, 9 Jan 2003 14:59:40 -0500
Received: from chaos.analogic.com ([204.178.40.224]:35200 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S268002AbTAIT7j>; Thu, 9 Jan 2003 14:59:39 -0500
Date: Thu, 9 Jan 2003 15:09:45 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Luca Barbieri <ldb@ldb.ods.org>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Use %ebp rather than %ebx for thread_info pointer
In-Reply-To: <20030109194935.GA2098@ldb>
Message-ID: <Pine.LNX.3.95.1030109150728.27501A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jan 2003, Luca Barbieri wrote:

> This patch changes assembly code that accesses thread_info to use %ebp
> rather than %ebx. 
> 
> This allows me to take advantage of the fact that %ebp is restored by
> user mode in the sysenter register pop removal patch.

If you use EBP as an index register, i.e., "movl (%ebp), %eax", it
will be relative to the SS, not ES or DS. Is this what you want?

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


