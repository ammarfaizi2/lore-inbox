Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbUD1WBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbUD1WBN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 18:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbUD1Tdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 15:33:50 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:24311 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S264932AbUD1Q2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 12:28:34 -0400
Date: Wed, 28 Apr 2004 09:28:33 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: akpm@osdl.org, Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] fix warning in arch/ppc/boot/simple/misc.c
Message-ID: <20040428162833.GL3731@smtp.west.cox.net>
References: <200404281614.i3SGEYMB013650@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404281614.i3SGEYMB013650@hera.kernel.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2004 at 03:14:38PM +0000, akpm@osdl.org wrote:

> ChangeSet 1.1596.2.5, 2004/04/28 08:14:38-07:00, akpm@osdl.org
> 
> 	[PATCH] fix warning in arch/ppc/boot/simple/misc.c
> 	
> 	From: Christoph Hellwig <hch@lst.de>
> 	
> 	asm-ppc/elf.h uses a pointer to struct task_struct without any
> 	forward-declaration.
> 	
> 	In file included from include/linux/elf.h:5,
> 	                 from arch/ppc/boot/simple/misc.c:20:
> 	include/asm/elf.h:102: warning: `struct task_struct' declared inside parameter list
> 	include/asm/elf.h:102: warning: its scope is only this definition or declaration, which is probably not what you want

This patch is redundant.  The correct fix, which got into -rc3, is to
drop <linux/elf.h> from the file in question.

-- 
Tom Rini
http://gate.crashing.org/~trini/
