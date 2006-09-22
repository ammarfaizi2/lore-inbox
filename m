Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWIVKdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWIVKdV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 06:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWIVKdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 06:33:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28140 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750751AbWIVKdU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 06:33:20 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0609171022160.27242@sheep.housecafe.de> 
References: <Pine.LNX.4.64.0609171022160.27242@sheep.housecafe.de>  <20060912000618.a2e2afc0.akpm@osdl.org> 
To: Christian Kujau <evil@g-house.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc6-mm2: __fscache_register_netfs compile error 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Fri, 22 Sep 2006 11:33:08 +0100
Message-ID: <13395.1158921188@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Kujau <evil@g-house.de> wrote:

> I could not find this anywhere reported, so here it goes:
> 
> when is enabled, gcc-4.0.3 (ubuntu/dapper, x86_64) gives:
> 
> fs/built-in.o: In function `init_nfs_fs':inode.c:(.init.text+0x16a9): undefined reference to `__fscache_register_netfs'
> :inode.c:(.init.text+0x1757): undefined reference to `__fscache_unregister_netfs'

It looks like your build failed to build the fscache facility or built it as a
module but build NFS directly into the kernel.  What's your full configuration?

David
