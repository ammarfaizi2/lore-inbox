Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317625AbSFIO5Y>; Sun, 9 Jun 2002 10:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317626AbSFIO5Y>; Sun, 9 Jun 2002 10:57:24 -0400
Received: from [195.63.194.11] ([195.63.194.11]:14606 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317625AbSFIO5W>; Sun, 9 Jun 2002 10:57:22 -0400
Message-ID: <3D035D68.5000407@evision-ventures.com>
Date: Sun, 09 Jun 2002 15:51:36 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
CC: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, linux-kernel@vger.kernel.org,
        chaffee@cs.berkeley.edu
Subject: Re: [patch] fat/msdos/vfat crud removal
In-Reply-To: <200206090603.g5963FA458690@saturn.cs.uml.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert D. Cahalan wrote:

> The new struct:
> 
> /* Note the end: __attribute__ ((packed)) */
> struct fat_boot_sector {
>         char    ignored[3];     /* Boot strap short or near jump */
>         __u64   system_id;      /* Name - can be used to special case
>                                    partition manager volumes */
....
>         __u16   info_sector;    /* filesystem info sector */
>         __u16   backup_boot;    /* backup boot sector */
>         __u16   reserved2[6];   /* Unused */
> } __attribute__ ((packed)) ;


And don't use __uXX but just uXX for bit field integer types in
sturctures, which are supposed to be only used by the kernel.


