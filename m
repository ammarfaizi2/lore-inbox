Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbVHRPXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbVHRPXM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 11:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbVHRPXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 11:23:11 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:58339 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932248AbVHRPXK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 11:23:10 -0400
Message-ID: <4304A7D6.3000307@sgi.com>
Date: Thu, 18 Aug 2005 10:23:02 -0500
From: Eric Sandeen <sandeen@sgi.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Macintosh/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: xfs-masters@oss.sgi.com
CC: Jesper Juhl <jesper.juhl@gmail.com>, nathans@sgi.com,
       linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [xfs-masters] Re: [PATCH] pull XFS support out of Kconfig submenu
References: <200508172245.49043.jesper.juhl@gmail.com> <20050818135356.GA16845@taniwha.stupidest.org>
In-Reply-To: <20050818135356.GA16845@taniwha.stupidest.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> On Wed, Aug 17, 2005 at 10:45:48PM +0200, Jesper Juhl wrote:
> 
> 
>>It seems slightly odd to me that XFS support should be in a separate
>>submenu, when all the other filesystems are not using submenus but
>>are directly selectable from the Filesystems menu.
> 
> 
> XFS also has an out-of-tree version.  Making it a submenu is probably
> to make maintenance easier (ie. replace files, not merge).
> 

Where the Kconfig is vs. where the menu appears are 2 different things 
though.  The latest kernel has our own Kconfig in fs/xfs, and fs/Kconfig 
just does:

source "fs/xfs/Kconfig"

This does facilitate swapping in a devel version of fs/xfs via a 
symlink, etc.

However, fs/xfs/Kconfig does still start with

menu "XFS support"

which puts it in a submenu, unlike every other fs.

I have no problem with removing the submenu.

-Eric
