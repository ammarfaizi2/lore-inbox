Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264144AbTFKFQm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 01:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264146AbTFKFQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 01:16:42 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:44041 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264144AbTFKFQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 01:16:41 -0400
Date: Tue, 10 Jun 2003 22:30:10 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Frank Cusack <fcusack@fcusack.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       <marcelo@conectiva.com.br>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfs_unlink() race (was: nfs_refresh_inode: inode number
 mismatch)
In-Reply-To: <20030611005425.GA6754@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.44.0306102226300.17133-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 11 Jun 2003 viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
> Two different dentries for the same file is obviously not a problem...

It _is_ a problem. It does the wrong thing on any subsequent directory
operation (move or unlink). 

Multiple aliased dentries have never been ok, unless the filesystem 
explicitly handles them and invalidates them (ie ntfs/fat kind of things).

		Linus

