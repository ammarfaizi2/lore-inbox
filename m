Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129679AbRCCTSS>; Sat, 3 Mar 2001 14:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129686AbRCCTSI>; Sat, 3 Mar 2001 14:18:08 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:9941 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129679AbRCCTRu>;
	Sat, 3 Mar 2001 14:17:50 -0500
Date: Sat, 3 Mar 2001 14:17:48 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
cc: Denis Perchine <dyp@perchine.com>, linux-kernel@vger.kernel.org
Subject: Re: Q: How to get physical memory size from user space without proc
 fs
In-Reply-To: <200103031945.f23JjSQ22763@513.holly-springs.nc.us>
Message-ID: <Pine.GSO.4.21.0103031413550.19484-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 3 Mar 2001, Michael Rothwell wrote:

> pyhsmem = `free | grep Mem | tr -s "/ / /" | cut -f2 -d" "`

% strace free 2>&1 |grep /proc
open("/proc/cpuinfo", O_RDONLY)         = 3
open("/proc/uptime", O_RDONLY)          = 3
open("/proc/stat", O_RDONLY)            = 4
open("/proc/meminfo", O_RDONLY)         = 5

I.e. it still uses procfs. Which is perfectly fine, just encapsulate
it in initscripts so that information would be obtained when system
is booted. Should work for people who don't want procfs around after
that.
							Cheers,
								Al

