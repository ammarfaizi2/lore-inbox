Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280975AbRKGUyu>; Wed, 7 Nov 2001 15:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280978AbRKGUya>; Wed, 7 Nov 2001 15:54:30 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:30112 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S280975AbRKGUy1>; Wed, 7 Nov 2001 15:54:27 -0500
Date: Wed, 7 Nov 2001 20:56:10 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: John Johnson <jjohn@mail.sirinet.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: compiling loop device
In-Reply-To: <Pine.LNX.4.33.0111071432220.29536-100000@mail.sirinet.net>
Message-ID: <Pine.LNX.4.21.0111072044001.4556-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Nov 2001, John Johnson wrote:
> 
> all efforts to build 2.4.14 fail because of loop device
> 
> Slackware 8.0
> gcc version 2.95.3 20010315
> 
> eg. ...
> 
>         /usr/src/linux-2.4.14/arch/i386/lib/lib.a
> /usr/src/linux-2.4.14/lib/lib.a /usr/src/linux-2.4.14/arch/i386/lib/lib.a
> \
>         --end-group \
>         -o vmlinux
> drivers/block/block.o: In function `lo_send':
> drivers/block/block.o(.text+0xa86f): undefined reference to
> `deactivate_page'
> drivers/block/block.o(.text+0xa8b9): undefined reference to
> `deactivate_page'
> make: *** [vmlinux] Error 1

Enough! Please!

Linus, as many a craftsman of old, has taken to putting a tiny
blemish into each of his final releases: partly as a signature
to distinguish them from Alan's, yes, but more importantly to
avoid attracting the wrath of jealous gods by the perfection
of his releases.  But it is unseemly that _we_ should keep on
drawing attention to this blemish.

In silence, delete the two calls to deactivate_page from your loop.c.

Hugh

