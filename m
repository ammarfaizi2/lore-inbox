Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271211AbRHOPJf>; Wed, 15 Aug 2001 11:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271218AbRHOPJ0>; Wed, 15 Aug 2001 11:09:26 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:4595 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S271211AbRHOPJJ>; Wed, 15 Aug 2001 11:09:09 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200108151509.f7FF99dT013015@webber.adilger.int>
Subject: Re: [BUG?] :: "Value too large for defined data type"
In-Reply-To: <Pine.LNX.4.21.0108150418230.8270-100000@scotch.homeip.net>
 "from God at Aug 15, 2001 04:22:05 am"
To: God <atm@sdk.ca>
Date: Wed, 15 Aug 2001 09:09:09 -0600 (MDT)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"God" writes:
> I noticed that when I tried to backup a box across the LAN via dump to a
> localy mounted drive ...
> 
> Box2 has 
> /mnt/backup, mounted to box2:/mnt/hdb1.  
> 
> # ls -al
> /bin/ls: test: Value too large for defined data type
> total 2097216
> drwxrwxrwx   2 root     root        32768 Aug 14 23:27 ./
> drwxrwxrwx  50 root     root        32768 Aug 14 21:02 ../
> -rwxrwxrwx   1 root     root     2147483647 Aug 14 22:11
> box1.071401.dump*
> #
> 
> Ok so I lied, that is a paste from after my little expriment, but you can
> see the file size.  2.1G, out of a 3G drive.
> 
> I tried to remove the file using rm, but I get the same error as ls:
> 
> # rm test
> rm: cannot remove `test': Value too large for defined data type

Well, considering this problem has been discussed several times on this
list, I would consider removing your "God" monicker, as you are neither
omniscient, nor omnipotent.

In any case, the problem is not with the kernel, but the fact that you
have file utilities that do not use "O_LARGEFILE" when working with
large files.  Update your fileutils package, and all will be well.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

