Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751044AbWFFQJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbWFFQJe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 12:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbWFFQJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 12:09:34 -0400
Received: from moci.net4u.de ([217.7.64.195]:36821 "EHLO moci.net4u.de")
	by vger.kernel.org with ESMTP id S1751038AbWFFQJd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 12:09:33 -0400
From: Ernst Herzberg <list-lkml@net4u.de>
Reply-To: earny@net4u.de
Organization: Net4U
To: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.6.17-rc6 -- alpha-generic-hweight-build-fix.patch missing
Date: Tue, 6 Jun 2006 18:09:25 +0200
User-Agent: KMail/1.9.1
Cc: Linus Torvalds <torvalds@osdl.org>
References: <Pine.LNX.4.64.0606051807310.5498@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606051807310.5498@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606061809.25944.list-lkml@net4u.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Moin.

Without alpha-generic-hweight-build-fix.patch 2.6.17-rc6 does not compile 
on ALPHA DP264

  LD      init/built-in.o
  LD      .tmp_vmlinux1
lib/lib.a(bitmap.o): In function `__bitmap_weight':
: undefined reference to `hweight64'
lib/lib.a(bitmap.o): In function `__bitmap_weight':
: undefined reference to `hweight64'
lib/lib.a(bitmap.o): In function `__bitmap_weight':
: undefined reference to `hweight64'
lib/lib.a(bitmap.o): In function `__bitmap_weight':
: undefined reference to `hweight64'
drivers/built-in.o: In function `pcips2_interrupt':
: undefined reference to `hweight8'
drivers/built-in.o: In function `pcips2_interrupt':
: undefined reference to `hweight8'
net/built-in.o: In function `netlink_bind':
: undefined reference to `hweight32'
net/built-in.o: In function `netlink_bind':
: undefined reference to `hweight32'
net/built-in.o: In function `netlink_bind':
: undefined reference to `hweight32'
net/built-in.o: In function `netlink_bind':
: undefined reference to `hweight32'
make: *** [.tmp_vmlinux1] Error 1

The good news: With this patch -rc6 boots and works.

Thanks

Earny
