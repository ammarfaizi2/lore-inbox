Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261306AbSJ1Pdy>; Mon, 28 Oct 2002 10:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261307AbSJ1Pdy>; Mon, 28 Oct 2002 10:33:54 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:32482 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S261306AbSJ1Pdx>; Mon, 28 Oct 2002 10:33:53 -0500
Date: Mon, 28 Oct 2002 16:40:33 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Andi Kleen <ak@suse.de>, eggert@twinsun.com, linux-kernel@vger.kernel.org
Subject: Re: nanosecond file timestamp resolution in filesystems, GNU make, etc.
In-Reply-To: <20021028151309.GB16546@bjl1.asuk.net>
Message-ID: <Pine.GSO.3.96.1021028161702.977I-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Oct 2002, Jamie Lokier wrote:

> >  Well, possibly more stuff could benefit from new stat syscalls, like a
> > st_gen member for inode generations.  And as someone suggested, a version
> > number or a length could be specified by the calls this time to permit
> > less disturbing expansion in the future. 
> 
> It's already there.  The kernel stat64() syscall has a flags argument,
> which is unused at the moment.  I presume it's for this purpose.

 Hmm, I haven't thought of this argument to be used this way.  Actually it
isn't currently initialized by glibc in any way, which makes its utility
questionable.

> Glibc aleady uses a version number for its stat() calls, to permit
> binary compatible extensions on the user side.

 Well, it used to use xstat() functions that provided versioning since the
old days and now ELF symbol versioning is used, too, so the userland is
long prepared.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

