Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130485AbREIUCm>; Wed, 9 May 2001 16:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130507AbREIUCc>; Wed, 9 May 2001 16:02:32 -0400
Received: from ghostwheel.underley.eu.org ([217.97.235.9]:51980 "EHLO
	bobas.nowytarg.top.pl") by vger.kernel.org with ESMTP
	id <S130485AbREIUCU>; Wed, 9 May 2001 16:02:20 -0400
From: Daniel Podlejski <underley@witch.underley.eu.org>
To: linux-kernel@vger.kernel.org
Subject: Re: reiserfs, xfs, ext2, ext3
In-Reply-To: <01050910381407.26653@bugs>
In-Reply-To: <01050910381407.26653@bugs>
X-PGP-Fingerprint: 4D 72 53 F8 FE 8C 53 B9  66 AD F6 EA C9 17 CD 82
X-Homepage: http://www.underley.eu.org/
Message-Id: <20010509195357Z5310367-757+3@witch.underley.eu.org>
Date: Wed, 9 May 2001 21:53:50 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In linux-kernel, martin@bugs.unl.edu.ar wrote:
:  We are waiting for a server with dual PIII, RAID 1,0 and 5 18Gb scsi disks to 
:  come so we can change our proxy server, that will run on Linux with Squid. 
:  One disk will go inside (I think?) and the other 4 on a tower conected to the 
:  RAID, which will be have the cache of the squid server.

Reiser is not good idea for squid cache. Why ? Squids cache is hashed
by default to minimize "big directory effect". Reiserfs is fast on
realy big directories, but it eat more cpu than ext2. On high loaded
cache servers cpu utilization on reiser can be realy big.
Better way is make more subdirectories in squid cache, and use
filesystem, that eat less of cpu.

-- 
Daniel Podlejski <underley@underley.eu.org>
   ... I am immortal, I have inside me blood of kings,
   I have no rival, No man can bemy equal ...
