Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263124AbREaR7t>; Thu, 31 May 2001 13:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263130AbREaR7j>; Thu, 31 May 2001 13:59:39 -0400
Received: from mandy.drsys.net ([64.40.111.212]:20234 "HELO mandy.drsys.net")
	by vger.kernel.org with SMTP id <S263124AbREaR7U>;
	Thu, 31 May 2001 13:59:20 -0400
Date: Thu, 31 May 2001 10:59:17 -0700
From: David Raufeisen <david@fortyoz.org>
To: rui.sousa@mindspeed.com
Cc: linux-kernel@vger.kernel.org, emu10k1-devel@opensource.creative.com
Subject: Re:  how to crash 2.4.4 w/SBLive
Message-ID: <20010531105917.A10655@fortyoz.org>
Reply-To: David Raufeisen <david@fortyoz.org>
In-Reply-To: <Pine.LNX.4.33.0105311157430.17958-200000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0105311157430.17958-200000@localhost.localdomain>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I used this patch on 2.4.5, still oops's ..

Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(shmem_file_setup) not found in System.map.  Ignoring ksyms_base entry
Code: 0f b7 a8 84 40 00 00 8d 7d 04 89 54 24 18 8d b4 26 00 00 00 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f b7 a8 84 40 00 00      movzwl 0x4084(%eax),%ebp
Code;  00000007 Before first symbol
   7:   8d 7d 04                  lea    0x4(%ebp),%edi
Code;  0000000a Before first symbol
   a:   89 54 24 18               mov    %edx,0x18(%esp,1)
Code;  0000000e Before first symbol
   e:   8d b4 26 00 00 00 00      lea    0x0(%esi,1),%esi

Unable to handle kernel paging request at virtual address 3320b9e5
c01b91eb
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01b91eb>]
EFLAGS: 00210002
eax: 33207961   ebx: 00000000   ecx: c1250000   edx: 00000020
esi: c2879f0c   edi: 33207961   ebp: 33207991   esp: c2879edc
ds: 0018   es: 0018   ss: 0018
Process cat (pid: 1550, stackpage=c2879000)
Stack: 00000000 c287e804 33207961 33207991 c02614f8 00000012 c02614d4 00200082 
       c01bc853 33207961 00000020 00000012 00000000 00000003 0000ffff 10100001 
       00000000 00000002 0000ffff 00000000 00000000 00000000 c287e800 c1250000 
Call Trace: [<c01bc853>] [<c01b86c4>] [<c01b8666>] [<c01b4f4f>] [<c012cf46>] [<c0106bab>] 
Warning (Oops_read): Code line not seen, dumping what data is available

>>EIP; c01b91eb <sblive_writeptr_tag+2b/c0>   <=====
Trace; c01bc853 <emu10k1_voice_free+43/80>
Trace; c01b86c4 <emu10k1_waveout_close+24/40>
Trace; c01b8666 <emu10k1_waveout_open+66/a0>
Trace; c01b4f4f <emu10k1_audio_write+cf/1d0>
Trace; c012cf46 <sys_write+96/d0>
Trace; c0106bab <system_call+33/38>


3 warnings issued.  Results may not be reliable.

On Thursday, 31 May 2001, at 12:01:05 (+0200),
rui.sousa@mindspeed.com wrote:

> 
> Thank you for the trace. Patch attached, please test it out.
> 
> Rui Sousa
> 
> P.S: in the future always CC emu10k1-devel, or instead of a 7 day delay in
> getting something fixed the message might just get lost.
> 

-- 
David Raufeisen <david@fortyoz.org>
Cell: (604) 818-3596
