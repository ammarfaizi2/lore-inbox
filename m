Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290729AbSBGRp1>; Thu, 7 Feb 2002 12:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290742AbSBGRpY>; Thu, 7 Feb 2002 12:45:24 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:59912 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S290729AbSBGRoZ>; Thu, 7 Feb 2002 12:44:25 -0500
Date: Thu, 7 Feb 2002 14:34:20 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@zip.com.au>, Manfred Spraul <manfred@colorfullife.com>,
        Andrea Arcangeli <andrea@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] VM_IO fixes
In-Reply-To: <Pine.LNX.4.33.0202071259510.5900-100000@serv>
Message-ID: <Pine.LNX.4.21.0202071433480.17162-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Feb 2002, Roman Zippel wrote:

> Hi,
> 
> On Wed, 6 Feb 2002, Andrew Morton wrote:
> 
> > Any filesystem which implements its own mmap() method, and which
> > does not call generic_file_mmap() needs to be changed to clear
> > VM_IO inside its mmap function.  All in-kernel filesystems are
> > OK, as is XFS.  And the only breakage this can cause to out-of-kernel
> > filesystems is failure to include mappings in core files, and
> > inability to use PEEKUSR.
> 
> You forgot shared memory via mm/shmem.c and ipc/shm.c.

Andrew, could you please send me an uptodated patch to fix that ? 

> Another possibility is to test whether the driver provides a nopage
> function, as i/o areas are usually mapped with io_remap_page_range. 

Eek, thats too kludgy. ;) 

