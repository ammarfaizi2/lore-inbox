Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261912AbVACWZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261912AbVACWZc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 17:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbVACWXB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 17:23:01 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:16266 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261907AbVACWP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 17:15:56 -0500
Subject: Re: [PATCH] get/set FAT filesystem attribute bits
From: Nicholas Miell <nmiell@comcast.net>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <41D9C111.2090504@zytor.com>
References: <41D9B1C4.5050507@zytor.com>
	 <1104787447.3604.9.camel@localhost.localdomain>
	 <41D9BA8B.2000108@zytor.com>
	 <1104788816.3604.17.camel@localhost.localdomain>
	 <41D9C111.2090504@zytor.com>
Content-Type: text/plain
Date: Mon, 03 Jan 2005 14:10:43 -0800
Message-Id: <1104790243.3604.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-03 at 14:02 -0800, H. Peter Anvin wrote:
> Nicholas Miell wrote:
> > 
> > That's why I put fatattrs in the system namespace, which is wholly owned
> > by the Linux kernel. Any theoretical FAT-with-xattrs variant would put
> > those xattrs in the user namespace.
> > 
> > On another note, NTFS-style xattrs (aka named streams) are unrelated to
> > Linux xattrs. A named stream is a separate file with a funny name, while
> > a Linux xattr is a named extension to struct stat.
>  >
> 
> OK, that does make it more sensible.  I do note, however, that ext2/ext3 
> do not seem to export their attributes (chattr/lsattr) in this way; I do 
> also note that the xattr code wherever it has been implemented is just 
> painfully complex.
> 
> I'll see if I can weed it down to some kind of sane size.
> 
> 	-hpa

Yeah, I contemplated adding system.fattattrs, system.ntfsattrs, and
system.linuxattrs (for the ext2 attrs that have popped up in several
other filesystems) a while ago, but xattrs seem to be the red-headed
left-handed stepchild of the Linux VFS and I lost interest in the
project.

Nice to see someone else interested in it, though.
-- 
Nicholas Miell <nmiell@comcast.net>

