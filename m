Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315748AbSGFS0v>; Sat, 6 Jul 2002 14:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315754AbSGFS0u>; Sat, 6 Jul 2002 14:26:50 -0400
Received: from mail.clsp.jhu.edu ([128.220.34.27]:35557 "EHLO
	mail.clsp.jhu.edu") by vger.kernel.org with ESMTP
	id <S315748AbSGFSZm>; Sat, 6 Jul 2002 14:25:42 -0400
Date: Sat, 6 Jul 2002 02:58:35 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Stephen Tweedie <sct@redhat.com>
Cc: Andrew Morton <akpm@zip.com.au>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Automatically mount or remount EXT3 partitions with EXT2 when alaptop is powered by a battery?
Message-ID: <20020706005834.GA112@elf.ucw.cz>
References: <1024948946.30229.19.camel@turbulence.megapathdsl.net> <3D18A273.284F8EDD@zip.com.au> <20020628215942.GA3679@pelks01.extern.uni-tuebingen.de> <20020702131314.B4711@redhat.com> <20020704220511.GA4728@pelks01.extern.uni-tuebingen.de> <20020705085917.F27198@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020705085917.F27198@redhat.com>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > an fsync() on any file or directory on the filesystem will ensure that
> > > all old transactions have completed, and a sync() will ensure that any
> > > old transactions are at least on their way to disk.
> > 
> > With emphasis on 'on the filesystem', I suppose?  In other words, if we
> > have an ext3 fs on /dev/hda1 mounted on /mnt, it is not sufficient to
> > fsync("/dev/hda1") to flush the transactions, but fsync("/mnt") will do?
> > (Excuse the sloppy notation.)
> 
> Right.

So... If I do fsync("/"), will it flush everything? Probably not.

Is there some easy way to sync everything to disk and wait for
completion? [On suspend-to-something I'd llike to do that for
additional safety.
									Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
