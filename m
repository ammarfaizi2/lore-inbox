Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131095AbQKRCBM>; Fri, 17 Nov 2000 21:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131173AbQKRCBC>; Fri, 17 Nov 2000 21:01:02 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:3722 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131154AbQKRCAw>;
	Fri, 17 Nov 2000 21:00:52 -0500
Date: Fri, 17 Nov 2000 20:30:44 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: VFS Kernel Panic in 2.4.0-10(11)
In-Reply-To: <3A15D50A.6818516A@timpanogas.org>
Message-ID: <Pine.GSO.4.21.0011172026480.18150-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 17 Nov 2000, Jeff V. Merkey wrote:

> 	
> This is probably a configuration mismatch of some kind, but I just
> finished building my 2.4.0 RPM skeletons and am installting them from
> our latest CD burn, and I am seeing the following 
> problem when I upgrade our 2.2.17 kernel versions with 2.4.0-test10,
> then reboot them under 2.4:
> 
> request_module[block-major-3]:  Root fs not mounted
> VFS cannot open root device "301" or 03:01
> Please append a correct "root=" boot option 
> Kernel panic: VFS: Unable to mount root fs on 03:01.

IDE built as module. Root on IDE disk. Apparently, no initrd in sight.
Check your .config and either don't make IDE a module or enable initrd
and make sure to put the modules into initrd image.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
