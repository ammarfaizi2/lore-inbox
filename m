Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272997AbTHFAVx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 20:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272998AbTHFAVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 20:21:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:31911 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272997AbTHFAVg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 20:21:36 -0400
Date: Tue, 5 Aug 2003 17:23:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make mm4 compile on ppc
Message-Id: <20030805172314.0f2c0a5b.akpm@osdl.org>
In-Reply-To: <16176.18643.751075.223016@cargo.ozlabs.ibm.com>
References: <16176.18643.751075.223016@cargo.ozlabs.ibm.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras <paulus@samba.org> wrote:
>
> Andrew,
> 
> This patch gets -mm4 to compile and boot for me.

Great, thanks.

> I have only tried UP
> so far.  It's not completely happy though: I got several messages
> saying "INIT: /dev/initctl is not a fifo", and gdm failed to start.
> Not sure what is wrong.

Is current -linus OK?

> You'll notice I had to take out include/asm/asm_offsets.h from the
> dependencies for arch/$(ARCH)/vmlinux.lds.s, basically because ppc
> doesn't have an asm_offsets.h (we call it just offsets.h).  It's not
> clear to me why vmlinux.lds.s would ever depend on structure offsets,
> but if it does, surely this dependency should go in the arch-specific
> Makefile?

Yes, the dependency of vmlinux.lds.[so] on CONFIG_FOO has confused the heck
out of kbuild.  Kai and Sam are working on it and patches are flying about.

