Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132072AbRDGXeb>; Sat, 7 Apr 2001 19:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132077AbRDGXeW>; Sat, 7 Apr 2001 19:34:22 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:53512 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S132072AbRDGXeD>; Sat, 7 Apr 2001 19:34:03 -0400
Message-Id: <200104072333.f37NXus90906@aslan.scsiguy.com>
To: "J . A . Magallon" <jamagallon@able.es>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: aic7xxx 6.1.10 breaks 2.4.3-ac3 
In-Reply-To: Your message of "Sat, 07 Apr 2001 20:58:34 +0200."
             <20010407205834.A2606@werewolf.able.es> 
Date: Sat, 07 Apr 2001 17:33:56 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> To be expected as you didn't apply the patch to scsi_lib.c that makes
>> scsi_unblock_host() actually run the device queues to start the system
>> back up again.
>>
>
>There is no patch for 2.4.3-ac3. You could say, well if you want 6.1.10,
>use plain 2.4.3.

Actually, I would say, "Apply the 2.4.3 patch.  It will probably apply
cleanly to your kernel.  If it doesn't, and you don't know enough C
to correct the problem, you shouldn't be playing around with kernel
patches."

>That is not the way to do things. It is supposed that what people can get
>at your site is the aic driver.

Ahh, now I have people telling me what the content of my
site should be. ;-)

>If the patch contains something different, from the tarball, nobody knows.

I've figured this part out.

>If there is a bug in kernel, please mail it to lkml.

This has already happened in all cases save the functionality I've added
in 6.1.10.  I haven't even gotten around to announcing 6.1.10 yet, so
you can hardly fault me for not posting the SCSI layer changes yet.

Anyway, posting something to LK doesn't help people running already
released kernels.  Not everyone pushes the bleading edge by updating
their kernel daily.  These people should be able to get driver updates
if they need them.  As for people that run on the bleading edge, kernel
"releases" occur far too often and in too many flavors for me to track
them daily.  So, I work with Linus and Alan to get driver changes
into their trees and provide patches against released kernels.

>And in your site make VERY clear and independent the patch to correct
>that thing in main SCSI subsystem from the patch to upgrade your drivers.

People using the driver will have to have the other fixes.  They are
not separable.  Separating them will only lead to more confusion.  For
instance, 6.1.10 includes patches to Makefiles to correct for a link order
issue.  This is another *required* change for the driver to work well.
Does that need to be in a separate patch file too?

--
Justin
