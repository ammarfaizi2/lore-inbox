Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266454AbUGKHEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266454AbUGKHEq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 03:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266508AbUGKHEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 03:04:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:50622 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266454AbUGKHEp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 03:04:45 -0400
Date: Sun, 11 Jul 2004 00:03:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Byron Stanoszek <gandalf@winds.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] 2.6.7 random oops in free_block()
Message-Id: <20040711000334.41d2397d.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.60.0407101726430.12382@winds.org>
References: <Pine.LNX.4.60.0407101726430.12382@winds.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Byron Stanoszek <gandalf@winds.org> wrote:
>
> Unable to handle kernel paging request at virtual address 01000004
>  c01382d8
>  *pde = 00000000
>  Oops: 0002 [#1]
>  CPU:    1
>  EIP:    0060:[<c01382d8>]    Not tainted
>  Using defaults from ksymoops -t elf32-i386 -a i386
>  EFLAGS: 00010012   (2.6.7)
>  eax: 01000000   ebx: c78ff000   ecx: c78ff040   edx: cda51040

A single bit set in %eax: probably a hardware fault.

Try running memtest86 for 24 hours.  That might detect it.
