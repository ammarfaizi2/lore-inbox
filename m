Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267070AbTCFANb>; Wed, 5 Mar 2003 19:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267083AbTCFANb>; Wed, 5 Mar 2003 19:13:31 -0500
Received: from air-2.osdl.org ([65.172.181.6]:11476 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267070AbTCFANa>;
	Wed, 5 Mar 2003 19:13:30 -0500
Date: Wed, 5 Mar 2003 18:00:05 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Bob Miller <rem@osdl.org>
cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bugme-new] [Bug 442] New: compile failure in drivers/cpufreq/userspace.c
 (fwd)
In-Reply-To: <20030306002225.GA10819@doc.pdx.osdl.net>
Message-ID: <Pine.LNX.4.33.0303051759060.998-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 5 Mar 2003, Bob Miller wrote:

> On Wed, Mar 05, 2003 at 02:53:33PM -0800, Martin J. Bligh wrote:
> >   gcc -Wp,-MD,drivers/cpufreq/.userspace.o.d -D__KERNEL__ -Iinclude -Wall
> > -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe
> > -mpreferred-stack-boundary=2 -march=athlon -Iinclude/asm-i386/mach-default
> > -nostdinc -iwithprefix include    -DKBUILD_BASENAME=userspace
> > -DKBUILD_MODNAME=userspace -c -o drivers/cpufreq/.tmp_userspace.o
> > drivers/cpufreq/userspace.c
> > drivers/cpufreq/userspace.c: In function `cpufreq_governor_userspace':
> > drivers/cpufreq/userspace.c:514: structure has no member named `intf'
> > drivers/cpufreq/userspace.c:523: structure has no member named `intf'
> > make[2]: *** [drivers/cpufreq/userspace.o] Error 1
> > make[1]: *** [drivers/cpufreq] Error 2
> > make: *** [drivers] Error 2
> 
> I believe the patch below fixes the problem.  Pat?

Yup, that'll do it. 

I just sent Linus an update with an identical patch in it, so hopefully 
it'll be in BK soon.

	-pat

