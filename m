Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315805AbSEEBKp>; Sat, 4 May 2002 21:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315806AbSEEBKi>; Sat, 4 May 2002 21:10:38 -0400
Received: from [195.63.194.11] ([195.63.194.11]:34826 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315805AbSEEBJ2>; Sat, 4 May 2002 21:09:28 -0400
Message-ID: <3CD4777F.80203@evision-ventures.com>
Date: Sun, 05 May 2002 02:06:23 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Osamu Tomita <tomita@cinet.co.jp>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.13 IDE PIO mode Fix
In-Reply-To: <3CD31883.E41E0DFA@cinet.co.jp>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Osamu Tomita napisa?:
> I found this bug in 2.5.10 first. And caused ext2 FS corruption.
> We are porting Linux to PC-9801 architecture (made by NEC Japan).
> It has PIO ONLY IDE I/F. So please check PIO mode too.

Hey I can't do everything. And I know that people like you will
check it anyway :-)... But seriously - Thank you very much for
the plague and indeed 16 bit transfers are something I see makes sense for
embedded platforms.


> # Our porting status - 2.2.x/2.4.x done and updating. 2.5.x partial.
> 
> diff -urN linux-2.5.10/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
> --- linux-2.5.10/drivers/ide/ide-taskfile.c    Wed Apr 24 16:15:19 2002
> +++ linux/drivers/ide/ide-taskfile.c  Fri Apr 26 15:44:42 2002
> @@ -202,7 +202,7 @@
>                         ata_write_slow(drive, buffer, wcount);
>                 else
>  #endif
> -                       ata_write_16(drive, buffer, wcount<<1);
> +                       ata_write_16(drive, buffer, wcount);
>         }
>  }

