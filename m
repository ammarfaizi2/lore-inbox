Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269314AbUJKWWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269314AbUJKWWs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 18:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269312AbUJKWUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 18:20:39 -0400
Received: from cantor.suse.de ([195.135.220.2]:52387 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269292AbUJKWTg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 18:19:36 -0400
Date: Tue, 12 Oct 2004 00:15:19 +0200
From: Andi Kleen <ak@suse.de>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-rc4-mm1 OOPs on AMD64
Message-ID: <20041011221519.GA11702@wotan.suse.de>
References: <1097527401.12861.383.camel@dyn318077bld.beaverton.ibm.com> <20041011214304.GD31731@wotan.suse.de> <1097532118.12861.395.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097532118.12861.395.camel@dyn318077bld.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Console: colour VGA+ 80x25
> Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
> Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
> Bad page state at free_hot_cold_page (in process 'swapper', page
> 000001017ac06070)
> flags:0x00000000 mapping:0000000000000000 mapcount:1 count:0

Some memory corruption or confused memory allocator.

No idea. I doubt it is caused by an x86-64 patch though.

When -mm3 didn't have the problem I would start a binary search
and try to find out which change caused it.

-Andi
