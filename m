Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266703AbUBMDXN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 22:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266706AbUBMDXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 22:23:13 -0500
Received: from mail.shareable.org ([81.29.64.88]:27266 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S266703AbUBMDXK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 22:23:10 -0500
Date: Fri, 13 Feb 2004 03:23:05 +0000
From: Jamie Lokier <jamie@shareable.org>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
Message-ID: <20040213032305.GH25499@mail.shareable.org>
References: <20040209115852.GB877@schottelius.org> <200402121655.39709.robin.rosenberg.lists@dewire.com> <20040213003839.GB24981@mail.shareable.org> <200402130216.53434.robin.rosenberg.lists@dewire.com> <20040213022934.GA8858@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040213022934.GA8858@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Fri, Feb 13, 2004 at 02:16:53AM +0100, Robin Rosenberg wrote:
> > Yes, so ext3&co. should be equipped with charset options just the other so
> > it can be fixed by the user or in some cases the mount tools. 
> > 
> > Is there a place to store character set information in these file systems?
> 
> Bullshit.  Just as there is no timezone common for all users, there is no
> charset common for all of them.  Charset of _machine_ doesn't make any sense
> at all - toy operating systems nonwithstanding.

Charset of a filename does make sense, though.  That's not per user,
it's per filename.

A name which one user entered as "£10.txt" should ideally display as
that sequence of characters to all users who want to display the name.

I already have this problem on my filesystems: some programs show the
names assuming UTF-8, other programs show them assuming
iso-8859-1.

But it's worse than that.  On my filesystem, names are stored in UTF-8
as is recommended these days.  "ls" on some terminals shows the names
as I wrote them.  But on other terminals it shows the wrong names.

If I create a file using a shell command, what I get depends on which
terminal I used to create it.  If I am using a terminal which displays
UTF-8 but ssh to another machine, the other machine assumes the
terminal is displaying iso-8859-1 even though the other machine's
default locale is UTF-8.  And so on.

-- Jamie

