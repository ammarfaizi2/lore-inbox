Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262656AbTFKQVH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 12:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262657AbTFKQVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 12:21:07 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49127 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262656AbTFKQVA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 12:21:00 -0400
Date: Wed, 11 Jun 2003 17:34:42 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Frank Cusack <fcusack@fcusack.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfs_unlink() race (was: nfs_refresh_inode: inode number mismatch)
Message-ID: <20030611163442.GF6754@parcelfarce.linux.theplanet.co.uk>
References: <1055348515.2420.12.camel@dhcp22.swansea.linux.org.uk> <Pine.LNX.4.44.0306110929260.1653-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306110929260.1653-100000@home.transmeta.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 11, 2003 at 09:31:32AM -0700, Linus Torvalds wrote:
> 
> On 11 Jun 2003, Alan Cox wrote:
> > 
> > fs/vfat - d_revalidate: vfat_revalidate
> 
> That still shouldn't cause ESTALE, it should just force a dropping of the 
> dentry, and a re-lookup (and that, in turn, should either get the right 
> thing, or should return ENOENT).

.... and vfat lookup will pick what can be picked.  We do not get hashed
aliases there.
