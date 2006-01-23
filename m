Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964774AbWAWUgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbWAWUgG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 15:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbWAWUgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 15:36:05 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:49285 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S932383AbWAWUgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 15:36:04 -0500
Date: Mon, 23 Jan 2006 21:36:02 +0100
From: Folkert van Heusden <folkert@vanheusden.com>
To: "Theodore Ts'o" <tytso@mit.edu>, John Stoffel <john@stoffel.org>,
       Takashi Sato <sho@tnes.nec.co.jp>, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] Re: [PATCH] ext3: Extends blocksize up to pagesize
Message-ID: <20060123203602.GE10077@vanheusden.com>
References: <000001c61c30$00814e80$4168010a@bsd.tnes.nec.co.jp>
	<17358.25398.943860.755559@smtp.charter.net>
	<20060122182801.GA7082@thunk.org>
	<20060123054327.GN4124@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060123054327.GN4124@schatzie.adilger.int>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Tue Jan 24 20:23:13 CET 2006
X-Message-Flag: www.unixexpert.nl
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think the work done by the U. Wisconsin group for IRON ext3 is the
> way to go (namely checksumming of filesystem metadata, and possibly
> some level of redundancy).  This gives us concrete checks on what metadata
> is valid and the filesystem can avoid any (or further) corruption when
> the hardware goes bad.  The existing ext3 code already has these checks,
> but as filesystems get larger the validity of a block number of an inode
> is harder to check because any value may be correct.  Given that CPU
> speed is growing orders of magnitude faster than disk IO the overhead of
> checksumming is a reasonable thing to do these days (optionally, of course).

Then please make it optionally per mount-point.
E.g.: I don't care if the filesystem of the filestore of my Squid setup
goes bad (mke2fs will fix it just nicely) but I would get upset if its
OS filesystem would get corrupted.


Folkert van Heusden

-- 
Ever wonder what is out there? Any alien races? Then please support
the seti@home project: setiathome.ssl.berkeley.edu
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
