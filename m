Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284817AbRLEXX6>; Wed, 5 Dec 2001 18:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284819AbRLEXXs>; Wed, 5 Dec 2001 18:23:48 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:51465 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S284439AbRLEXXe>; Wed, 5 Dec 2001 18:23:34 -0500
Date: Wed, 5 Dec 2001 23:23:13 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Dave Jones <davej@suse.de>
Cc: Ben Pharr - Lists <ben-lists@benpharr.com>, linux-kernel@vger.kernel.org
Subject: Re: Missing Files
Message-ID: <20011205232313.C27558@flint.arm.linux.org.uk>
In-Reply-To: <5.1.0.14.0.20011205160555.00a10ec0@sunset.olemiss.edu> <Pine.LNX.4.33.0112052323440.18145-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0112052323440.18145-100000@Appserv.suse.de>; from davej@suse.de on Wed, Dec 05, 2001 at 11:25:23PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2001 at 11:25:23PM +0100, Dave Jones wrote:
> On Wed, 5 Dec 2001, Ben Pharr - Lists wrote:
> > gcc -D__KERNEL__ -I/usr/src/linux-2.4.17-pre4/include -Wall
> > -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> > -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> > -march=i686  -E -D__GENKSYMS__ sa1100fb.c
> > | /sbin/genksyms  -k 2.4.17 >
> > /usr/src/linux-2.4.17-pre4/include/linux/modules/sa1100fb.ver.tmp
> > sa1100fb.c:164: linux/cpufreq.h: No such file or directory
> 
> Looks like an incomplete ARM sync. But why are you trying to
> build sa1100fb on x86 anyway ?

The files are there.  This is just one of the kbuild 2.4 disease -
unconditionally making module symbols for all files specified in
export-objs.  Hopefully kbuild 2.5 fixes this.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

