Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266688AbRH0T3r>; Mon, 27 Aug 2001 15:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266797AbRH0T3k>; Mon, 27 Aug 2001 15:29:40 -0400
Received: from mg01.austin.ibm.com ([192.35.232.18]:52679 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S266263AbRH0T3Y>; Mon, 27 Aug 2001 15:29:24 -0400
Message-Id: <200108271929.OAA23048@popmail.austin.ibm.com>
Content-Type: text/plain; charset=US-ASCII
From: Andrew Theurer <habanero@us.ibm.com>
Reply-To: habanero@us.ibm.com
To: "Randy.Dunlap" <rddunlap@osdlab.org>
Subject: Re: Journal FS Comparison on IOzone (was Netbench)
Date: Mon, 27 Aug 2001 14:28:48 -0500
X-Mailer: KMail [version 1.3]
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
In-Reply-To: <3B8A6122.3C784F2D@us.ibm.com> <3B8A9070.AD43D0E7@osdlab.org>
In-Reply-To: <3B8A9070.AD43D0E7@osdlab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 August 2001 01:24 pm, Randy.Dunlap wrote:
> Hi,
> 
> I am doing some similar FS comparisons, but using IOzone
> (www.iozone.org)
> instead of Netbench.
> 
> Some preliminary (mostly raw) data are available at:
> http://www.osdlab.org/reports/journal_fs/
> (updated today).
> 
> I am using a Linux 2.4.7 on a 4-way VA Linux system.
> It has 4 GB of RAM, but I have limited it to 256 MB in
> accordance with IOzone run rules.
> 
> However, I suspect that this causes IOzone to measure disk
> subsystem or PCI bus performance more than it does FS performance.
> Any comments on this?

Randy, 

You are definitly exceeding what the kernel will cache and writing to disk on 
some tests.  I guess it depends on what is more important to you.  I think 
both are valid things to test, and you may want to try not limiting memory to 
get just FS performace in memory for large files.  However, writing to disk 
is important, especially for things like bounce-buffer.  Did you have himem 
support in your kernel?  If so, did you have a bounce-buffer elimination 
patch as well? 

Does the storage system/controller have a disk cache?  What size?

Also, does IOzone default to num procs=num cpus?  I didn't see any options in 
your cmdline for num_procs.  

-Andrew



