Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130073AbQKSUhJ>; Sun, 19 Nov 2000 15:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130038AbQKSUgt>; Sun, 19 Nov 2000 15:36:49 -0500
Received: from [194.213.32.137] ([194.213.32.137]:11781 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129413AbQKSUgF>;
	Sun, 19 Nov 2000 15:36:05 -0500
Date: Sat, 18 Nov 2000 16:40:22 +0000
From: Pavel Machek <pavel@suse.cz>
To: Daniel Phillips <phillips@innominate.de>
Cc: Michael Rothwell <rothwell@holly-springs.nc.us>,
        linux-kernel@vger.kernel.org
Subject: Re: Advanced Linux Kernel/Enterprise Linux Kernel
Message-ID: <20001118164021.A156@toy>
In-Reply-To: <200011141459.IAA413471@tomcat.admin.navo.hpc.mil> <3A117311.8DC02909@holly-springs.nc.us> <news2mail-3A15ACE3.5BED2CA3@innominate.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <news2mail-3A15ACE3.5BED2CA3@innominate.de>; from news-innominate.list.linux.kernel@innominate.de on Fri, Nov 17, 2000 at 11:10:43PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > book, Ext2 throws safety to the wind to achieve speed. This also ties
> > into Linux' convoluted VM system, and is shot in the foot by NFS. We
> > would need minimally a journaled filesystem and a clean VM design,
> > probably with a unified cache (no separate buffer, directory entry and
> > page caches). The Tux2 Phase Trees look to be a good step in the
> > direction as well, in terms of FS reliability. The filesystem would have
> > to do checksums on every block.
> 
> Actually, I was planning on doing on putting in a hack to do something
> like that: calculate a checksum after every buffer data update and check
> it after write completion, to make sure nothing scribbled in the buffer
> in the interim.  This would also pick up some bad memory problems.

You might want to take  look to a patch with crc loop option.

It does verify during read, not during write; but that's even better because
that way you pick up problems in IO subsystem, too.
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
