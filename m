Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262584AbTFKPkF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 11:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262589AbTFKPkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 11:40:05 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:4268
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262584AbTFKPkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 11:40:00 -0400
Subject: Re: [PATCH] nfs_unlink() race (was: nfs_refresh_inode: inode
	number mismatch)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk, Frank Cusack <fcusack@fcusack.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0306110804360.4413-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0306110804360.4413-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055346664.2420.5.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 Jun 2003 16:51:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-06-11 at 16:08, Linus Torvalds wrote:
> > cd foo
> > mv ../file .
> > more file
> > 
> > ESTALE.
> 
> Yes, VFAT ends up encoding the parent directory in the FH, so renaming 
> will invalidate the old file handle, and if you cache inodes (and thus 
> filehandles) over a directory move, badness happens.
> 
> Arguably it's a NFS client problem

No no - this happens on LOCAL disk. No NFS needed at all.

