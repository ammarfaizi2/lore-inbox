Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132147AbRDTXu4>; Fri, 20 Apr 2001 19:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132186AbRDTXur>; Fri, 20 Apr 2001 19:50:47 -0400
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:39314 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S132147AbRDTXuc>; Fri, 20 Apr 2001 19:50:32 -0400
Message-Id: <5.0.2.1.2.20010421004842.04a08df0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Sat, 21 Apr 2001 00:52:55 +0100
To: Thomas Dodd <ted@cypress.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Current status of NTFS support
Cc: linux-kernel@vger.kernel.org, Wayne.Brown@altec.com
In-Reply-To: <3AE0B945.22A3CABB@cypress.com>
In-Reply-To: <86256A34.0079A841.00@smtpnotes.altec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 23:33 20/04/2001, Thomas Dodd wrote:
>Wayne.Brown@altec.com wrote:
> > Also, I'll have to recreate my Linux partitions after the 
> upgrade.  Does anyone
>
>Oll you should need is a boot floppy to get back into linux and fix
>the MBR (rerun lilo?) after the Windows install.

Rerunning lilo is correct fix. But modify your lilo.conf and /etc/fstab to 
reflect eventual changes in partition names first. - You said that two 
partitions are getting merged so there might be changes...

>Don't try to write to and NTFS partition from linux.
>You probably don't want to mount the Win2k version of
>NTFS in linux either. At one point that could damage the
>filesystem too.

This is not true. NTFS driver will NEVER write to your file system unless 
it is mounted read-write. Even if journalling was implemented it still 
wouldn't write to your fs when mounted read only as long as I have 
something to say about it! Read only means read only IMO, full stop, end of 
discussion. - If you have ever seen it write to the disk when mounted read 
only please let me know as I consider this an extremely serious bug!

Best regards,

         Anton


-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://sourceforge.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

