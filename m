Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268851AbUIBSGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268851AbUIBSGn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 14:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268321AbUIBSFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 14:05:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:14255 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268227AbUIBSEq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 14:04:46 -0400
Date: Thu, 2 Sep 2004 11:03:52 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Christoph Hellwig <hch@lst.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>,
       viro@parcelfarce.linux.theplanet.co.uk, linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives (was: silent
 semantic changes with reiser4)
In-Reply-To: <20040902175034.GA18861@lst.de>
Message-ID: <Pine.LNX.4.58.0409021059230.2295@ppc970.osdl.org>
References: <20040826150202.GE5733@mail.shareable.org>
 <200408282314.i7SNErYv003270@localhost.localdomain> <20040901200806.GC31934@mail.shareable.org>
 <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org>
 <1094118362.4847.23.camel@localhost.localdomain> <Pine.LNX.4.58.0409021045210.2295@ppc970.osdl.org>
 <20040902175034.GA18861@lst.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 2 Sep 2004, Christoph Hellwig wrote:
> 
> http://oss.oracle.com/projects/userfs/ has code that clues gnomevfs onto
> a kernel filesystem.  The code is horrible, but it shows that it can
> be done.

I do like the setup where the extended features are done as a "view" on 
top of some other filesystem, so that you can choose to _either_ access 
the raw (and supposedly stable, simply by virtue of simplicity) or the 
"fancy" interface. Without having to reformat the disk to a filesystem you 
don't trust, or you have other reasons you can't use (disk sharing with 
other systems, whatever).

It doesn't have to be "user", btw, in the sense that a lot of the normal 
code could be in kernel mode. Same way as Tux handling all the regular 
static requests entirely in kernel mode, but having the ability for 
calling down to apache..

		Linus
