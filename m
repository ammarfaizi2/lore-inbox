Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315806AbSEEBNP>; Sat, 4 May 2002 21:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315810AbSEEBNN>; Sat, 4 May 2002 21:13:13 -0400
Received: from [195.63.194.11] ([195.63.194.11]:36874 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315806AbSEEBNL>; Sat, 4 May 2002 21:13:11 -0400
Message-ID: <3CD47872.30104@evision-ventures.com>
Date: Sun, 05 May 2002 02:10:26 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: linux-kernel@vger.kernel.org, tomita@cinet.co.jp, torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.13 IDE PIO mode Fix
In-Reply-To: <UTC200205041015.g44AFIV16086.aeb@smtp.cwi.nl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Andries.Brouwer@cwi.nl napisa³:
>     I found this bug in 2.5.10 first. And caused ext2 FS corruption.
>     We are porting Linux to PC-9801 architecture (made by NEC Japan).
>     It has PIO ONLY IDE I/F. So please check PIO mode too.
>     # Our porting status - 2.2.x/2.4.x done and updating. 2.5.x partial.
> 
>     diff -urN linux-2.5.10/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
>     --- linux-2.5.10/drivers/ide/ide-taskfile.c    Wed Apr 24 16:15:19 2002
>     +++ linux/drivers/ide/ide-taskfile.c  Fri Apr 26 15:44:42 2002
>     @@ -202,7 +202,7 @@
>                             ata_write_slow(drive, buffer, wcount);
>                     else
>      #endif
>     -                       ata_write_16(drive, buffer, wcount<<1);
>     +                       ata_write_16(drive, buffer, wcount);
>             }
>      }
> 
> Excellent!

Thank you for confirmations. This even streamlines the code to what
it was intendid to be.

BTW.> The next thing I plan to break is host chips initialization,
since Jens introduced several additional ide_dma_action_t fields
for no good reaons... I decided to remove them all as next... :-).

