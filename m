Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317950AbSGPTfp>; Tue, 16 Jul 2002 15:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317951AbSGPTfo>; Tue, 16 Jul 2002 15:35:44 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:17414 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S317950AbSGPTfm>; Tue, 16 Jul 2002 15:35:42 -0400
Date: Tue, 16 Jul 2002 21:38:36 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>,
       Stelian Pop <stelian.pop@fr.alcove.com>, Sam Vilain <sam@vilain.net>,
       dax@gurulabs.com
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
Message-ID: <20020716193831.GC22053@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Stelian Pop <stelian.pop@fr.alcove.com>, Sam Vilain <sam@vilain.net>,
	dax@gurulabs.com
References: <E17U1BD-0000m0-00@hofmann> <1026736251.13885.108.camel@irongate.swansea.linux.org.uk> <E17U4YE-0000TL-00@hofmann> <20020715160357.GD442@clusterfs.com> <E17U9x9-0001Dc-00@hofmann> <20020716081531.GD7955@tahoe.alcove-fr> <20020716122756.GD4576@merlin.emma.line.org> <20020716124331.GJ7955@tahoe.alcove-fr> <20020716125301.GI4576@merlin.emma.line.org> <20020716140549.A11780@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020716140549.A11780@infradead.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jul 2002, Christoph Hellwig wrote:

> On Tue, Jul 16, 2002 at 02:53:01PM +0200, Matthias Andree wrote:
> > Not if some day somebody implements file system level snapshots for
> > Linux. Until then, better have garbled file contents constrained to a
> > file than random data as on-disk layout changes with hefty directory
> > updates.
> 
> or the blockdevice-level snapshots already implemented in Linux..

That would require three atomic steps:

1. mount read-only, flushing all pending updates
2. take snapshot
3. mount read-write

and then backup the snapshot. A snapshots of a live file system won't
do, it can be as inconsistent as it desires -- if your corrupt target is
moving or not, dumping it is not of much use.

-- 
Matthias Andree
