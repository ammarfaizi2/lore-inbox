Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290120AbSCOL1x>; Fri, 15 Mar 2002 06:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290277AbSCOL1n>; Fri, 15 Mar 2002 06:27:43 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:10488 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S290120AbSCOL1i>;
	Fri, 15 Mar 2002 06:27:38 -0500
Date: Fri, 15 Mar 2002 06:27:35 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: Brian Gerst <bgerst@didntduck.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] struct super_block cleanup - msdos/vfat
In-Reply-To: <200203151040.g2FAeqq20797@Port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.GSO.4.21.0203150619390.2253-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 15 Mar 2002, Denis Vlasenko wrote:

> Does this mean umsdos can be layered atop of wider range of filesystems than 
> just msdos? That would be cool.

Yes, but what's cool about it?  If not for the fact that there are weird
setups that actually use umsdos (i.e. compatibility reasons), the best
way to deal with it would be rm -rf...  If underlying filesystem has
normal semantics - you don't need anything, if it doesn't...  I'd suggest
to use combination of tar(1) and ramfs.  At least that way you get full
Unix semantics - no mess with rename breaking links, etc.

> Also, would it be possible to mount both underlying msdos fs and umsdos fs 
> layered on top of it at the same time (on different mountpoints)?

No.  That stuff is ugly as it is and trying to make it deal with unexpected
changes of underlying fs... <shudder>

