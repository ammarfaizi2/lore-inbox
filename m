Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbUAHHvH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 02:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263537AbUAHHvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 02:51:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:36227 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262687AbUAHHvF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 02:51:05 -0500
Date: Wed, 7 Jan 2004 23:51:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: [2.4 patch] disallow modular BINFMT_ELF
Message-Id: <20040107235109.52abe4a2.akpm@osdl.org>
In-Reply-To: <20040107194759.GC11523@fs.tum.de>
References: <20040107194759.GC11523@fs.tum.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@fs.tum.de> wrote:
>
> with no 2.4 kernel BINFMT_ELF=m actually worked, you always get a
> 
>  <--  snip  -->
> 
>  depmod: *** Unresolved symbols in /lib/modules/2.4.25-pre4/kernel/fs/binfmt_elf.o
>  depmod:         smp_num_siblings
>  depmod:         put_files_struct
>  depmod:         steal_locks

In 2.6 we gave up and made CONFIG_BINFMT_ELF a def_bool.  So people who
want it get it statically linked.  People who are making tiny a.out systems
set it to 'n'.
