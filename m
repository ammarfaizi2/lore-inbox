Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264434AbTFKMWl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 08:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264436AbTFKMWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 08:22:40 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:33962
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264434AbTFKMWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 08:22:38 -0400
Subject: Re: [PATCH] nfs_unlink() race (was: nfs_refresh_inode: inode
	number mismatch)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk, Frank Cusack <fcusack@fcusack.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0306102226300.17133-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0306102226300.17133-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055334814.2084.12.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 Jun 2003 13:33:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-06-11 at 06:30, Linus Torvalds wrote:
> Multiple aliased dentries have never been ok, unless the filesystem 
> explicitly handles them and invalidates them (ie ntfs/fat kind of things).

For vfat at least its all broken. 

cd foo
mv ../file .
more file

ESTALE.


