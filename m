Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261430AbVACVrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbVACVrD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 16:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbVACVrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 16:47:03 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:29879 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261430AbVACVq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 16:46:58 -0500
Subject: Re: [PATCH] get/set FAT filesystem attribute bits
From: Nicholas Miell <nmiell@comcast.net>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <41D9BA8B.2000108@zytor.com>
References: <41D9B1C4.5050507@zytor.com>
	 <1104787447.3604.9.camel@localhost.localdomain>
	 <41D9BA8B.2000108@zytor.com>
Content-Type: text/plain
Date: Mon, 03 Jan 2005 13:46:56 -0800
Message-Id: <1104788816.3604.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-03 at 13:35 -0800, H. Peter Anvin wrote:
> Nicholas Miell wrote:
> > Instead of adding another ioctl, wouldn't an xattr be more appropriate?
> > For instance, system.fatattrs containing a text representation of the
> > attribute bits.
> > 
> 
> This really worries me, because it's not clear to me that Microsoft 
> isn't going to add NTFS-style xattrs to FAT in the future.  There is a 
> very specific reason why they might want to do that: since they want to 
> keep NTFS secret and proprietary, FAT is the published interchange 
> format that other devices can use to exchange data with MS operating 
> systems.  If we then have overloaded the xattr mechanism, that would be 
> very ugly.
> 
> 	-hpa

That's why I put fatattrs in the system namespace, which is wholly owned
by the Linux kernel. Any theoretical FAT-with-xattrs variant would put
those xattrs in the user namespace.

On another note, NTFS-style xattrs (aka named streams) are unrelated to
Linux xattrs. A named stream is a separate file with a funny name, while
a Linux xattr is a named extension to struct stat.
-- 
Nicholas Miell <nmiell@comcast.net>

