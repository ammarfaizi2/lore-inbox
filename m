Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263145AbTCWTCg>; Sun, 23 Mar 2003 14:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263146AbTCWTCg>; Sun, 23 Mar 2003 14:02:36 -0500
Received: from dp.samba.org ([66.70.73.150]:10175 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S263145AbTCWTCf>;
	Sun, 23 Mar 2003 14:02:35 -0500
Date: Mon, 24 Mar 2003 06:12:36 +1100
From: Anton Blanchard <anton@samba.org>
To: Brian Gerst <bgerst@quark.didntduck.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] slab.c cleanup
Message-ID: <20030323191236.GA27242@krispykreme>
References: <3E7E03C9.6060804@quark.didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E7E03C9.6060804@quark.didntduck.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> - Don't create caches that are not multiples of L1_CACHE_BYTES.

Nice idea, I often see the list walk (of the cache sizes) in kmalloc in kernel
profiles. eg a bunch of kmalloc(2k) for network drivers.

Since we have a 128byte cacheline on ppc64 this patch should reduce that.

Anton
