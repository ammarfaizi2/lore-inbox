Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267645AbUIFImD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267645AbUIFImD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 04:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263778AbUIFImD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 04:42:03 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:9369 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S263736AbUIFIl4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 04:41:56 -0400
Date: Mon, 6 Sep 2004 10:41:55 +0200
From: Frank van Maarseveen <frankvm@xs4all.nl>
To: Tonnerre <tonnerre@thundrix.ch>
Cc: Frank van Maarseveen <frankvm@xs4all.nl>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Dave Kleikamp <shaggy@austin.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>, Christoph Hellwig <hch@lst.de>,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives (was: silent semantic changes with reiser4)
Message-ID: <20040906084155.GB31483@janus>
References: <20040902203854.GA4801@janus> <1094160994.31499.19.camel@shaggy.austin.ibm.com> <20040902214806.GA5272@janus> <20040902220027.GD23987@parcelfarce.linux.theplanet.co.uk> <20040902220242.GA5414@janus> <20040902220640.GE23987@parcelfarce.linux.theplanet.co.uk> <20040902221133.GB5414@janus> <20040902221722.GF23987@parcelfarce.linux.theplanet.co.uk> <20040902222650.GA5523@janus> <20040906080424.GC28697@thundrix.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040906080424.GC28697@thundrix.ch>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 06, 2004 at 10:04:24AM +0200, Tonnerre wrote:
> 
> Problem is:
> 
> There are  cool superblock magics  for reiserfs. And for  ext[23]. And
> even for good old Minix. Cool.
> 
> However,  there  are   also  ugly  file  systems,  such   as  fat  for
> example. Fat has been defined as  "something that can be read by a fat

This problem is not new. Kernel probes for filesystems in a particular
order for mounting the root fs. And mount understands the fstype=auto in
/etc/fstab. There is no perfect solution but it's sure possible to come
up with something acceptable and workable with not too much effort, for
a configuratble subset of file-systems. This is not that much different
from an automounter/usermount mounting a USB storage device or cdrom:
ext3, ext2, udf, iso9660, vfat, read-only or not, just to name a few
things. This should work anyway.

-- 
Frank
