Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268900AbUIMUJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268900AbUIMUJO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 16:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268922AbUIMUJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 16:09:13 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:9667 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S268900AbUIMUJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 16:09:09 -0400
Date: Mon, 13 Sep 2004 22:08:58 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Calling syscalls from x86-64 kernel results in a crash on Opteron machines
Message-ID: <20040913200858.GF4180@dualathlon.random>
References: <4145A8E1.8010409@qlusters.com> <20040913153803.A27282@infradead.org> <4145B750.6060900@qlusters.com> <20040913161735.GC4180@dualathlon.random> <20040913094148.45509d9c@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040913094148.45509d9c@dell_ss3.pdx.osdl.net>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 09:41:48AM -0700, Stephen Hemminger wrote:
> Actually, the fact that system calls work in kernel space I would consider
> a BUG.  The int 0x80 handler should oops or at least kill the offending
> thread for security and robustness reasons.

kernel_thread is using int 0x80 in x86, and yes, that should better
implemented without it (like we did in x86-64).
