Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266497AbUBLPzs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 10:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266498AbUBLPzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 10:55:48 -0500
Received: from [212.28.208.94] ([212.28.208.94]:34579 "HELO dewire.com")
	by vger.kernel.org with SMTP id S266497AbUBLPzr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 10:55:47 -0500
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Jamie Lokier <jamie@shareable.org>
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
Date: Thu, 12 Feb 2004 16:55:39 +0100
User-Agent: KMail/1.6.1
References: <20040209115852.GB877@schottelius.org> <20040212004532.GB29952@hexapodia.org> <20040212085451.GC20898@mail.shareable.org>
In-Reply-To: <20040212085451.GC20898@mail.shareable.org>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402121655.39709.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 February 2004 09.54, you wrote:
> Andy Isaacson wrote:
> > Why on earth is JFS worried about the filename, anyways?  Why has it
> > *ever* had *any* behavior other than "string of bytes, delimited with /,
> > terminated with \0" ?
> 
> Perhaps for the same reason that these other in-tree filesystems are
> sensitive to the character encoding:
> 
>    Joliet (ISO-9660 extension), FAT/VFAT, NTFS, BeFS, SMBFS, CIFS.
> 
> Those filesystems will also fail, or give unexpected behaviour (such
> as bytes being changed to '?'), if you pass them names which are not
> in the appropriate encoding.

Definitely a good reason.  It seem many assume file names are a local thing,
but this is not so. Now consider the case with an external firewire
disk or memory stick created on a machine with iso-8859-1 as the system character
set and e.g xfs as the file system. What happens when I hook it up to a new redhat
installation that thinks file names are best stored as utf8? Most non-ascii
file names aren't even legal in utf8.

-- robin

