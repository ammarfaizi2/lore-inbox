Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317176AbSFFVFk>; Thu, 6 Jun 2002 17:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317183AbSFFVFj>; Thu, 6 Jun 2002 17:05:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:65030 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317176AbSFFVFd>;
	Thu, 6 Jun 2002 17:05:33 -0400
Message-ID: <3CFFCE4B.F422EE7@zip.com.au>
Date: Thu, 06 Jun 2002 14:04:11 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@clusterfs.com>
CC: Robert Love <rml@tech9.net>, "David S. Miller" <davem@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] CONFIG_NR_CPUS
In-Reply-To: <20020606.031520.08940800.davem@redhat.com> <1023377213.13787.2.camel@sinai> <3CFFBCA9.843C40F0@zip.com.au> <20020606205508.GN27817@turbolinux.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> 
> On Jun 06, 2002  12:48 -0700, Andrew Morton wrote:
> > But the arch maintainers should test one case please - x86
> > was locking up at boot on quad CPU with NR_CPUS=2.  Others may do
> > the same.
> 
> Just a guess, but this could be because the two CPUs chosen for the
> boot sequence are not physically numbered 0 and 1, so they are
> overwriting the bounds of the per-CPU arrays.

Well the code was assuming that the number of physical
CPUs was always <= NR_CPUS unless max_cpus had been
specified.  I fixed that in the patch.

-
