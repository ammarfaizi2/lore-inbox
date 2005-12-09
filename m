Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932444AbVLIUVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbVLIUVT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 15:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbVLIUVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 15:21:19 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:10160 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932444AbVLIUVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 15:21:19 -0500
Subject: Re: i386 -> x86_64 cross compile failure (binutils bug?)
From: Lee Revell <rlrevell@joe-job.com>
To: Kyle McMartin <kyle@mcmartin.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20051209195816.GF32168@quicksilver.road.mcmartin.ca>
References: <1134154208.14363.8.camel@mindpipe>
	 <20051209195816.GF32168@quicksilver.road.mcmartin.ca>
Content-Type: text/plain
Date: Fri, 09 Dec 2005 15:21:16 -0500
Message-Id: <1134159677.18432.7.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-09 at 14:58 -0500, Kyle McMartin wrote:
> On Fri, Dec 09, 2005 at 01:50:08PM -0500, Lee Revell wrote:
> > I'm trying to build an x66-64 kernel on a 32 bit system (Ubuntu 5.10).
> > I added -m64 to the CFLAGS as per the gcc docs.  But the build fails
> > with:
> > 
> > $ make ARCH=x86_64
> > arch/x86_64/kernel/entry.S:785: Error: cannot represent relocation type BFD_RELOC_64
> 
> Ubuntu/Debian provide a biarch gcc, but do not (did not?) provide a biarch
> assembler. Building binutils for target x86_64-pc-linux-gnu should help.
> 

I thought that might be the problem so I installed an x86-64 binutils
from:

http://debian.speedblue.org

I tried with CROSS_COMPILE="/usr/x86_64/bin/x86_64-linux-", but edited
the Makefile to set CC to /use/bin/gcc.  Same error.

Lee

