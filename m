Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269333AbUIBXsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269333AbUIBXsJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 19:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269322AbUIBXoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 19:44:39 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:52448 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S269321AbUIBXlj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 19:41:39 -0400
Date: Fri, 3 Sep 2004 01:41:35 +0200
From: Frank van Maarseveen <frankvm@xs4all.nl>
To: Valdis.Kletnieks@vt.edu
Cc: Frank van Maarseveen <frankvm@xs4all.nl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives (was: silent semantic changes with reiser4)
Message-ID: <20040902234135.GA6021@janus>
References: <20040826150202.GE5733@mail.shareable.org> <200408282314.i7SNErYv003270@localhost.localdomain> <20040901200806.GC31934@mail.shareable.org> <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org> <1094118362.4847.23.camel@localhost.localdomain> <20040902203854.GA4801@janus> <200409022319.i82NJlTN025039@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409022319.i82NJlTN025039@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2004 at 07:19:47PM -0400, Valdis.Kletnieks@vt.edu wrote:
> 
> > 	cd FC2-i386-disc1.iso
> > 	ls
> 
> That one's at least theoretically doable, assuming that it really *IS* the
> Fedora Core disk and an ISO9660 format...

Impressive.

But when it comes to file-systems like ext[23] I think an in-kernel
solution might be preferable to get the exact semantics wrt locking,
atomicity, synchronization, coherency, whatever a kernel is good at
for filesystems.

> > 	cd /dev/cdrom
> > 	ls
> 
> And the CD in the drive at the moment is AC/DC "Back in Black".  What
> should this produce as output?

bash: cd: /dev/cdrom: Not a directory

When it doesn't match a (sub)set of known file system types I think.
Because that is the area the kernel has knowledge about. Nothing
else, no tarballs for example unless of course the kernel has "tarfs" :-)

-- 
Frank
