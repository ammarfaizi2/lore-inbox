Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935055AbWKXUiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935055AbWKXUiL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 15:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935054AbWKXUiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 15:38:09 -0500
Received: from [198.99.130.12] ([198.99.130.12]:17881 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S935051AbWKXUiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 15:38:06 -0500
Date: Fri, 24 Nov 2006 15:34:22 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: UML compile problems on -mm
Message-ID: <20061124203422.GE4745@ccure.user-mode-linux.org>
References: <E1GnXeZ-00052H-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1GnXeZ-00052H-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2006 at 10:47:27AM +0100, Miklos Szeredi wrote:
> it still fails on linking:
> 
>   LD      .tmp_vmlinux1
> lib/lib.a(bug.o): In function `find_bug':
> lib/bug.c:108: undefined reference to `__start___bug_table'

rc6-mm1 builds and boots here fine.

The bug table stuff is defined in asm-generic/vmlinux.lds.S, which is
pulled in through arch/um/kernel/dyn.lds.S and asm-um/common.lds.S.

				Jeff
-- 
Work email - jdike at linux dot intel dot com
