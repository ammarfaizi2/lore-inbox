Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289484AbSCOKoK>; Fri, 15 Mar 2002 05:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289298AbSCOKoB>; Fri, 15 Mar 2002 05:44:01 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:52490 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S289484AbSCOKnm>; Fri, 15 Mar 2002 05:43:42 -0500
Message-Id: <200203151040.g2FAeqq20797@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Alexander Viro <viro@math.psu.edu>, Brian Gerst <bgerst@didntduck.org>
Subject: Re: [PATCH] struct super_block cleanup - msdos/vfat
Date: Fri, 15 Mar 2002 12:40:24 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0203131932440.25130-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0203131932440.25130-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 March 2002 22:35, Alexander Viro wrote:
> On Wed, 13 Mar 2002, Brian Gerst wrote:
> > Seperates msdos_sb_info from struct super_block for msdos and vfat.
> > Umsdos is terminally broken and is not included.
>
> We have everything needed to fix^Wrewrite umsdos and I hope to do that
> this week.  Main idea of the rewrite: turn it into proper layered
> filesystem (i.e. let the underlying layer have its own superblock,
> inodes, etc.)...

Does this mean umsdos can be layered atop of wider range of filesystems than 
just msdos? That would be cool.

Also, would it be possible to mount both underlying msdos fs and umsdos fs 
layered on top of it at the same time (on different mountpoints)?
--
vda
