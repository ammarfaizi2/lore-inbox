Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262645AbTFKQUm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 12:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262656AbTFKQUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 12:20:42 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:59409 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262645AbTFKQUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 12:20:41 -0400
Date: Wed, 11 Jun 2003 09:31:32 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: viro@parcelfarce.linux.theplanet.co.uk, Frank Cusack <fcusack@fcusack.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfs_unlink() race (was: nfs_refresh_inode: inode number
 mismatch)
In-Reply-To: <1055348515.2420.12.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0306110929260.1653-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 11 Jun 2003, Alan Cox wrote:
> 
> fs/vfat - d_revalidate: vfat_revalidate

That still shouldn't cause ESTALE, it should just force a dropping of the 
dentry, and a re-lookup (and that, in turn, should either get the right 
thing, or should return ENOENT).

Or are you talking about 2.4.x and that is doing something strange these
days?

[ You have entered the twilight zone: "Tee-dee tee-dee.." ]

			Linus

