Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267052AbSKSFBI>; Tue, 19 Nov 2002 00:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267057AbSKSFBI>; Tue, 19 Nov 2002 00:01:08 -0500
Received: from wiprom2mx2.wipro.com ([203.197.164.42]:3505 "EHLO
	wiprom2mx2.wipro.com") by vger.kernel.org with ESMTP
	id <S267052AbSKSFBH>; Tue, 19 Nov 2002 00:01:07 -0500
Message-ID: <3DD9C725.D7A9186A@wipro.com>
Date: Tue, 19 Nov 2002 10:37:49 +0530
From: Rashmi Agrawal <rashmi.agrawal@wipro.com>
Reply-To: rashmi.agrawal@wipro.com
Organization: wipro tech
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Michael Clark <michael@metaparadigm.com>
CC: Ragnar =?iso-8859-1?Q?Kj=F8rstad?= <kernel@ragnark.vestdata.no>,
       Jesse Pollard <pollard@admin.navo.hpc.mil>,
       linux-kernel@vger.kernel.org
Subject: Re: Failover in NFS
References: <3DD90197.4DDEEE61@wipro.com> <20021118164408.B30589@vestdata.no> <200211181611.06241.pollard@admin.navo.hpc.mil> <20021118232230.F30589@vestdata.no> <3DD995AF.6090000@metaparadigm.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 19 Nov 2002 05:07:50.0935 (UTC) FILETIME=[9BF10270:01C28F89]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Clark wrote:

> On 11/19/02 06:22, Ragnar Kjørstad wrote:
>
> > But it would not work as described above. There are some important
> > limitations here:
> >
> > - I assumed that /var/lib/nfs is shared. If you want two servers to
> >   be active at once you need a different way to share lock-data.
>
> I'm looking at this problem right now. Basically to support multiple
> virtual NFS servers with failover support, lockd could be modified to
> communicate with the local statd using the dest IP used in the locking
> operation - then statd can modified to look at the peer address
> (which is normally 127.0.0.1) to find out which NFS virtual server
> the monitor request is for. This would also allow you to run a statd
> per virtual NFS server (bound to the specific address instead of
> IPADDR_ANY).

What is the plan for this implementation? Is it going to be part of main line
kernel.
If yes then when will it be available and if no, when will it be available in
the form of
patches.

Should we expect NFs failover support in linux kernel soon??

Rashmi

