Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262680AbSJBXMH>; Wed, 2 Oct 2002 19:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262681AbSJBXMH>; Wed, 2 Oct 2002 19:12:07 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:60400 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S262680AbSJBXMG>; Wed, 2 Oct 2002 19:12:06 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Wed, 2 Oct 2002 17:14:56 -0600
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Lars Marowsky-Bree <lmb@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove LVM from 2.5 (resend)
Message-ID: <20021002231456.GA3000@clusterfs.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Lars Marowsky-Bree <lmb@suse.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.43.0210011650490.12465-100000@cibs9.sns.it> <20021001154808.GD126@suse.de> <20021001184225.GC29788@marowsky-bree.de> <1033520458.20284.46.camel@irongate.swansea.linux.org.uk> <20021002042434.GA13971@think.thunk.org> <1033565669.23682.10.camel@irongate.swansea.linux.org.uk> <20021002145434.GA1202@marowsky-bree.de> <1033578571.23758.32.camel@irongate.swansea.linux.org.uk> <20021002222958.GN1202@marowsky-bree.de> <1033598760.25240.19.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1033598760.25240.19.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 02, 2002  23:46 +0100, Alan Cox wrote:
> Absolutely - taking the core EVMS(say the core code and the bits to do
> LVM1) and polishing them up to be good clean citizens without code
> duplication and other weirdness would be a superb start for EVMS as a
> merge candidate. The rest can follow a piece at a time once the core is
> right if EVMS is the right path

I actually see EVMS as the "VFS for disk devices".  It is a very good
way to at allow dynamic disk device allocation, and could relatively
easily be modified to use all of the "legacy" disk major devices and
export only real partitions (one per minor).

You could have thousands of disks and partitions without the current
limitations on major/minor device mapping.

This was one of the things that Linus was pushing for when 2.5 started.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

