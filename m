Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292988AbSBVUeO>; Fri, 22 Feb 2002 15:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292989AbSBVUeE>; Fri, 22 Feb 2002 15:34:04 -0500
Received: from pc3-camc5-0-cust13.cam.cable.ntl.com ([80.4.125.13]:63964 "EHLO
	fenrus.demon.nl") by vger.kernel.org with ESMTP id <S292988AbSBVUdv>;
	Fri, 22 Feb 2002 15:33:51 -0500
Date: Fri, 22 Feb 2002 20:32:14 GMT
Message-Id: <200202222032.g1MKWEw17601@fenrus.demon.nl>
From: arjan@fenrus.demon.nl
To: Andre Hedrick <andre@linuxdiskcert.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9
In-Reply-To: <Pine.LNX.4.10.10202221204400.2519-100000@master.linux-ide.org>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.9-21 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.10.10202221204400.2519-100000@master.linux-ide.org> you wrote:

> SCSI/ATA share the same problem IIRC, the host/chipset drivers load all
> the device hosts who match that driver code.
 
> What am I missing?

I know that for scsi it can be fixed. Ok the current scsi layer doesn't do
it right, but there's nothing that prevents it in principle.

Eg

PCI code sees a PCI ID, calls probe for the chip
   chip driver looks and sees 2 "cables" and creates host structures for
   each.
   per host drive discovery is done and registered with a (thin) generic
   "I am a disk, gimme a major/minor" layer.

That ought to work. And on hotplug your probe just get called again...

   
