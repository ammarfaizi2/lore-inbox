Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbTFKRLK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 13:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262562AbTFKRLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 13:11:10 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:50092
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262424AbTFKRLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 13:11:09 -0400
Subject: Re: [PATCH] nfs_unlink() race (was: nfs_refresh_inode: inode
	number mismatch)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk, Frank Cusack <fcusack@fcusack.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0306110929260.1653-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0306110929260.1653-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055352127.2419.25.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 Jun 2003 18:22:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-06-11 at 17:31, Linus Torvalds wrote:
> On 11 Jun 2003, Alan Cox wrote:
> > 
> > fs/vfat - d_revalidate: vfat_revalidate
> 
> That still shouldn't cause ESTALE, it should just force a dropping of the 
> dentry, and a re-lookup (and that, in turn, should either get the right 
> thing, or should return ENOENT).
> 
> Or are you talking about 2.4.x and that is doing something strange these
> days?
> 
> [ You have entered the twilight zone: "Tee-dee tee-dee.." ]

I've seen it on early 2.5 and on 2.4, current 2.5.x seems to be ok from 
a quick test.


