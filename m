Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbWC3RkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbWC3RkN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 12:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWC3RkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 12:40:12 -0500
Received: from mail.clusterfs.com ([206.168.112.78]:36019 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1751345AbWC3RkK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 12:40:10 -0500
Date: Thu, 30 Mar 2006 10:40:08 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Mingming Cao <cmm@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Takashi Sato <sho@tnes.nec.co.jp>,
       Laurent Vivier <Laurent.Vivier@bull.net>, linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH 0/2]Extend ext3 filesystem limit from 8TB to 16TB
Message-ID: <20060330174008.GW5030@schatzie.adilger.int>
Mail-Followup-To: Mingming Cao <cmm@us.ibm.com>,
	Andrew Morton <akpm@osdl.org>, Takashi Sato <sho@tnes.nec.co.jp>,
	Laurent Vivier <Laurent.Vivier@bull.net>,
	linux-kernel@vger.kernel.org,
	ext2-devel <ext2-devel@lists.sourceforge.net>,
	linux-fsdevel@vger.kernel.org
References: <20060325223358sho@rifu.tnes.nec.co.jp> <1143485147.3970.23.camel@dyn9047017067.beaverton.ibm.com> <20060327131049.2c6a5413.akpm@osdl.org> <20060327225847.GC3756@localhost.localdomain> <1143530126.11560.6.camel@openx2.frec.bull.fr> <1143568905.3935.13.camel@dyn9047017067.beaverton.ibm.com> <1143623605.5046.11.camel@openx2.frec.bull.fr> <1143682730.4045.145.camel@dyn9047017067.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143682730.4045.145.camel@dyn9047017067.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 29, 2006  17:38 -0800, Mingming Cao wrote:
> Have verified these two patches on a 64 bit machine with 10TB ext3
> filesystem, fsx runs fine for a few hours. Also testes on 32 bit machine
> with <8TB ext3.

Have you done tests _near_ 8TB with a 32-bit machine, even without these
patches?  In particular, filling up the filesystem to be close to full
so that we really depend on the > 2TB code to work properly?  Also, in
theory with these patches even a 32-bit machine could run > 8TB, right?

There have been sporadic reports of failure for large ext3 filesystems,
and some of them say that 32-bit systems fail and 64-bit systems work.
There is a kernel bugzilla bug open for this, but it was never really
identified what the source of the problem was.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

