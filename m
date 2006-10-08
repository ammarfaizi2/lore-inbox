Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbWJHBmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbWJHBmX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 21:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbWJHBmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 21:42:23 -0400
Received: from xenotime.net ([66.160.160.81]:26310 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750727AbWJHBmW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 21:42:22 -0400
Date: Sat, 7 Oct 2006 18:43:46 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Marcel Siegert <mws@twisted-brains.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.19-rc1 fix compilation/linking error in
 arch/x86_64_kernel/traps.c
Message-Id: <20061007184346.d29aa7e0.rdunlap@xenotime.net>
In-Reply-To: <452816A9.3080208@twisted-brains.org>
References: <452816A9.3080208@twisted-brains.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 07 Oct 2006 23:05:45 +0200 Marcel Siegert wrote:

> hi linus,
> 
> the following compilation error:
> 
> CC      arch/x86_64/kernel/traps.o
> arch/x86_64/kernel/traps.c: In function 'print_trace_warning_symbol':
> arch/x86_64/kernel/traps.c:375: warning: implicit declaration of function 'print_symbol'
> 
> causing the following linking error
> arch/x86_64/kernel/built-in.o: In function `print_trace_warning_symbol':
> traps.c:(.text+0x2f85): undefined reference to `print_symbol'
> make: *** [vmlinux] Error 1
> 
> is being fixed with the following patch.
> 
> 
> 
> Description: fix missing include of kallsyms.h in arch/x86_64/kernel/traps.c


see:
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=4b0ff1a94cba36a35734c84f377e49cacc77f293

or just use current git (or -gitN patch)

---
~Randy
