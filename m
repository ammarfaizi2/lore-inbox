Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263162AbUDZSTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263162AbUDZSTk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 14:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263164AbUDZSTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 14:19:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:10937 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263162AbUDZSTh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 14:19:37 -0400
Date: Mon, 26 Apr 2004 11:08:40 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Grzegorz Kulewski <kangur@polcom.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, raven@themaw.net
Subject: Re: 2.6.6-rc2-bk3 (and earlier?) mount problem (?)
In-Reply-To: <Pine.LNX.4.58.0404261917120.24825@alpha.polcom.net>
Message-ID: <Pine.LNX.4.58.0404261102280.19703@ppc970.osdl.org>
References: <20040426013944.49a105a8.akpm@osdl.org>
 <Pine.LNX.4.58.0404270105200.2304@donald.themaw.net>
 <Pine.LNX.4.58.0404261917120.24825@alpha.polcom.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 26 Apr 2004, Grzegorz Kulewski wrote:
> 
> I was experiencing strange problem with mm tree since at least 2.6.4-mm?. 
> My Gentoo startup scripts can mount root filesystem and all virtual 
> filesystems (procfs, sysfs, tmpfs, usbfs, devpts) but nothing more. Mount 
> fails for all other disk filesystems (ext3, vfat, ntfs) with EBUSY (or 
> -EBUSY if you like).

Sounds like something is keeping the block device busy with an exclusive 
open. But it would be easier to guess if you can specify a but more 
closely on exactly when this changed:

>				But it seems that changes in mm that 
> broke things for me were incorporated in mainline 2.6 somewhere between 
> 2.6.5 and 2.6.6, because I recently tried 2.6.6-rc2-bk3 and got the same 
> error.

So 2.6.5 works, and 2.6.6-rc2-bk3 does not?

Can you check rc1/rc2 and then pinpoint it to a particular day?

		Linus
