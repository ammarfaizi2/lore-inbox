Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751532AbWIDTHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbWIDTHt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 15:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751534AbWIDTHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 15:07:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13721 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751529AbWIDTHs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 15:07:48 -0400
Date: Mon, 4 Sep 2006 12:04:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Greg Banks <gnb@melbourne.sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc5-mm1: ARCH_DISCONTIGMEM_ENABLE=y, SMP=n compile error
Message-Id: <20060904120430.a2ab9479.akpm@osdl.org>
In-Reply-To: <20060904170411.GT4416@stusta.de>
References: <20060901015818.42767813.akpm@osdl.org>
	<20060904170411.GT4416@stusta.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Sep 2006 19:04:11 +0200
Adrian Bunk <bunk@stusta.de> wrote:

> cpumask-add-highest_possible_node_id.patch causes the following compile 
> error with CONFIG_ARCH_DISCONTIGMEM_ENABLE=y, CONFIG_SMP=n
> (and CONFIG_SUNRPC=y):
> 
> <--  snip  -->
> 
> ...
>   LD      vmlinux
> net/built-in.o: In function `svc_create_pooled':
> (.text+0x675fc): undefined reference to `highest_possible_node_id'
> net/built-in.o: In function `svc_create_pooled':
> (.text+0x675fc): relocation truncated to fit: R_M32R_26_PCREL_RELA against undefined symbol `highest_possible_node_id'
> make[1]: *** [vmlinux] Error 1

On m32r?

If so, could it be a binutils or m32r bug?

