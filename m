Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263388AbUBPW02 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 17:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265907AbUBPW02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 17:26:28 -0500
Received: from mail.shareable.org ([81.29.64.88]:30084 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263388AbUBPW0X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 17:26:23 -0500
Date: Mon, 16 Feb 2004 22:26:18 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Marc Lehmann <pcg@schmorp.de>, viro@parcelfarce.linux.theplanet.co.uk,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API (was: Re: JFS default behavior)
Message-ID: <20040216222618.GF18853@mail.shareable.org>
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca> <200402150006.23177.robin.rosenberg.lists@dewire.com> <20040214232935.GK8858@parcelfarce.linux.theplanet.co.uk> <200402150107.26277.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.58.0402141827200.14025@home.osdl.org> <20040216183616.GA16491@schmorp.de> <Pine.LNX.4.58.0402161040310.30742@home.osdl.org> <20040216200321.GB17015@schmorp.de> <Pine.LNX.4.58.0402161205120.30742@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402161205120.30742@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> It would also be very painful, since it would mean that when you mount an 
> old disk, you may be totally unable to read the files, because they have 
> filenames that such a kernel would never accept.

Alas, once userspace has migrated to doing everything in UTF-8, you
won't be able to read those files because userspace will barf on them.

Then you'll be glad to have a mount option which converts iso-8859-1
to UTF-* :)  (Even if the old disk as actually not iso-8859-1, at least
you'll be able to read it's mangled filenames, rather than userspace
tripping over them).

-- Jamie
