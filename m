Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315427AbSH0JNS>; Tue, 27 Aug 2002 05:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315445AbSH0JNS>; Tue, 27 Aug 2002 05:13:18 -0400
Received: from maroon.csi.cam.ac.uk ([131.111.8.2]:61418 "EHLO
	maroon.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S315427AbSH0JNR>; Tue, 27 Aug 2002 05:13:17 -0400
Message-Id: <5.1.0.14.2.20020827101100.02b46e90@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 27 Aug 2002 10:17:47 +0100
To: Andre Bonin <kernel@bonin.ca>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: Loop devices under NTFS
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D6B04AD.1050000@bonin.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 05:48 27/08/02, Andre Bonin wrote:
>I don't know if this is kernel-related.

It is.

>I'me trying to mount my redhat iso's off an NTFS mount but I get a strange 
>error.  Here is the exact command I am entering:
>
>"mount -o loop -r -t iso9660 /mnt/win_d/Source/Iso/Red\ Hat\ 
>7.3/valhalla-i386-disc1.iso /mnt/rh7.3/cd1"
>
>It gives me an error
>"ioctl: LOOP_SET_FD: Invalid argument"
>
>A quick grep found that "Invalid argument" comes from:
>'acsi.c:322:     { 0x24, "Invalid argument" }'

Your grep was too quick...

>Anyone have any ideas?

Yes, you forgot to tell us which kernel version you are using! And even 
more importantly which NTFS driver version?

If you are using 2.4.x then you are likely to have the old ntfs driver 
which does NOT support mounting of loopback devices.

If you are using 2.5.x then you have the new driver and what you did ought 
to have worked without problems. Also, if you are using 2.4.18/19/20-pre 
you could be using the new driver by installing our patches - you can get 
the patch for 2.4.19 from:
         http://linux-ntfs.sf.net/downloads.html
or you can clone/pull from our bitkeeper repository which is currently at 
2.4.20-pre4 or so:
         http://linux-ntfs.bkbits.net/ntfs-2.4

So check your kernel & ntfs version and if your ntfs driver version is 1.* 
then you know you have the old driver and if you have 2.* then you know you 
have the new driver.

Once again the old driver will not work. The new one should work just fine.

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

