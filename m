Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264979AbSKALuD>; Fri, 1 Nov 2002 06:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264996AbSKALuD>; Fri, 1 Nov 2002 06:50:03 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:2061 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S264979AbSKALuC>; Fri, 1 Nov 2002 06:50:02 -0500
Date: Fri, 1 Nov 2002 12:56:20 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Joseph Fannin <jhf@rivenstone.net>
cc: tytso@mit.edu, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [BK] 0/11  Ext2/3 Updates: Extended attributes, ACL,
 etc.
In-Reply-To: <20021101010607.GC1683@rivenstone.net>
Message-ID: <Pine.LNX.4.44.0211011239290.6949-100000@serv>
References: <E187Agn-0003b9-00@snap.thunk.org> <20021101002419.GA1683@rivenstone.net>
 <20021101004751.GB1683@rivenstone.net> <20021101010607.GC1683@rivenstone.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 31 Oct 2002, Joseph Fannin wrote:

> > # Meta block cache for Extended Attributes (ext2/ext3)
> > config FS_MBCACHE
> >        tristate
> >        depends on EXT2_FS_XATTR || EXT3_FS_XATTR
> >        default m if EXT2_FS=m || EXT3_FS=m
> >        default y if EXT2_FS=y || EXT3_FS=y
> 
>     Okay, sorry for all the mails.
> 
>     "If multiple default statements are visible only the first is
> used."
> 
>     So the two default lines above need to be reversed.  This seems
> backwards to me (the last should be used), but I've said enough.

Well, I had to pick something and using the first is easier to implement, 
it's just different to cml1, which used the last definition.
BTW xconfig is a nice way to see how the config back end works, you can 
enable "Show All Options" and above entry will also be visible and you can 
watch how the value changes depending on the inputs.
BTW2 in the future above can be simplified into

config FS_MBCACHE
	tristate
	depends on EXT2_FS_XATTR || EXT3_FS_XATTR
	default EXT2_FS || EXT3_FS

bye, Roman

