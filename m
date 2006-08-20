Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751094AbWHTR4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbWHTR4l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 13:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbWHTR4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 13:56:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30177 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751094AbWHTR4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 13:56:40 -0400
Date: Sun, 20 Aug 2006 10:56:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Maciej Rutecki <maciej.rutecki@gmail.com>
Cc: linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: 2.6.18-rc4-mm2
Message-Id: <20060820105625.adf5ebe0.akpm@osdl.org>
In-Reply-To: <44E86282.9020406@gmail.com>
References: <20060819220008.843d2f64.akpm@osdl.org>
	<44E86282.9020406@gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Aug 2006 15:24:18 +0200
Maciej Rutecki <maciej.rutecki@gmail.com> wrote:

> Andrew Morton napisał(a):
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm2/
> 
> Error while compile ("make all" command):
> 
> CC [M]  fs/afs/file.o
> fs/afs/file.c: In function 'afs_file_releasepage':
> fs/afs/file.c:332: error: 'struct afs_vnode' has no member named 'cache'
> make[2]: *** [fs/afs/file.o] Błąd 1
> make[1]: *** [fs/afs] Błąd 2
> make: *** [fs] Błąd 2
> 

It needs to use CONFIG_AFS_FSCACHE in some manner, or we turn
fscache_uncache_page() into a macro.
