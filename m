Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264803AbUDWNfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264803AbUDWNfU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 09:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264806AbUDWNfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 09:35:20 -0400
Received: from kempelen.iit.bme.hu ([152.66.241.120]:26039 "EHLO
	kempelen.iit.bme.hu") by vger.kernel.org with ESMTP id S264803AbUDWNfQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 09:35:16 -0400
Date: Fri, 23 Apr 2004 15:35:07 +0200 (MET DST)
Message-Id: <200404231335.i3NDZ7q03932@kempelen.iit.bme.hu>
From: Miklos Szeredi <mszeredi@inf.bme.hu>
To: Christoph Hellwig <hch@infradead.org>
CC: Andrew Morton <akpm@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org
In-reply-to: <20040423131003.A1218@infradead.org> (message from Christoph
	     Hellwig on Fri, 23 Apr 2004 13:10:03 +0100)
Subject: Re: [PATCH] fmount system call
References: <200404221054.i3MAsOJ06500@kempelen.iit.bme.hu> <20040422124503.A20320@infradead.org> <200404221159.i3MBxRj25484@kempelen.iit.bme.hu> <20040423131003.A1218@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  - untangle the flags mess.  --bind or --move are really different operations
>    than the normal mount.  separate vfs flags from filesystem flags.

So you'd like to see 2 syscalls:

  fmount(dev, dst, type, flags, data)
  ftransmount(src, dst, flags)  (bind + move)

About the flag splitting: you mean per-mountpoint and per-superblock
flags?  Does the user care?  The user may not even know which flag is
which.  E.g. currently MS_NOATIME and MS_RDONLY are superblock flags,
but in the future they may become mountpoint flags.

Thanks for your comments!

Miklos
