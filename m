Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317169AbSFFU45>; Thu, 6 Jun 2002 16:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317154AbSFFU44>; Thu, 6 Jun 2002 16:56:56 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:64238 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S317169AbSFFU4z>; Thu, 6 Jun 2002 16:56:55 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Thu, 6 Jun 2002 14:55:08 -0600
To: Andrew Morton <akpm@zip.com.au>
Cc: Robert Love <rml@tech9.net>, "David S. Miller" <davem@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] CONFIG_NR_CPUS
Message-ID: <20020606205508.GN27817@turbolinux.com>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	Robert Love <rml@tech9.net>, "David S. Miller" <davem@redhat.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020606.031520.08940800.davem@redhat.com> <1023377213.13787.2.camel@sinai> <3CFFBCA9.843C40F0@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 06, 2002  12:48 -0700, Andrew Morton wrote:
> But the arch maintainers should test one case please - x86
> was locking up at boot on quad CPU with NR_CPUS=2.  Others may do
> the same.

Just a guess, but this could be because the two CPUs chosen for the
boot sequence are not physically numbered 0 and 1, so they are
overwriting the bounds of the per-CPU arrays.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

