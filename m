Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315408AbSEGLPB>; Tue, 7 May 2002 07:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315409AbSEGLPA>; Tue, 7 May 2002 07:15:00 -0400
Received: from [195.63.194.11] ([195.63.194.11]:28168 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315408AbSEGLO7>; Tue, 7 May 2002 07:14:59 -0400
Message-ID: <3CD7A877.4050305@evision-ventures.com>
Date: Tue, 07 May 2002 12:12:07 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 55
In-Reply-To: <Pine.LNX.4.21.0205070156580.32715-100000@serv>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Roman Zippel napisa?:
> Hi,
> 
> On Mon, 6 May 2002, Martin Dalecki wrote:
> 
> 
>>- Consolidate the handling of device ID byte order in one place.
>>   This was spotted and patched by Bartomiej onierkiewicz.
> 
> 
> Another thing: where is the equivalilent part of this removed code?

Look closer it's there in ide-probe.c.

> 
> -static __inline__ void ide_fix_driveid(struct hd_driveid *id)
> -{
> -#if defined(CONFIG_AMIGA) || defined (CONFIG_MAC) || defined(M68K_IDE_SWAPW)
> -   u_char *p = (u_char *)id;
> -   int i, j, cnt;
> -   u_char t;
> -
> -   if (!MACH_IS_AMIGA && !MACH_IS_MAC && !MACH_IS_Q40 && !MACH_IS_ATARI)
> -       return;
> -#ifdef M68K_IDE_SWAPW
> -   if (M68K_IDE_SWAPW)    /* fix bus byteorder first */
> -      for (i=0; i < 512; i+=2) {
> -        t = p[i]; p[i] = p[i+1]; p[i+1] = t;
> -      }
> -#endif
> 
> bye, Roman

