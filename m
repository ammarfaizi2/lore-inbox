Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266622AbUBMAim (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 19:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266637AbUBMAim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 19:38:42 -0500
Received: from mail.shareable.org ([81.29.64.88]:9602 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S266622AbUBMAil (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 19:38:41 -0500
Date: Fri, 13 Feb 2004 00:38:39 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
Message-ID: <20040213003839.GB24981@mail.shareable.org>
References: <20040209115852.GB877@schottelius.org> <20040212004532.GB29952@hexapodia.org> <20040212085451.GC20898@mail.shareable.org> <200402121655.39709.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402121655.39709.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin Rosenberg wrote:
 Now consider the case with an external firewire
> disk or memory stick created on a machine with iso-8859-1 as the system character
> set and e.g xfs as the file system. What happens when I hook it up to a new redhat
> installation that thinks file names are best stored as utf8? Most non-ascii
> file names aren't even legal in utf8.

It goes wrong.  This happens both with filesystems that know nothing
about encodings, e.g. ext3, and filesystems that need to be told what
to transcode to/from utf-8, e.g. ntfs.

It is also a problem that some applications access the filesystem
assuming utf-8 and some don't.  Nothing in the filesystem can make the
different applications cooperate regarding these.  E.g. I have
filenames that look fine in "ls" containg things like c-cedilla, but
xmms displays them wrongly.

-- Jamie
