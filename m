Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932412AbWIQJaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbWIQJaB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 05:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWIQJaB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 05:30:01 -0400
Received: from ns2.g-housing.de ([81.169.133.75]:63452 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S932412AbWIQJaA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 05:30:00 -0400
Date: Sun, 17 Sep 2006 10:29:57 +0100 (BST)
From: Christian Kujau <evil@g-house.de>
X-X-Sender: evil@sheep.housecafe.de
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: 2.6.18-rc6-mm2: __fscache_register_netfs compile error
In-Reply-To: <20060912000618.a2e2afc0.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0609171022160.27242@sheep.housecafe.de>
References: <20060912000618.a2e2afc0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I could not find this anywhere reported, so here it goes:

when is enabled, gcc-4.0.3 (ubuntu/dapper, x86_64) gives:

fs/built-in.o: In function `init_nfs_fs':inode.c:(.init.text+0x16a9): undefined reference to `__fscache_register_netfs'
:inode.c:(.init.text+0x1757): undefined reference to `__fscache_unregister_netfs'

see the full error here:
http://nerdbynature.de/bits/2.6.18-rc6-mm2/make.log

I suspect a missing "#include <linux/fscache.h>" but could not find out 
where yet :(

Thanks,
Christian.
-- 
BOFH excuse #96:

Vendor no longer supports the product
