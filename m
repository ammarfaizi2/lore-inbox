Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267426AbSLLGQg>; Thu, 12 Dec 2002 01:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267435AbSLLGQg>; Thu, 12 Dec 2002 01:16:36 -0500
Received: from mx13.sac.fedex.com ([199.81.197.53]:34320 "EHLO
	mx13.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S267434AbSLLGQe>; Thu, 12 Dec 2002 01:16:34 -0500
Date: Thu, 12 Dec 2002 14:22:02 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Rusty Russell <rusty@rustcorp.com.au>
cc: "Adam J. Richter" <adam@yggdrasil.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.51 ide module problem (fwd)
Message-ID: <Pine.LNX.4.50.0212121419410.15261-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 12/12/2002
 02:23:56 PM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 12/12/2002
 02:24:20 PM,
	Serialize complete at 12/12/2002 02:24:20 PM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rusty,

Any chance that module-init-tools-0.9.3 can be modified to stop looping
when it detected it has repeated scanning the same module again?

I'm still having problem loading ide as a module under 2.5.51



Thanks,
Jeff
[ jchua@fedex.com ]

---------- Forwarded message ----------
Date: Wed, 11 Dec 2002 15:07:33 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
To: Adam J. Richter <adam@yggdrasil.com>
Cc: jchua@fedex.com,  <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.51 ide module problem

On Tue, 10 Dec 2002, Adam J. Richter wrote:

> >depmod will ecounter "Segmentation fault" if the ide.ko and ide-io.ps
> >modules are in /lib/modules/2.5.51/kernel
>
> 	I think the new depmod recurses infinitely when it encounters
> circular dependencies.  It eventually segfaults and leaves a huge
> modules.dep file from the infinite loop.  If you look at the final
> huge line in that file, you can see where the loop occurred.
>
> 	depmod has no need to do any recursion, since it only needs
> to determine the immediate dependencies of each module.  However,
> noticing such loops and printing them out would be a handy feature.
>
> 	I use IDE as a module, but I had to change the Makefile to
> build a big ide-mod.o from most of the core objects rather than
> allowing each one to be its own module.  I believe I posted IDE
> modularization patches at least once a couple of months ago, but it
> seems to have fallen between the cracks.  I could repost it if need
> be

Yes, please, send me your patch. I hope this patch works for
module-init-tools-0.9.3

>, although I have not yet booted 2.5.51.

I had same problem with pre 2.5.51. With 2.5.51, kernel now boot and I'm
able to get login prompt using ramdisk. Only catch is I've to specify
root=/dev/ram0 instead of /dev/ram for it to boot.


Thanks,
Jeff.

>
> 	Also note that I have not used the in kernel-based module
> loader recently, as I have been patching my kernels to use the user
> level module code.  I am planning to try the kernel-base module loader
> in 2.5.51 once I fix other problems it has finding the root device
> under devfs.  So, it's remotely possible that you may also see module
> problems that I've missed.
>
> Adam J. Richter     __     ______________   575 Oroville Road
> adam@yggdrasil.com     \ /                  Milpitas, California 95035
> +1 408 309-6081         | g g d r a s i l   United States of America
>                          "Free Software For The Rest Of Us."
>
