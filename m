Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265844AbUBPTOZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 14:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265841AbUBPTOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 14:14:24 -0500
Received: from mail.uni-kl.de ([131.246.137.52]:13002 "EHLO uni-kl.de")
	by vger.kernel.org with ESMTP id S265848AbUBPTNp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 14:13:45 -0500
Date: Mon, 16 Feb 2004 20:13:14 +0100
From: Eduard Bloch <edi@gmx.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: Valdis.Kletnieks@vt.edu, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
Message-ID: <20040216191314.GB15087@zombie.inka.de>
References: <200402121655.39709.robin.rosenberg.lists@dewire.com> <20040213003839.GB24981@mail.shareable.org> <200402130216.53434.robin.rosenberg.lists@dewire.com> <20040213022934.GA8858@parcelfarce.linux.theplanet.co.uk> <20040213032305.GH25499@mail.shareable.org> <20040214150934.GA5023@zombie.inka.de> <20040215010150.GA3611@mail.shareable.org> <20040216140338.GA2927@zombie.inka.de> <200402161518.i1GFIpn2008826@turing-police.cc.vt.edu> <20040216153224.GE16658@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040216153224.GE16658@mail.shareable.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#include <hallo.h>
* Jamie Lokier [Mon, Feb 16 2004, 03:32:24PM]:

> > That looks like a security hole just waiting to happen.  Probably
> > has lots of lurking corner cases too - what if you creat() a file,
> > then do a readdir() and strcmp() each entry looking for your file
> > (while comparing a filename smashed to UTF-8 to the original
> > unsmashed string)?
> 
> Actually, following Eduard's proposal, that would work fine.  The file
> name would be passed to libc in the current encoding, created in
> UTF-8, libc's readdir() would convert it back (which is always
> possible without mangling), and strcmp() would be fine.
> 
> The real problem comes when you readdir() a directory which contains
> non-UTF-8 names.  Even if you changes your local filesystem, when you
> go travelling an remotely-mounted filesystem elsewhere may have them.
> What does Eduard's libc do then?  Ignore the names?  Mangle them?

Just pass the uncoverted strings then. Please note that this is exactly
what happens today - every application running in UTF-8 locale and
facing incompatible filenames has to deal with this problem. I wonder
why so many people pretend that the current situation is "less or more
okay".

> Not to mention the extremely unpleasant performance implications.

You always loose a bit performance when dealing with Unicode. Just
accept it.

Regards,
Eduard.
-- 
Lang ist der Weg durch Lehren, kurz und wirksam durch Beispiele.
		-- Lucius Annaeus Seneca (4-65 n.Chr.)
