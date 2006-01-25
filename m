Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbWAYWGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbWAYWGK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 17:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbWAYWGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 17:06:09 -0500
Received: from [212.76.85.23] ([212.76.85.23]:60943 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S932179AbWAYWGE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 17:06:04 -0500
From: Al Boldi <a1426z@gawab.com>
To: Hans Reiser <reiser@namesys.com>
Subject: Re: random minor benchmark: Re: Copy 20 tarfiles: ext2 vs (reiser4, unixfile)
Date: Thu, 26 Jan 2006 01:04:47 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200601260104.47906.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:
> Notice how CPU speed (and number of cpus) completely determines
> compression performance.

Now, if you could make it dependent on cpu-idle it could be a win all.

Thanks!

--
Al

>
> cryptcompress refers to the reiser4 compression plugin, (unix file)
> refers to the reiser4 non-compressing plugin.
>
> Edward Shishkin wrote:
> > Here are the tests that vs asked for:
> > Creation (dd) of 20 tarfiles (the original 200M file is in ramfs)
> > Kernel: 2.6.15-mm4 + current git snapshot of reiser4
> >
> > ------------------------------------------
> >
> > Laputa workstation
> > Uni Intel Pentium 4 (2.26 GHz) 512M RAM
> >
> > ext2:
> > real 2m, 15s
> > sys 0m, 14s
> >
> > reiser4(unix file)
> > real 2m, 7s
> > sys  0m, 23s
> >
> > reiser4(cryptcompress, lzo1, 64K)
> > real 2m, 13s
> > sys 0m, 11s
> > ------------------------------------------
> >
> > Belka workstation
> > Dual Intel Xeon (2.4GHz) 1G RAM
> >
> > ext2:
> > real 2m, 16s
> > sys 0m, 10s
> >
> > reiser4(unix file)
> > real 2m, 14s
> > sys  0m, 17s
> >
> > reiser4(cryptcompress, lzo1, 64K)
> > real 1m, 35s
> > sys 0m, 14s

