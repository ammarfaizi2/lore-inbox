Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263937AbTHWXBT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 19:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263950AbTHWXBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 19:01:19 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:43271 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263937AbTHWXBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 19:01:11 -0400
Subject: Re: [parisc-linux] Re: Problems with kernel mmap (failing
	tst-mmap-eofsync in glibc on parisc)
From: James Bottomley <James.Bottomley@steeleye.com>
To: "David S. Miller" <davem@redhat.com>
Cc: hugh@veritas.com, willy@debian.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       PARISC list <parisc-linux@lists.parisc-linux.org>, drepper@redhat.com
In-Reply-To: <20030823155127.3cd7b013.davem@redhat.com>
References: <20030822110144.5f7b83c5.davem@redhat.com>
	<Pine.LNX.4.44.0308221926060.2200-100000@localhost.localdomain>
	<20030822113106.0503a665.davem@redhat.com>
	<1061578568.2053.313.camel@mulgrave>
	<20030822121955.619a14eb.davem@redhat.com>
	<1061591255.1784.636.camel@mulgrave>
	<20030822154100.06314c8e.davem@redhat.com>
	<1061600974.2090.809.camel@mulgrave>
	<20030823144330.5ddab065.davem@redhat.com>
	<1061677283.1992.471.camel@mulgrave> 
	<20030823155127.3cd7b013.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 23 Aug 2003 18:01:00 -0500
Message-Id: <1061679662.1785.514.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-08-23 at 17:51, David S. Miller wrote:
> Ok.  Let me think about this a bit more.
> 
> The safest solution for parisc, meanwhile, would be to walk the
> non-shared mmap list checking for any instance of the VM_MAYSHARE bit
> being set.

Right, that's how I plan to fix this problem in parisc.

We also need the VM_MAYSHARE flag to propagate across remappings, which
was the general kernel fix I sent some emails back.

James


