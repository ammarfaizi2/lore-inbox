Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266640AbUBMBQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 20:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266646AbUBMBQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 20:16:58 -0500
Received: from [212.28.208.94] ([212.28.208.94]:12294 "HELO dewire.com")
	by vger.kernel.org with SMTP id S266640AbUBMBQ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 20:16:56 -0500
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Jamie Lokier <jamie@shareable.org>
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
Date: Fri, 13 Feb 2004 02:16:53 +0100
User-Agent: KMail/1.6.1
Cc: Linux kernel <linux-kernel@vger.kernel.org>
References: <20040209115852.GB877@schottelius.org> <200402121655.39709.robin.rosenberg.lists@dewire.com> <20040213003839.GB24981@mail.shareable.org>
In-Reply-To: <20040213003839.GB24981@mail.shareable.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402130216.53434.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 February 2004 01.38, Jamie Lokier wrote:
> Robin Rosenberg wrote:
>  Now consider the case with an external firewire
> > disk or memory stick created on a machine with iso-8859-1 as the system character
> > set and e.g xfs as the file system. What happens when I hook it up to a new redhat
> > installation that thinks file names are best stored as utf8? Most non-ascii
> > file names aren't even legal in utf8.
> 
> It goes wrong.  This happens both with filesystems that know nothing
> about encodings, e.g. ext3, and filesystems that need to be told what
> to transcode to/from utf-8, e.g. ntfs.

Yes, so ext3&co. should be equipped with charset options just the other so
it can be fixed by the user or in some cases the mount tools. 

Is there a place to store character set information in these file systems?

> It is also a problem that some applications access the filesystem
> assuming utf-8 and some don't.  Nothing in the filesystem can make the
> different applications cooperate regarding these.  E.g. I have
> filenames that look fine in "ls" containg things like c-cedilla, but
> xmms displays them wrongly.

Some apps simply don't think non-ascii is relevant. Xmms is one, although
is doesn't crash at least. My guess was that it was a font problem since it
looks like XMMS uses some special fonts. Even new apps (like gedit have 
character set problems. These apps have to be fixed since they don't work
properly anywhere outside the US. But that is a pure userspace problem, not 
a kernel one. 

-- robin
