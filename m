Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313060AbSC0Rm1>; Wed, 27 Mar 2002 12:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313061AbSC0RmS>; Wed, 27 Mar 2002 12:42:18 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51727 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313060AbSC0RmE>;
	Wed, 27 Mar 2002 12:42:04 -0500
Message-ID: <3CA203FA.262EB621@zip.com.au>
Date: Wed, 27 Mar 2002 09:40:10 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alois Treindl <alois@astro.ch>
CC: linux-kernel@vger.kernel.org
Subject: Re: oops with kjournald in SMP 2.4.16
In-Reply-To: <Pine.HPX.4.21.0203271410460.15639-100000@as73.astro.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alois Treindl wrote:
> 
> I had an OOPS and kernel crash last night,
> on a dual CPU 2.4.16 (Dell Poweredge 2450, dual 933 Mhz P3, 1.75 gb RAM).
> 
> The system had been up for about 100 days without reboot.
> 
> I use the ext3 file system with 3 SCSI disks and various NFS clients
> attached to this file server.
> 

[ oops in slab allocation for bh_cachep ]

This looks like random memory corruption - someone wrote somewhere
where they shouldn't have.

For a while we were seeing a lot of these.  Around 2.4.14 to 2.4.17.
I have twenty or thirty different reports saved away.

But they seem to have stopped.  It's beginning to look like whatever
it was got fixed somehow.

> 
> Does anyone recognize this problem, and has it been fixed in later kernels?
> 

Possibly so, yes.  2.4.16 is suspect in this regard.

-
