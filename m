Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267760AbTBJLv6>; Mon, 10 Feb 2003 06:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267717AbTBJLv6>; Mon, 10 Feb 2003 06:51:58 -0500
Received: from node181b.a2000.nl ([62.108.24.27]:33182 "EHLO ddx.a2000.nu")
	by vger.kernel.org with ESMTP id <S267444AbTBJLvy>;
	Mon, 10 Feb 2003 06:51:54 -0500
Date: Mon, 10 Feb 2003 13:01:35 +0100 (CET)
From: Stephan van Hienen <raid@a2000.nu>
To: Andreas Dilger <adilger@clusterfs.com>
cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, "Theodore Ts'o" <tytso@mit.edu>,
       peter@chubb.wattle.id.au, tbm@a2000.nu
Subject: Re: fsck out of memory
In-Reply-To: <20030209133117.E12639@schatzie.adilger.int>
Message-ID: <Pine.LNX.4.53.0302101228430.7274@ddx.a2000.nu>
References: <Pine.LNX.4.53.0302071555110.718@ddx.a2000.nu>
 <Pine.LNX.4.53.0302071800200.1306@ddx.a2000.nu> <20030207102858.P18636@schatzie.adilger.int>
 <Pine.LNX.4.53.0302090953440.1039@ddx.a2000.nu> <20030209133117.E12639@schatzie.adilger.int>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Feb 2003, Andreas Dilger wrote:

> > mke2fs -j -m 0  -b 4096 -i 4096 -R stride=16
>
> Do you expect to have so many small files in this huge filesystem?
> Basically, the "-i" parameter is telling mke2fs what you think the
> average file size will be, so 4kB is very small.
not really, i thought the -b was telling this ?
i think average filesize should be somewhere from 1-5 megabyte
(zipfiles few megabyte/videofiles (can be a few gigabyte)/installation
files for programmes)

i also wonder what kind of chunk-size i need to use
i use 64k now, but i wonder if 256k (or something bigger?) would be better
(does chunk size difference in performance between a 4disk raid5 and a 15disk raid5 ?)
