Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132701AbRDNBki>; Fri, 13 Apr 2001 21:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132702AbRDNBk2>; Fri, 13 Apr 2001 21:40:28 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:36021 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S132701AbRDNBkR>;
	Fri, 13 Apr 2001 21:40:17 -0400
Date: Fri, 13 Apr 2001 21:25:10 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
cc: linux-kernel@vger.kernel.org, jmerkey@timpanogas.org,
        Linus Torvalds <torvalds@transmeta.com>, Linux390@de.ibm.com
Subject: Re: EXPORT_SYMBOL for chrdev_open 2.4.3
In-Reply-To: <20010413184740.A14659@vger.timpanogas.org>
Message-ID: <Pine.GSO.4.21.0104132118060.24992-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 13 Apr 2001, Jeff V. Merkey wrote:

> Not meaning to offend, but how could you know what everyone 
> who uses Linux needs in every instance?  NT, NetWare, etc. all
> expose these types of APIs for Backup and anti-virus software,
> etc.  The APIs in question are the very calls user space apps
> call through the syscall to indicate who is using a device. 

Backup and AV software is not in the kernel, so they would
be unable to use the thing, exported or not. Please, don't
bring the strawmen.

Novell's model (aka. "we don't need no stinkin' userland, everything
is NLM and security be damned") is better left to rot in hell with Novell.

> Sure, I can send blind I/O requests to a device and I guess 
> someone running fdisk in user space can blow the device away from beneath 
> me since I have no way of locking those partitions I exclusively
> own and stopping this is these apis are removed and modules 
> cannot call them.  

Use filp_open() - it's that simple.

