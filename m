Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261893AbVACWEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbVACWEx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 17:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261904AbVACWEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 17:04:52 -0500
Received: from terminus.zytor.com ([209.128.68.124]:48541 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261893AbVACWDM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 17:03:12 -0500
Message-ID: <41D9C111.2090504@zytor.com>
Date: Mon, 03 Jan 2005 14:02:57 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nicholas Miell <nmiell@comcast.net>
CC: hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] get/set FAT filesystem attribute bits
References: <41D9B1C4.5050507@zytor.com>	 <1104787447.3604.9.camel@localhost.localdomain>	 <41D9BA8B.2000108@zytor.com> <1104788816.3604.17.camel@localhost.localdomain>
In-Reply-To: <1104788816.3604.17.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Miell wrote:
> 
> That's why I put fatattrs in the system namespace, which is wholly owned
> by the Linux kernel. Any theoretical FAT-with-xattrs variant would put
> those xattrs in the user namespace.
> 
> On another note, NTFS-style xattrs (aka named streams) are unrelated to
> Linux xattrs. A named stream is a separate file with a funny name, while
> a Linux xattr is a named extension to struct stat.
 >

OK, that does make it more sensible.  I do note, however, that ext2/ext3 
do not seem to export their attributes (chattr/lsattr) in this way; I do 
also note that the xattr code wherever it has been implemented is just 
painfully complex.

I'll see if I can weed it down to some kind of sane size.

	-hpa

