Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316079AbSFPKaS>; Sun, 16 Jun 2002 06:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316088AbSFPKaR>; Sun, 16 Jun 2002 06:30:17 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:42896 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S316079AbSFPKaQ>; Sun, 16 Jun 2002 06:30:16 -0400
Date: Sun, 16 Jun 2002 12:03:07 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Ricardo Galli <gallir@uib.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: 2.4.18 invalid operand: 0000
In-Reply-To: <E17JW2i-0000Gp-00@antoli.gallimedina.net>
Message-ID: <Pine.LNX.4.44.0206161200180.11143-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Jun 2002, Ricardo Galli wrote:

>  invalid operand: 0000
> CPU:    0
> EIP:    0010:[__free_pages_ok+40/500]    Tainted: P
> EFLAGS: 00010286
> eax: 00000000   ebx: c1834000   ecx: c149cd80   edx: d9c0a530
> esi: c149cd80   edi: 00000000   ebp: c149cd80   esp: c1835f2c
> ds: 0018   es: 0018   ss: 0018
> Process kswapd (pid: 4, stackpage=c1835000)
> Stack: c1834000 c149cd9c c1834000 c149cd80 000001d0 c1834000 c149cd9c c012cfb4
>        c012de17 c012cff9 00000020 000001d0 00000020 00000006 000001fb 000019d0
>        000001d0 c02d4ba8 0000001c c012d292 00000006 0000001a 00000006 000001d0
> Call Trace: [shrink_cache+584/1000] [__free_pages+27/28] [shrink_cache+653/1000] [shrink_caches+86/124] [try_to_free_pages+55/88]
>    [kswapd_balance_pgdat+67/140] [kswapd_balance+18/40] [kswapd+153/188] [kernel_thread+40/56]

Firstly the kernel is in an undefined state if it undergoes an oops (in 
most cases), secondly thats the nVidia module which caused that, i've seen 
it quite a number of times, easily reproduceable too. I don't encourage 
its use but if thats not the latest driver, try upgrading it.

Regards,
	Zwane Mwaikambo

-- 
http://function.linuxpower.ca
		

