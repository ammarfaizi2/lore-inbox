Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269184AbUIYCPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269184AbUIYCPa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 22:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269186AbUIYCP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 22:15:29 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:58336 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S269184AbUIYCPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 22:15:17 -0400
Date: Sat, 25 Sep 2004 04:15:01 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Valdis.Kletnieks@vt.edu
Cc: David Lang <david.lang@digitalinsight.com>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wright <chrisw@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: mlock(1)
Message-ID: <20040925021501.GF3309@dualathlon.random>
References: <41547C16.4070301@pobox.com> <20040924132247.W1973@build.pdx.osdl.net> <1096060045.10800.4.camel@localhost.localdomain> <20040924225900.GY3309@dualathlon.random> <1096069581.3591.23.camel@desktop.cunninghams> <20040925010759.GA3309@dualathlon.random> <Pine.LNX.4.60.0409241819580.1341@dlang.diginsite.com> <20040925013013.GD3309@dualathlon.random> <200409250147.i8P1kxtm016914@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409250147.i8P1kxtm016914@turing-police.cc.vt.edu>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 09:46:59PM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Sat, 25 Sep 2004 03:30:13 +0200, Andrea Arcangeli said:
> > On Fri, Sep 24, 2004 at 06:21:27PM -0700, David Lang wrote:
> > > if you don't do a -c mkswap runs fast enough that it shouldn't be a 
> > > problem to do it every boot.
> > 
> > yep, speed isn't my worry, my worry is a misconfigured /etc/fstab wiping
> > out a filesystem...
> 
> If the mkswap doesn't nuke the filesystem, the first time we actually
> send a page to swap will do the job.  Plus, there's more chance of paging

how can a page be sent to swap if sys_swapon refuses to run? The whole
point of avoiding running mkswap is to forbid sys_swapon to run.

> Maybe have mkswap check the partition table and not do it if the partition
> isn't id=82 (Linux swap) unless -f is specified?  Not sure what to do if
> the space is a loop or LVM device though.....

or also if you mkswap on the whole device without partitions.

doing crypto-swap with cryptoapi inside the swap layer (without using
cryptoloop and dm-crypt) with a transparently randomly choosen password
and the metadata written in cleartext sounds just a lot cleaner and
safer.
