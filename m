Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311171AbSCPWWp>; Sat, 16 Mar 2002 17:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311127AbSCPWWg>; Sat, 16 Mar 2002 17:22:36 -0500
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:11411 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S311166AbSCPWWR>; Sat, 16 Mar 2002 17:22:17 -0500
Message-Id: <5.1.0.14.2.20020316221729.00a97dd0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 16 Mar 2002 22:22:18 +0000
To: linux-kernel@vger.kernel.org
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Possible to unbind a raw devices so dvd can be ejected?
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After using: raw /dev/raw/raw1 /dev/hdc I no longer can eject the disk in 
/dev/hdc. (kernel version 2.4.19-pre7-ac2)

Using the eject utility I get "device busy" error, obvious as the raw 
binding has done a bd_get() on the /dev/hdc.

But now, how do I unbind it so bd_put is invoked? I don't see any way to do 
it and the raw ioctl doesn't see to offer that functionality either.

If there is no way this is extremely silly as I need to reboot to switch 
from one dvd to another.

I hope I am missing something...

If not is there a patch expanding the raw ioctl with unbind functionality 
and if not would one be accepted? I think that we definitely need one...

Best regards,

Anton



-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

