Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129148AbQKOKIh>; Wed, 15 Nov 2000 05:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129819AbQKOKI2>; Wed, 15 Nov 2000 05:08:28 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:29452 "EHLO
	wisbech.cl.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S129148AbQKOKIT>; Wed, 15 Nov 2000 05:08:19 -0500
X-Mailer: exmh version 2.0.2+CL 2/24/98
To: Peter Samuelson <peter@cadcamlab.org>
cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: RAID modules and CONFIG_AUTODETECT_RAID 
In-Reply-To: Your message of "Wed, 15 Nov 2000 03:07:52 CST."
             <20001115030752.K18203@wire.cadcamlab.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 15 Nov 2000 09:38:14 +0000
From: Ian Grant <Ian.Grant@cl.cam.ac.uk>
Message-Id: <E13vz1D-0001zr-00@wisbech.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> [Ian Grant]
> > In 2.2.x we were able to build a kernel with RAID modules and have it
> > autodetect RAID partitions at boot time - so we could use raid root
> > partitions.
> 
> Really?  Funny, because IIRC RAID autodetection does not even exist in
> 2.2.x kernels.  Perhaps you are referring to vendor-patched kernels --
> some distributions ship 2.2 kernels with RAID patches applied.

Sorry, I am referring to 2.2.x with Ingo's RAID patches.

> > In 2.40 the configuration option CONFIG_AUTODETECT_RAID is explicitly
> > disabled unless at least one RAID module is built into the kernel.  I
> > presume there is a good reason for this and that it's not just a
> > mistake.
> 
> What would be the point?  Autodetection is only needed for mounting the
> root filesystem.  After root is mounted, you can use raidtools.

I'll try again: we need autodetection to mount a RAID root filesystems on 
those machines that have them, but we don't want RAID *built in* to the kernel 
- we want it as modules, because lots of our machines don't have RAID 
partitions on their disks at all.  i.e. I want CONFIG_MD_{LINEAR,RAID{0,1,5}}=m
 but then I can't say CONFIG_AUTODETECT_RAID=y We could do this with Ingo's 
patches for 2.2.x but we can't do it with 2.4.0

Of course we need an initrd with the raid modules on it before we can boot 
from a RAID root partition.

-- 
Ian Grant, Computer Lab., New Museums Site, Pembroke Street, Cambridge
Phone: +44 1223 334420          Personal e-mail: iang at pobox dot com 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
