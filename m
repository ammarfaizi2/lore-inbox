Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbTH2SDv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 14:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbTH2SDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 14:03:50 -0400
Received: from tmi.comex.ru ([217.10.33.92]:12695 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S261853AbTH2SDs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 14:03:48 -0400
X-Comment-To: Ed Sweetman
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [RFC] extents support for EXT3
From: Alex Tomas <bzzz@tmi.comex.ru>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Organization: HOME
References: <m33cfm19ar.fsf@bzzz.home.net> <3F4E4605.6040706@wmich.edu>
	<m3vfshrola.fsf@bzzz.home.net> <3F4F7129.1050506@wmich.edu>
	<m3vfsgpj8b.fsf@bzzz.home.net> <3F4F76A5.6020000@wmich.edu>
	<m3r834phqi.fsf@bzzz.home.net> <3F4F7D56.9040107@wmich.edu>
	<m3isogpgna.fsf@bzzz.home.net> <3F4F923F.9070207@wmich.edu>
Date: Fri, 29 Aug 2003 22:09:13 +0400
Message-ID: <m3ad9snxo6.fsf@bzzz.home.net>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Ed Sweetman (ES) writes:

 ES> Throughput 221.812 MB/sec 16 procs    ext2
 ES> Throughput 159.495 MB/sec 16 procs    ext3-extents (definitely enabled)
 ES> Throughput 147.598 MB/sec 16 procs    ext3 (patched but disabled)

 ES> There is an obvious improvement, but nothing near the 70+% increase
 ES> you saw.  Subsequent runs run anything from a little lower than above
 ES> for extents to 167MB/s.

it seems one of my scsi drive is a bit broken (caching, at least).
sorry for invalid numbers. on another drive I see following:

w/o extents:
[root@zefir root]# /root/db2.sh 2 16
Throughput 119.199 MB/sec 16 procs
Throughput 106.09 MB/sec 16 procs
Average: 112.64450


with extents:
[root@zefir root]# /root/db2.sh 2 16
Throughput 156.846 MB/sec 16 procs
Throughput 170.591 MB/sec 16 procs
Average: 163.71850

so, this time improvement is about 45%

I can't explain this yet. need to be investigated carefully

 ES> By the way, what's the behavior of opening an existing non-extent file
 ES> and writing and reading to it while the partition is mounted with
 ES> extents enabled?

those files are handled usual way

