Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268675AbRHQSV2>; Fri, 17 Aug 2001 14:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269391AbRHQSVS>; Fri, 17 Aug 2001 14:21:18 -0400
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:43908 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S268675AbRHQSVJ>; Fri, 17 Aug 2001 14:21:09 -0400
Message-Id: <5.1.0.14.2.20010817190012.04579580@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 17 Aug 2001 19:21:19 +0100
To: Andreas Dilger <adilger@turbolabs.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Error on fs unmount
Cc: Peter Klotz <peter.klotz@aon.at>, linux-kernel@vger.kernel.org
In-Reply-To: <20010817114820.D17372@turbolinux.com>
In-Reply-To: <01081718390800.01143@localhost.localdomain>
 <01081718390800.01143@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 18:48 17/08/2001, Andreas Dilger wrote:
>On Aug 17, 2001  18:39 +0200, Peter Klotz wrote:
> > Kernel 2.4.8 produces the following message on almost every shutdown:
> >
> > Unmounting filesystems: Trying to _clear_inode of system file 9! Shouldn't
> > happen.
>
>Please tell us what filesystem you are using?

He is using NTFS. I recognize my error message. (-; [A little omission of 
mine results in not getting the string "NTFS: " printed at the beginning of 
the error message. )-: Fixed in my tree and will be in next patch release.]

Peter,

Could you tell me whether on startup (or whenever you mount the NTFS 
volume) it doesn't give a message but saying: "Trying to open system file 
9!" or "Opening system file 9!".

If you only get the _clear_inode message that would be bad, but if you get 
a corresponding "Trying to open..." message, then just ignore them for the 
moment. - This is part of stage one of a cleanup in ntfs system file 
handling and this is just a message telling you someone is trying to close 
a system file which hasn't been opened yet, which should indeed never 
happen. - This will disappear with my next update to ntfs which completes 
the system file cleanup stuff.

If you only get the _clear_inode message this is very bad and I would like 
to know more... but I suspect you will find the matching message.

Best regards,

Anton



-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

