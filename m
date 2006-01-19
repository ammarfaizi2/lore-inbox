Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161120AbWASAs5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161120AbWASAs5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 19:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161119AbWASAs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 19:48:56 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:41481 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161120AbWASAsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 19:48:55 -0500
Date: Thu, 19 Jan 2006 01:48:54 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Max Waterman <davidmaxwaterman+kernel@fastmail.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: io performance...
Message-ID: <20060119004853.GP19398@stusta.de>
References: <43CB4CC3.4030904@fastmail.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43CB4CC3.4030904@fastmail.co.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2006 at 03:35:31PM +0800, Max Waterman wrote:
> Hi,
> 
> I've been referred to this list from the linux-raid list.
> 
> I've been playing with a RAID system, trying to obtain best bandwidth
> from it.
> 
> I've noticed that I consistently get better (read) numbers from kernel 2.6.8
> than from later kernels.
> 
> For example, I get 135MB/s on 2.6.8, but I typically get ~90MB/s on later
> kernels.
> 
> I'm using this :
> 
> <http://www.sharcnet.ca/~hahn/iorate.c>
> 
> to measure the iorate. I'm using the debian distribution. The h/w is a 
> MegaRAID
> 320-2. The array I'm measuring is a RAID0 of 4 Fujitsu Max3073NC 15Krpm 
> drives.
> 
> The later kernels I've been using are :
> 
> 2.6.12-1-686-smp
> 2.6.14-2-686-smp
> 2.6.15-1-686-smp
> 
> The kernel which gives us the best results is :
> 
> 2.6.8-2-386
> 
> (note that it's not an smp kernel)
> 
> I'm testing on an otherwise idle system.
> 
> Any ideas to why this might be? Any other advice/help?

You should try to narrow the problem a bit down.

Possible causes are:
- kernel regression between 2.6.8 and 2.6.12
- SMP <-> !SMP support
- patches and/or configuration changes in the Debian kernels

You should try self-compiled unmodified 2.6.8 and 2.6.12 ftp.kernel.org 
kernels with the same .config (modulo differences by "make oldconfig").

After this test, you know whether you are in the first case.
If yes, you could do a bisect search for finding the point where the 
regression started.

> Thanks!
> 
> Max.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

