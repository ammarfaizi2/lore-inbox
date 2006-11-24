Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934639AbWKXWfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934639AbWKXWfg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 17:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934646AbWKXWfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 17:35:36 -0500
Received: from mail-gw3.sa.ew.hu ([212.108.200.82]:65483 "EHLO
	mail-gw3.sa.ew.hu") by vger.kernel.org with ESMTP id S934639AbWKXWfg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 17:35:36 -0500
To: jdike@addtoit.com
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
In-reply-to: <20061124203422.GE4745@ccure.user-mode-linux.org> (message from
	Jeff Dike on Fri, 24 Nov 2006 15:34:22 -0500)
Subject: Re: UML compile problems on -mm
References: <E1GnXeZ-00052H-00@dorka.pomaz.szeredi.hu> <20061124203422.GE4745@ccure.user-mode-linux.org>
Message-Id: <E1Gnjd8-0007Ee-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 24 Nov 2006 23:34:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > it still fails on linking:
> > 
> >   LD      .tmp_vmlinux1
> > lib/lib.a(bug.o): In function `find_bug':
> > lib/bug.c:108: undefined reference to `__start___bug_table'
> 
> rc6-mm1 builds and boots here fine.
> 
> The bug table stuff is defined in asm-generic/vmlinux.lds.S, which is
> pulled in through arch/um/kernel/dyn.lds.S and asm-um/common.lds.S.

You mean /asm-generic/vmlinux.lds.h?

That one defines the macro named BUG_TABLE, but does not use it.  And
AFAICS neither does the other two files you mentioned.

So there's somthing fishy going on ;)

Miklos
