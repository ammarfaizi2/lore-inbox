Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261186AbSJLNTU>; Sat, 12 Oct 2002 09:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261187AbSJLNTU>; Sat, 12 Oct 2002 09:19:20 -0400
Received: from services.cam.org ([198.73.180.252]:52437 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S261186AbSJLNTU>;
	Sat, 12 Oct 2002 09:19:20 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.42-mm2
Date: Sat, 12 Oct 2002 09:19:55 -0400
User-Agent: KMail/1.4.3
References: <3DA7C3A5.98FCC13E@digeo.com>
In-Reply-To: <3DA7C3A5.98FCC13E@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210120919.55414.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This builds fine but gets errors in depmod.

make -f arch/i386/lib/Makefile modules_install
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.42-mm2; fi
depmod: *** Unresolved symbols in /lib/modules/2.5.42-mm2/kernel/fs/ext3/ext3.o
depmod:         generic_file_aio_read
depmod:         generic_file_aio_write
depmod: *** Unresolved symbols in /lib/modules/2.5.42-mm2/kernel/fs/nfs/nfs.o
depmod:         generic_file_aio_read
depmod:         generic_file_aio_write
depmod: *** Unresolved symbols in /lib/modules/2.5.42-mm2/kernel/fs/nfsd/nfsd.o
depmod:         auth_domain_find
depmod:         cache_fresh
depmod:         unix_domain_find
depmod:         auth_domain_put
depmod:         cache_flush
depmod:         cache_unregister
depmod:         add_hex
depmod:         cache_check
depmod:         svcauth_unix_purge
depmod:         get_word
depmod:         cache_clean
depmod:         cache_register
depmod:         auth_unix_lookup
depmod:         auth_unix_add_addr
depmod:         cache_init
depmod:         auth_unix_forget_old
depmod:         add_word

Hope this helps,
Ed Tomlinson
