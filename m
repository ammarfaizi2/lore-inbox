Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129226AbQK3SpD>; Thu, 30 Nov 2000 13:45:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129423AbQK3Sox>; Thu, 30 Nov 2000 13:44:53 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:44273 "EHLO
        webber.adilger.net") by vger.kernel.org with ESMTP
        id <S130991AbQK3SSC>; Thu, 30 Nov 2000 13:18:02 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200011301745.eAUHjOE16081@webber.adilger.net>
Subject: Re: 'holey files' not holey enough.
In-Reply-To: <Pine.LNX.4.21.0011300929330.1152-200000@eax.student.umd.edu>
 "from Adam at Nov 30, 2000 09:34:37 am"
To: Adam <adam@eax.com>
Date: Thu, 30 Nov 2000 10:45:23 -0700 (MST)
CC: Andreas Dilger <adilger@turbolinux.com>, Marc Mutz <Marc@mutz.com>,
        linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam writes:
> I just did what suggested, and it seems that DU reports correct values,
> I have attached 'sript' log of the above example on my filesystem.
> Here are some highlights:
> 
> [adam@pepsi /tmp]$ ls -lis holed.file
> 3085069 5872 -rw-rw-r--    1 adam     adam      6000000 Nov 30 09:11 holed.file
> 
> Block size = 4096, fragment size = 4096
> Links: 1   Blockcount: 11744
> TOTAL: 1468
> 
> so it seems DU reports correct values as :
> 	11744/2=5872
> and
> 	4096*1468=6012928

I guess the next thing to check is if your "dd" is actually seeking, or
just pretending to...  Maybe an strace of the "dd" call will tell us if
it is screwing with our minds.  Also, if you could make a scratch ext2
filesystem with 1k blocks, and see if it does the same thing.  Even
better would be to try a different kernel to see if it affects this.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
