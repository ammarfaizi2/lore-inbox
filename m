Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbVACXW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbVACXW7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 18:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbVACXWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 18:22:37 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:7909 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261946AbVACXWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 18:22:15 -0500
Subject: Re: [PATCH] get/set FAT filesystem attribute bits
From: Nicholas Miell <nmiell@comcast.net>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <41D9C64E.7080508@zytor.com>
References: <41D9B1C4.5050507@zytor.com>
	 <1104787447.3604.9.camel@localhost.localdomain>
	 <41D9BA8B.2000108@zytor.com>
	 <1104788816.3604.17.camel@localhost.localdomain>
	 <41D9C111.2090504@zytor.com>
	 <1104790243.3604.23.camel@localhost.localdomain>
	 <41D9C64E.7080508@zytor.com>
Content-Type: text/plain
Date: Mon, 03 Jan 2005 15:16:59 -0800
Message-Id: <1104794219.3604.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-03 at 14:25 -0800, H. Peter Anvin wrote:
> I'm honestly not sure that using an ASCII string in an xattr is the sane 
> way of doing this.  Even a binary byte in an xattr would make more sense 
> in some ways.

ASCII strings require no special tools to manipulate from shell scripts.

> I think the xattr mechanism is ignored largely because it's painfully 
> complex.
> 
> A plus with using xattr is that in theory (but of course not in 
> practice!) it would let one store a copy of a DOS filesystem on an ext3 
> (or xfs, or...) filesystem and have it restored, all using standard (but 
> by necessity, xattr-aware) tools.  However, the splitting of xattr into 
> namespaces may very well make that impossible, since what's a "system" 
> attribute to one filesystem is a "user" attribute to another.  Classic 
> design flaw, by the way.

The design does allow users to store whatever they want as an xattr
without having to worry about how the kernel chooses to interpret it,
though. (i.e. the user namespace is just a byte array that the kernel
stores for you, while the system/security namespaces are probably
generated and interpreted on demand.)

> Anyway, I'm going to send out something to the various maintainers of 
> DOS-based filesystems (FAT, CIFS, NTFS) and see what they think.
> 
> 	-hpa
-- 
Nicholas Miell <nmiell@comcast.net>

