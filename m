Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290069AbSAQRKo>; Thu, 17 Jan 2002 12:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290070AbSAQRKe>; Thu, 17 Jan 2002 12:10:34 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:40965 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290069AbSAQRKY>; Thu, 17 Jan 2002 12:10:24 -0500
Message-ID: <3C47055C.3010103@zytor.com>
Date: Thu, 17 Jan 2002 09:09:48 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: vda@port.imtp.ilyichevsk.odessa.ua
CC: linux-kernel@vger.kernel.org
Subject: Re: [ANNC] Linld 0.94 available
In-Reply-To: <200201171432.g0HEW4E17589@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:

> 
> Ok, I brought old Turbo Debugger from home...
> 
> It is not true on this box I type this message right now. 128 MB RAM.
> Under DOS:
> INT 15 AX=E801 returns carry set and AH=86 (have no BIOS manual here to look 
> up this error code), other registers unchanged.


AH=86 is function not supported.

However, once again, you're running UNDER DOS.  You probably should 
query HIMEM.SYS for the memory size,


> INT 15 AH=88 returns AX=0.
> INT 15 AX=E820 - not tested, but obviously not working (or else kernels would 
> boot fine without linld/loadlin kludge or kernel patch)
> 
> So we have "triple-0" failure extracting mem size info from INT 15.


... because you're running under DOS.

> 
> Just imagine old lovely 486 box never tested by manufacturer to work well 
> with 64 MB of RAM. Joe Random Hacker plays Meg-o-Rama, but BIOS does not 
> understand how that can be: int 15 fn 88 does not fit in 16-bit reg?!
> DOS does not boot, Joe says: well, Linux rulez, it will boot! but no...
> 
> OTOH, CMOS reading hack most probably would not work either... memscan time?
> 


By the time 64 MB RAM became supported, INT 15 AX=E801 was already 
common.  For pathological cases like you describe, it's "mem=" time.

	-hpa


