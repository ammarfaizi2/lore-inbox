Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313477AbSFEH4d>; Wed, 5 Jun 2002 03:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313505AbSFEH4c>; Wed, 5 Jun 2002 03:56:32 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:30729 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S313477AbSFEH4c>; Wed, 5 Jun 2002 03:56:32 -0400
Message-ID: <3CFDC428.E9CB3E80@aitel.hist.no>
Date: Wed, 05 Jun 2002 09:56:24 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.20-dj1 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Ketil Froyn <ketil-kernel@froyn.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: One disk, one filesystem, no partitions?
In-Reply-To: <Pine.LNX.4.40L0.0206041716270.1413-100000@ketil.np>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ketil Froyn wrote:
> 
> Hi.
> 
> I have a question regarding something I came across a while ago. A
> filesystem (reiserfs) had been set up on a disk without making any
> partitions. The entry in /etc/fstab looked something like this:
> 
> /dev/hdc        /mount/point    reiserfs        defaults        0 0
> 
> When I saw this, I instinctively partitioned the drive so that /dev/hdc1
> was mounted instead. But was this really necessary? If I want to put only
> one filesystem on a disk, do I need to partition at all? It seemed to work
> fine before I changed it. I had just never heard of this before, and
> automatically assumed that the problems the box was having could be
> related to this.

fs'es are mounted from block devices, and /dev/hdc
is as much block device as /dev/hdc1.  Just like a
floppy - they don't have partition tables either.

Booting off such a thing will work too, if the bios
don't make assumptions about partitioning.  They
used not to, last time I looked the pc bios simply
executes the first sector of the disk and
the code there have do support partitions itself
if necessary.

I see no need to partition such a beast into
a single big partition - you just loose 
a sector to the partition table.  

Helge Hafting
