Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263759AbTHWHUo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 03:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263765AbTHWHUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 03:20:44 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:10329 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id S263759AbTHWHUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 03:20:42 -0400
Date: Sat, 23 Aug 2003 08:22:19 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: "David S. Miller" <davem@redhat.com>, <willy@debian.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       PARISC list <parisc-linux@lists.parisc-linux.org>, <drepper@redhat.com>
Subject: Re: [parisc-linux] Re: Problems with kernel mmap (failing tst-mmap-eofsync
 in glibc on parisc)
In-Reply-To: <1061600974.2090.809.camel@mulgrave>
Message-ID: <Pine.LNX.4.44.0308230820020.3590-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Aug 2003, James Bottomley wrote:
> 
> I suppose if we had a way of telling if any of the i_mmap list members
> were really MAP_SHARED semantics mappings, then we could alter our
> flush_dcache_page() implementation to work.

Good idea.  It's VM_MAYSHARE you need to check for.

Hugh

