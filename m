Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262758AbUDOVAR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 17:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262132AbUDOVAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 17:00:16 -0400
Received: from hera.kernel.org ([63.209.29.2]:18873 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262758AbUDOU64 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 16:58:56 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: [PATCH] more i386 head.S cleanups
Date: Thu, 15 Apr 2004 20:58:42 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c5mt22$vlf$1@terminus.zytor.com>
References: <406ECAE7.1020407@quark.didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1082062722 32433 63.209.29.3 (15 Apr 2004 20:58:42 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Thu, 15 Apr 2004 20:58:42 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <406ECAE7.1020407@quark.didntduck.org>
By author:    Brian Gerst <bgerst@didntduck.org>
In newsgroup: linux.dev.kernel
> 
> - Move empty_zero_page and swapper_pg_dir to BSS.  This requires that 
> BSS is cleared earlier, but reclaims over 3k that was lost due to page 
> alignment.
> - Move stack_start, ready, and int_msg, boot_gdt_descr, idt_descr, and 
> cpu_gdt_descr to .data.  They were interfering with disassembly while in 
> .text.
> 

Some of them should be in .rodata instead of .data.

.data should only be used for modifiable numbers.

All in all these patches are a good idea; I had the same thoughts when
I was doing the changes to the boot page tables, but didn't want to
change too much at once.

	-hpa
