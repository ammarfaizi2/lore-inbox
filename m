Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282839AbRLGMPh>; Fri, 7 Dec 2001 07:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282848AbRLGMP1>; Fri, 7 Dec 2001 07:15:27 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:56822 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S282839AbRLGMPK>; Fri, 7 Dec 2001 07:15:10 -0500
Message-Id: <5.1.0.14.2.20011207120516.025daa50@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 07 Dec 2001 12:14:08 +0000
To: Ishan Oshadi Jayawardena <ioshadi@sltnet.lk>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Fs's affected by smart atime updates
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3C115125.E70E0674@sltnet.lk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 23:30 07/12/01, Ishan Oshadi Jayawardena wrote:
>         I've found out that NTFS and FAT are not affected
>adversely by the atime update patch by Andrew Morton.

"adversely"? The patch is an improvement, not something that makes things 
worse...

>(atime resolution in NTFS is 1 hour and in FAT, well,
>1 day!). I'd be thankful if anyone could point out
>which filesystems, if any, are _adversely_ affected by this.

Huh? Atime updates in the old NTFS driver do not happen at all unless I 
have missed something.

Otherwise, the time resolution itself is down to 100ns intervals which in 
Linux obviously isn't possible, so the Linux atime resolution will be used 
instead.

The new NTFS TNG driver will be doing the atime updates properly once write 
support is implemented.

Best regards,

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

