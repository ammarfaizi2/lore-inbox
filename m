Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262578AbTFKP5g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 11:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262589AbTFKP5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 11:57:36 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16655 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262578AbTFKP5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 11:57:35 -0400
Date: Wed, 11 Jun 2003 09:11:01 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: viro@parcelfarce.linux.theplanet.co.uk, Frank Cusack <fcusack@fcusack.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfs_unlink() race (was: nfs_refresh_inode: inode number
 mismatch)
In-Reply-To: <1055346664.2420.5.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0306110905420.1653-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 11 Jun 2003, Alan Cox wrote:
> 
> No no - this happens on LOCAL disk. No NFS needed at all.

How do you make a local filesystem return ESTALE? A quick grep shows it in
fs/fat/inode.c, but it should only be in the "export" functions used to
export it for NFS.

Curious. What am I missing?

		Linus

