Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262633AbTFKQKv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 12:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262645AbTFKQKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 12:10:51 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:12716
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262633AbTFKQKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 12:10:50 -0400
Subject: Re: [PATCH] nfs_unlink() race (was: nfs_refresh_inode: inode
	number mismatch)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk, Frank Cusack <fcusack@fcusack.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0306110905420.1653-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0306110905420.1653-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055348515.2420.12.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 Jun 2003 17:21:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-06-11 at 17:11, Linus Torvalds wrote:
> On 11 Jun 2003, Alan Cox wrote:
> > 
> > No no - this happens on LOCAL disk. No NFS needed at all.
> 
> How do you make a local filesystem return ESTALE? A quick grep shows it in
> fs/fat/inode.c, but it should only be in the "export" functions used to
> export it for NFS.
> 
> Curious. What am I missing?

fs/vfat - d_revalidate: vfat_revalidate

