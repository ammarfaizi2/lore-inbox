Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270487AbUJTTkC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270487AbUJTTkC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 15:40:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270444AbUJTTcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 15:32:16 -0400
Received: from cantor.suse.de ([195.135.220.2]:39112 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S270431AbUJTTaO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 15:30:14 -0400
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Add key management syscalls to non-i386 archs
References: <3506.1098283455@redhat.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 20 Oct 2004 21:25:35 +0200
In-Reply-To: <3506.1098283455@redhat.com.suse.lists.linux.kernel>
Message-ID: <p73d5zdyyxc.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> writes:
>  /* Syscall protocol:
> diff -uNrp linux-2.6.9-bk4/include/asm-x86_64/unistd.h linux-2.6.9-bk4-keys/include/asm-x86_64/unistd.h
> --- linux-2.6.9-bk4/include/asm-x86_64/unistd.h	2004-10-19 10:42:16.000000000 +0100
> +++ linux-2.6.9-bk4-keys/include/asm-x86_64/unistd.h	2004-10-20 14:06:01.645026869 +0100
> @@ -556,8 +556,14 @@ __SYSCALL(__NR_mq_getsetattr, sys_mq_get
>  __SYSCALL(__NR_kexec_load, sys_ni_syscall)
>  #define __NR_waitid		247
>  __SYSCALL(__NR_waitid, sys_waitid)
> +#define __NR_add_key		248
> +__SYSCALL(__NR_add_key, sys_add_key)

Hey, I already allocated 248 for setaltroot. And no, you cannot
allocate system calls on your own without going through the 
architecture maintainer. The normal workflow is that you add
them to i386 and the other follow on their own.

Andrew, please don't apply the x86-64 parts of this.

-Andi
