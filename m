Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266011AbVBDVpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266011AbVBDVpZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 16:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265117AbVBDVns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 16:43:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:39808 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265209AbVBDVNc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 16:13:32 -0500
Date: Fri, 4 Feb 2005 13:13:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: John Cherry <cherry@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc3-mm1 (compile stats)
Message-Id: <20050204131325.542c610c.akpm@osdl.org>
In-Reply-To: <1107549858.14618.2.camel@cherrypit.pdx.osdl.net>
References: <20050204103350.241a907a.akpm@osdl.org>
	<1107549858.14618.2.camel@cherrypit.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Cherry <cherry@osdl.org> wrote:
>
>  Errors in the build relate to an undefined reference to
>  "randomize_va_space"...
> 
>    LD      init/built-in.o
>    LD      .tmp_vmlinux1
>  arch/i386/kernel/built-in.o(.text+0xf92): In function `arch_align_stack':
>  : undefined reference to `randomize_va_space'
>  make: [.tmp_vmlinux1] Error 1 (ignored)

hm.  You must have CONFIG_SYSCTL=n?

I'll fix that up.
