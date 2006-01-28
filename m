Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422767AbWA1Qyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422767AbWA1Qyb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 11:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422833AbWA1Qya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 11:54:30 -0500
Received: from [213.85.88.22] ([213.85.88.22]:18595 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1422767AbWA1Qy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 11:54:29 -0500
From: Alexander Zarochentsev <zam@namesys.com>
Organization: namesys
To: reiserfs-list@namesys.com
Subject: Re: random minor benchmark: Re: Copy 20 tarfiles: ext2 vs (reiser4, unixfile) vs (reiser4,cryptcompress)
Date: Sat, 28 Jan 2006 19:53:14 +0300
User-Agent: KMail/1.8.2
Cc: Jens Axboe <axboe@suse.de>, Edward Shishkin <edward@namesys.com>,
       Hans Reiser <reiser@namesys.com>, LKML <linux-kernel@vger.kernel.org>
References: <43D7C6BE.1010804@namesys.com> <43D91225.3030605@namesys.com> <20060126185612.GM4311@suse.de>
In-Reply-To: <20060126185612.GM4311@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601281953.14990.zam@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thursday 26 January 2006 21:56, Jens Axboe wrote:
> On Thu, Jan 26 2006, Edward Shishkin wrote:
> > Jens Axboe wrote:
> > >On Wed, Jan 25 2006, Hans Reiser wrote:
> > >>Notice how CPU speed (and number of cpus) completely determines
> > >>compression performance.
> > >>
> > >>cryptcompress refers to the reiser4 compression plugin, (unix file)
> > >>refers to the reiser4 non-compressing plugin.
> > >>
> > >>Edward Shishkin wrote:
> > >>>Here are the tests that vs asked for:
> > >>>Creation (dd) of 20 tarfiles (the original 200M file is in ramfs)
> > >>>Kernel: 2.6.15-mm4 + current git snapshot of reiser4
> > >>>
> > >>>------------------------------------------
> > >>>
> > >>>Laputa workstation
> > >>>Uni Intel Pentium 4 (2.26 GHz) 512M RAM
> > >>>
> > >>>ext2:
> > >>>real 2m, 15s
> > >>>sys 0m, 14s
> > >>>
> > >>>reiser4(unix file)
> > >>>real 2m, 7s
> > >>>sys  0m, 23s
> > >>>
> > >>>reiser4(cryptcompress, lzo1, 64K)
> > >>>real 2m, 13s
> > >>>sys 0m, 11s
> > >
> > >Just curious - does your crypt plugin reside in user space?
> >
> > Nop.
> > This is just wrappers for linux crypto api, zlib, etc..
> > so user time is zero and not interesting.
>
> Then why is the sys time lower than the "plain" writes on ext2 and
> reiser4? Surely compressing isn't for free, yet the sys time is lower on
> the compression write than the others.

I guess the compression was done by the background writeout daemon.  CPU 
utilization numbers would say more than sys time.

-- 
Alex.
