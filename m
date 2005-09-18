Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbVIRLXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbVIRLXb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 07:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbVIRLXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 07:23:31 -0400
Received: from ozlabs.org ([203.10.76.45]:20650 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751152AbVIRLXa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 07:23:30 -0400
Date: Sun, 18 Sep 2005 21:22:12 +1000
From: Anton Blanchard <anton@samba.org>
To: "Sexton, Matt" <sexton@mc.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: inconsistent mmap and get_user_pages with hugetlbfs on ppc64
Message-ID: <20050918112212.GD17639@krispykreme>
References: <92CB67C83EE773499A7F2F6EA7E3FC940F0E99@ad-email1.ad.mc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92CB67C83EE773499A7F2F6EA7E3FC940F0E99@ad-email1.ad.mc.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> On a ppc64 platform running 2.6.13-1, the virtual to physical mapping
> established by mmap'ing a hugetlbfs file does not seem to match the
> mapping described by get_user_pages().

I just tried a simple test - I created a program that allocated a
hugetlb page and wrote some stuff in it. I then attached with gdb and
dumped memory at that address and things came out OK.

That should have exercised the ptrace -> access_process_vm -> get_user_pages
path. So at least for this case get_user_pages seems to be working :)

It would be useful to simplify your problem a bit and take DMA out of
the picture. Moving this over to linuxppc64-dev@ozlabs.org would also
make sense.

Anton
