Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317184AbSGCQtq>; Wed, 3 Jul 2002 12:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317192AbSGCQte>; Wed, 3 Jul 2002 12:49:34 -0400
Received: from mail.clsp.jhu.edu ([128.220.34.27]:52445 "EHLO
	mail.clsp.jhu.edu") by vger.kernel.org with ESMTP
	id <S317181AbSGCQrs>; Wed, 3 Jul 2002 12:47:48 -0400
Date: Wed, 3 Jul 2002 05:04:48 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Andrew Morton <akpm@zip.com.au>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Automatically mount or remount EXT3 partitions with EXT2 when alaptop is powered by a battery?
Message-ID: <20020703030447.GC474@elf.ucw.cz>
References: <1024948946.30229.19.camel@turbulence.megapathdsl.net> <3D18A273.284F8EDD@zip.com.au> <20020628215942.GA3679@pelks01.extern.uni-tuebingen.de> <20020702131314.B4711@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020702131314.B4711@redhat.com>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > If it's because of the disk-spins-up-too-much problem then
> > > that can be addressed by allowing the commit interval to be
> > > set to larger values.
> > 
> > The updated commit interval will only affect new transactions, correct?
> > In other words, when changing the commit interval from t_old to t_new,
> > it will take t_old seconds until we can be certain there are only
> > transactions with a t_new expiry interval in the queue?
> 
> Yes, unless:
> > Or is there a
> > way to flush the current queue of transactions, eg. by fsync()ing the
> > underlying block device, or by sending a magic signal to kjournald? 
> 
> an fsync() on any file or directory on the filesystem will ensure that
> all old transactions have completed, and a sync() will ensure that any
> old transactions are at least on their way to disk.

Ugh, does that mean that if I 

"sync ; poweroff"

my data are not safe?
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
