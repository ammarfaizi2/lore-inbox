Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262721AbSJPS3r>; Wed, 16 Oct 2002 14:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262735AbSJPS3r>; Wed, 16 Oct 2002 14:29:47 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:48372 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S262721AbSJPS32>; Wed, 16 Oct 2002 14:29:28 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Wed, 16 Oct 2002 12:32:55 -0600
To: Lorenzo Allegrucci <l.allegrucci@tiscalinet.it>
Cc: "Theodore Ts'o" <tytso@mit.edu>,
       "Henning P. Schmiedehausen" <hps@intermeta.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] Add extended attributes to ext2/3
Message-ID: <20021016183255.GB1201@clusterfs.com>
Mail-Followup-To: Lorenzo Allegrucci <l.allegrucci@tiscalinet.it>,
	Theodore Ts'o <tytso@mit.edu>,
	"Henning P. Schmiedehausen" <hps@intermeta.de>,
	linux-kernel@vger.kernel.org
References: <E181a3S-0006Nq-00@snap.thunk.org> <aojc1q$l37$1@forge.intermeta.de> <20021016161620.GC8210@think.thunk.org> <200210161950.54993.l.allegrucci@tiscalinet.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210161950.54993.l.allegrucci@tiscalinet.it>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 16, 2002  19:50 +0200, Lorenzo Allegrucci wrote:
> On Wednesday 16 October 2002 18:16, Theodore Ts'o wrote:
> > We already have different block sizes for ext2/3; we support 1k, 2k,
> > and 4k block sizes.
> 
> BTW, why doesn't ext2/3 support 512 byte block sizes?

Too inefficient, and impose too many limitations on the filesystem
(which sets up some filesystem structures based on the blocksize).
Already, 1kB block size is too small for many things, and 4kB is
preferred.  It would probably support larger blocksizes already on
ia32 if the page size was larger.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

