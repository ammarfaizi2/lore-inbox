Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317024AbSGNShY>; Sun, 14 Jul 2002 14:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317025AbSGNShX>; Sun, 14 Jul 2002 14:37:23 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:59665 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S317024AbSGNShW>; Sun, 14 Jul 2002 14:37:22 -0400
Date: Sun, 14 Jul 2002 20:40:06 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Joerg Schilling <schilling@fokus.gmd.de>
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Message-ID: <20020714184006.GA13867@louise.pinerecords.com>
References: <200207141811.g6EIBXKc019318@burner.fokus.gmd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207141811.g6EIBXKc019318@burner.fokus.gmd.de>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.19-pre10/sparc SMP
X-Uptime: 40 days, 10:24
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A Pentium 1200 running Linux-2.5.25 (ext3) results in:
> 
> # star -xp -time < rock.tar.bz2
> star: WARNING: Archive is bzip2 compressed, trying to use the -bz option.
> star: 10372 blocks + 1536 bytes (total of 106210816 bytes = 103721.50k).
> star: Total time 3190.483sec (32 kBytes/sec)
> 53:10.490r 12.299u 2970.099s 93% 0M 0+0k 0st 0+0io 4411pf+0w
> 
> You see, during the 53:20, the machine is only 7% idle!


A Pentium 1200, eh?
More like Pentium 120 or star just doesn't cut it.

--

Athlon 1GHz:

kala@nibbler:/tmp/1$ time tar xjf rock.tar.bz2
real    3m19.703s
user    0m9.870s
sys     0m24.840s

According to top, the system was ~90% idle during the extraction.
Linux 2.4.19-rc1-ac3, reiserfs 3.6.

T.

PS. Solaris is over 60% slower than Linux 2.2/2.4 in common fs
operations on my SMP SPARCstation 10.
