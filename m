Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267351AbTALRkm>; Sun, 12 Jan 2003 12:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267357AbTALRkj>; Sun, 12 Jan 2003 12:40:39 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:4616 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267351AbTALRkh>; Sun, 12 Jan 2003 12:40:37 -0500
Message-ID: <3E21A1F3.8E65FC93@linux-m68k.org>
Date: Sun, 12 Jan 2003 18:12:19 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Robert P. J. Day" <rpjday@mindspring.com>
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: more thoughts on kernel config organization
References: <Pine.LNX.4.44.0301112300570.20815-100000@dell>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

"Robert P. J. Day" wrote:

>   also, there are at least a couple places in that xconfig
> meny that seem incorrectly-structured.  example: ext3 -> JBD.
> JBD is a sub-option of ext3, but it shows up at the same
> indentation level.  it should, based on hierarchy, be one
> level indented, at the same level as ext3 extended attributes
> to be a proper sub-option.
> 
>   same complaint about VFAT being a sub-option of DOS FAT fs
> support, but not being indented properly.

You always have to remember that the dependency information is used to
generate the menu structure. If you enable "Show All Options" in
xconfig, you can easily find out what's preventing a correct menu
structure. E.g. for VFAT you have two possibilities, move down the
UMSDOS_FS entry or add "depends on FAT_FS" to it.
If you want one config entry to appear as a child of another entry, it
must have at least that other entry in its dependency list.

bye, Roman


