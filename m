Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270862AbRHXDzu>; Thu, 23 Aug 2001 23:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270905AbRHXDza>; Thu, 23 Aug 2001 23:55:30 -0400
Received: from [209.202.108.240] ([209.202.108.240]:3334 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S270862AbRHXDzW>; Thu, 23 Aug 2001 23:55:22 -0400
Date: Thu, 23 Aug 2001 23:55:25 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: File System Limitations
In-Reply-To: <01082322391300.12871@bits.linuxball>
Message-ID: <Pine.LNX.4.33.0108232354230.14247-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Aug 2001, Fred wrote:

> I tried dd (GNU fileutils) 4.0.36 (redhat 7.1)
> and compiled and installed dd (fileutils) 4.1
>
> still
> [root@bits /a5]# /usr/fileutils/bin/dd if=/dev/zero of=./tgb count=4000 bs=1M
> File size limit exceeded (core dumped)
> [root@bits /a5]# ls
> total 2098436
>       8 drwxr-xr-x    7 root     root         8192 Aug 23 22:07 .
>    1120 -rwxr-xr-x    1 root     root      1146880 Aug 23 22:07 core
> 2097152 -rwxr-xr-x    1 root     root     2147483647 Aug 23 22:07 tgb
>
> no errors in /var/log/messages
>
>
> some system info
> amd k6-II 500
> 256 MB ram
> Ali 1541/3 chipset
> WD 20GB 7200 rpm and WD 13GB 540 rpm on one cable
> kernel-2.4.9
> /a5 directory above is /dev/hda5 a vfat partition (is this the problem?)
>
>
> TIA
> Fred

The problem is that dd was not compiled with -D_FILE_OFFSET_BITS=64.

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>

