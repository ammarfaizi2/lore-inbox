Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261625AbSJQBz5>; Wed, 16 Oct 2002 21:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261627AbSJQBz5>; Wed, 16 Oct 2002 21:55:57 -0400
Received: from smtp1.san.rr.com ([24.25.195.37]:34716 "EHLO smtp1.san.rr.com")
	by vger.kernel.org with ESMTP id <S261625AbSJQBzz>;
	Wed, 16 Oct 2002 21:55:55 -0400
Date: Wed, 16 Oct 2002 18:59:03 -0700
From: Andrew Vasquez <praka@san.rr.com>
To: linux-kernel@vger.kernel.org
Cc: Michael Clark <michael@metaparadigm.com>, J Sloan <joe@tmsusa.com>,
       GrandMasterLee <masterlee@digitalroadkill.net>,
       Simon Roscic <simon.roscic@chello.at>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [Kernel 2.5] Qlogic 2x00 driver
Message-ID: <20021017015903.GA20960@praka.local.home>
Mail-Followup-To: Andrew Vasquez <praka@san.rr.com>,
	linux-kernel@vger.kernel.org,
	Michael Clark <michael@metaparadigm.com>, J Sloan <joe@tmsusa.com>,
	GrandMasterLee <masterlee@digitalroadkill.net>,
	Simon Roscic <simon.roscic@chello.at>,
	Arjan van de Ven <arjanv@redhat.com>
References: <200210152120.13666.simon.roscic@chello.at> <1034710299.1654.4.camel@localhost.localdomain> <200210152153.08603.simon.roscic@chello.at> <3DACD41F.2050405@metaparadigm.com> <1034740592.29313.0.camel@localhost> <3DACEB6E.6050700@metaparadigm.com> <3DACEC85.3020208@tmsusa.com> <3DACF908.70207@metaparadigm.com> <20021016054035.GM15552@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021016054035.GM15552@clusterfs.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.20-pre10-ac2
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Oct 2002, Andreas Dilger wrote:

> On Oct 16, 2002  13:28 +0800, Michael Clark wrote:
> > Every one i was getting oops when used with a combination
> > of ext3, LVM1 and qla2x00 driver.
> > 
> > Since taking LVM1 out of the picture, my oopsing problem has
> > gone away. This could of course not be LVM1's fault but the
> > fact that qla driver is a stack hog or something - i don't have
> > enough information to draw any conclusions all at the moment
> > i'm too scared to try LVM again (plus the time it takes to
> > migrate a few hundred gigs of storage).
> 
> Yes, we have seen that ext3 is a stack hog in some cases, and I
> know there were some fixes in later LVM versions to remove some
> huge stack allocations.  Arjan also reported stack problems with
> qla2x00, so it is not a surprise that the combination causes
> problems.
> 
The stack issues were a major problem in the 5.3x series driver.  I
believe, I can check tomorrow, 5.38.9 (the driver Dell distributes)
contains fixes for the stack clobbering -- qla2x00-rh1-3 also contain
the fixes.

IAC, I believe the support tech working with MasterLee had asked 
for additional information regarding the configuration as well as
some basic logs.  Ideally we'd like to setup a similiar configuration
in house and see what's happening...

--
Andrew Vasquez | praka@san.rr.com |
DSS: 0x508316BB, FP: 79BD 4FAC 7E82 FF70 6C2B  7E8B 168F 5529 5083 16BB
