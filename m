Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318678AbSHAJaC>; Thu, 1 Aug 2002 05:30:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318679AbSHAJaC>; Thu, 1 Aug 2002 05:30:02 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:53263 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S318678AbSHAJaB>; Thu, 1 Aug 2002 05:30:01 -0400
Message-ID: <3D49006C.12ABC6FC@aitel.hist.no>
Date: Thu, 01 Aug 2002 11:33:33 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.29 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: David Lang <david.lang@digitalinsight.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6] The List, pass #2
References: <Pine.LNX.4.44.0207311500210.1038-100000@dlang.diginsite.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:
> 
> > > o Remove all hardwired drivers from kernel
> >
> > I really hope this means drivers MAY be used as modules, not MUST. There
> > is some overhead in doing things as modules, and added complexity usually
> > means "harder to debug." Particularly with modules where there can be
> > corner conditions and races on [un]load.
> 
> Bill,
>   Several people (IIRC including Alan Cox) would like to make many of the
> modules (network cards and scsi drivers for example) mandatory, requiring
> use of an initrd (or it's replacement) on all boot setups.

As far as I know, they plan on doing things like 
disk partition detection outside the kernel, i.e. in
a userspace program.  That clearly require
a initrd (or similiar) for anybody with root
on a partitioned disk.

Lots of other bootup initialization, like DHCP,
might move to userspace as well.  This gives a smaller
and safer kernel.

I cannot see this requiring modules though.  Even a
kernel without any module support at all should
work fine for those who compile their own.
Redhat and other distributors may be interested in
shipping a completely modular kernel that
loads modules from that initrd, but that certainly
won't be a _requirement_ for all kernels. 

Helge Hafting
