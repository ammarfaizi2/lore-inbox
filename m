Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262879AbUB0NxX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 08:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262867AbUB0NxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 08:53:23 -0500
Received: from pileup.ihatent.com ([217.13.24.22]:62994 "EHLO
	pileup.ihatent.com") by vger.kernel.org with ESMTP id S262879AbUB0NvR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 08:51:17 -0500
To: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Gentoo mm-sources-2.6.3 kenrel's problem
References: <20040227124205.84877.qmail@span.corp.yahoo.com>
	<yw1xishsy9e4.fsf@kth.se>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 27 Feb 2004 14:49:56 +0100
In-Reply-To: <yw1xishsy9e4.fsf@kth.se>
Message-ID: <87ptc04oor.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mru@kth.se (Måns Rullgård) writes:

> duoduo <kfduoduo@yahoo.com> writes:
> 
> >  when i issue sync command immediately after deleting
> > a large file or directory, the whole system will
> > freeze
> > with no reaction, only could do rebooting
> 
> What filesystem?  What type of disk?  Does the machine respond to
> network?  Is the error easily reproducible?  Try it at a text console
> and see if there's a panic message.
> 

I'm seeing this on a handfull of HP DL360G3's, all using the
cciss-driver for RAID; running 2.6.3-mm2 (with Andrews sync-fix
patch). Currently installed with gentoo "testing" (~x86 keyword), and
they will hang on occation when running mke2fs, and about half the
time when executing something like this:

umount /some/dir && mke2fs -j -L /some/dir /dev/cciss/c0d0p5 && mount /some/dir

All filesystems (12 of them) are formatted as ext3, I'm using udev,
not devfs FWIW. Let me know if I can be of more help.

The machines will be fully respons network-wise, it only seems that
disk I/O hangs at that point; it wont perform a new login or an
already open prompt won't do anything but hang at that point.

mvh,
A

-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
