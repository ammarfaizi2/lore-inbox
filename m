Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270848AbRHXDj2>; Thu, 23 Aug 2001 23:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270849AbRHXDjT>; Thu, 23 Aug 2001 23:39:19 -0400
Received: from [209.38.98.99] ([209.38.98.99]:4994 "EHLO srvr201.castmark.com")
	by vger.kernel.org with ESMTP id <S270848AbRHXDi7>;
	Thu, 23 Aug 2001 23:38:59 -0400
Content-Type: text/plain; charset=US-ASCII
From: Fred <fred@arkansaswebs.com>
To: linux-kernel@vger.kernel.org
Subject: Re: File System Limitations
Date: Thu, 23 Aug 2001 22:39:13 -0500
X-Mailer: KMail [version 1.2]
In-Reply-To: <E15a4Gz-0004uz-00@the-village.bc.nu>
In-Reply-To: <E15a4Gz-0004uz-00@the-village.bc.nu>
MIME-Version: 1.0
Message-Id: <01082322391300.12871@bits.linuxball>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I tried dd (GNU fileutils) 4.0.36 (redhat 7.1)
and compiled and installed dd (fileutils) 4.1

still 
[root@bits /a5]# /usr/fileutils/bin/dd if=/dev/zero of=./tgb count=4000 bs=1M
File size limit exceeded (core dumped)
[root@bits /a5]# ls
total 2098436
      8 drwxr-xr-x    7 root     root         8192 Aug 23 22:07 .
   1120 -rwxr-xr-x    1 root     root      1146880 Aug 23 22:07 core
2097152 -rwxr-xr-x    1 root     root     2147483647 Aug 23 22:07 tgb

no errors in /var/log/messages


some system info
amd k6-II 500
256 MB ram
Ali 1541/3 chipset
WD 20GB 7200 rpm and WD 13GB 540 rpm on one cable
kernel-2.4.9
/a5 directory above is /dev/hda5 a vfat partition (is this the problem?)



TIA
Fred

 _________________________________________________ 
On Thursday 23 August 2001 06:52 pm, Alan Cox wrote:
> > glibc-2.2.2-10
>
> Your C library is new enough
>
> > [root@bits /a5]# dd if=/dev/zero of=./tgb count=4000 bs=1M
> > File size limit exceeded (core dumped)
>
> But your dd program might not be
>
> Alan
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
