Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269297AbUJKWei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269297AbUJKWei (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 18:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269301AbUJKWei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 18:34:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:55972 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269297AbUJKWef (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 18:34:35 -0400
Date: Mon, 11 Oct 2004 15:38:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: pbadari@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4-mm1 OOPs on AMD64
Message-Id: <20041011153830.495b7c2d.akpm@osdl.org>
In-Reply-To: <20041011221519.GA11702@wotan.suse.de>
References: <1097527401.12861.383.camel@dyn318077bld.beaverton.ibm.com>
	<20041011214304.GD31731@wotan.suse.de>
	<1097532118.12861.395.camel@dyn318077bld.beaverton.ibm.com>
	<20041011221519.GA11702@wotan.suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> > Console: colour VGA+ 80x25
> > Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
> > Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
> > Bad page state at free_hot_cold_page (in process 'swapper', page
> > 000001017ac06070)
> > flags:0x00000000 mapping:0000000000000000 mapcount:1 count:0
> 
> Some memory corruption or confused memory allocator.

I'd be suspecting no-buddy-bitmap-patch-*.patch
