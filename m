Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293719AbSCPFot>; Sat, 16 Mar 2002 00:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293720AbSCPFok>; Sat, 16 Mar 2002 00:44:40 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:62928 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S293719AbSCPFo1>; Sat, 16 Mar 2002 00:44:27 -0500
Date: Fri, 15 Mar 2002 21:44:24 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: John Helms <john.helms@photomask.com>
cc: "Randy.Dunlap" <rddunlap@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org, Trice Jim <Jim.Trice@photomask.com>,
        Andmike@us.ibm.com
Subject: Re: bug (trouble?) report on high mem support
Message-ID: <687464031.1016228663@[10.10.2.3]>
In-Reply-To: <20020316.4343600@linux.local>
In-Reply-To: <20020316.4343600@linux.local>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The readprofile output I sent earlier is pretty
> accurate.  I performed the test right after a reboot
> to the enterprise (64GB mem) kernel with a profile=2
> boot option.  I then ran our program, which reads in
> a 3.1GB file from an NFS mount, and outputs a 2.4GB file
> in another format to the same NFS mount.  Networking
> is achieved through an IBM Gigabit fiber card with 
> Intel e1000 chipset, which we have downloaded the
> latest source just to get it to work.  But network
> throughput looks great.  Other programs using the 
> NFS mounts work fine, so I'm pretty sure it's not
> a network issue.
> 
> The smp kernel (no 64GB mem support) completed the
> file conversion in 3.5 hours.  Previous attempts 
> with the enterprise kernel (64GB mem support) had
> to be aborted after 3 days and only started to write
> the converted file to disk by then.  This application
> does not run multi-threaded, but we will have 
> multiple users running the program on separate
> file conversions simultaneously.  Hence the need
> for lots of memory.
> 
> I guess the main question at this point is whether
> our hardware supports high memory, and then which 
> patches or kernel upgrades can correct our problem.
> If we upgrade the entire kernel, which release 
> would you recommend for a stable production machine
> with >4GB memory?  If there are swap improvements,
> we also need whatever we can get in that area.

You mention "64Gb support" or "no 64Gb support" throughout 
this - have you tried a kernel with 4Gb support? That'd
give you the HIGHMEM bounce buffering still. One step at a
time ;-)

M.
