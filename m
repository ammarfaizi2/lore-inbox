Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319268AbSHGTvg>; Wed, 7 Aug 2002 15:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319319AbSHGTvg>; Wed, 7 Aug 2002 15:51:36 -0400
Received: from smtp1.vol.cz ([195.250.128.73]:57861 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S319268AbSHGTve>;
	Wed, 7 Aug 2002 15:51:34 -0400
Message-ID: <3D517A19.2060608@illich.cz>
Date: Wed, 07 Aug 2002 21:50:49 +0200
From: Michal Illich <michal@illich.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a) Gecko/20020610
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 crash
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

output from ksymoops:

-------------------------------------------
ksymoops 2.4.4 on i686 2.4.19.  Options used
      -V (default)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.4.19/ (default)
      -m /boot/System.map-2.4.19 (default)

Warning: You did not tell me where to find symbol information. [...]

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Aug  7 09:47:16 [...] kernel: Unable to handle kernel paging request at 
virtual address 45ca6234
Aug  7 09:47:16 [...] kernel: c0128c80
Aug  7 09:47:16 [...] kernel: *pde = 00000000
Aug  7 09:47:16 [...] kernel: Oops: 0000
Aug  7 09:47:16 [...] kernel: CPU:    0
Aug  7 09:47:16 [...] kernel: EIP:    0010:[<c0128c80>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Aug  7 09:47:16 [...] kernel: EFLAGS: 00010813
Aug  7 09:47:16 [...] kernel: eax: 999f7887   ebx: c2217e50   ecx: df4c8000 
   edx: f762e680
Aug  7 09:47:16 [...] kernel: esi: 00000246   edi: cfbc4380   ebp: 000000f0 
   esp: ddff7de8
Aug  7 09:47:16 [...] kernel: ds: 0018   es: 0018   ss: 0018
Aug  7 09:47:16 [...] kernel: Process [...] (pid: 2133, stackpage=ddff7000)
Aug  7 09:47:16 [...] kernel: Stack: 00000000 ecb0109c 009bb6d0 e55216c0 
00000000 00000000 00001000 00000001
Aug  7 09:47:16 [...] kernel:        c0132804 c2217e50 000000f0 c01328b6 
00000001 df4c8940 04a87241 00000000
Aug  7 09:47:16 [...] kernel:        0000a324 c212b320 00000341 0000a325 
c212b320 c0132ae6 c212b320 00001000
Aug  7 09:47:16 [...] kernel: Call Trace:    [<c0132804>] [<c01328b6>] 
[<c0132ae6>] [<c0133158>] [<c01239ad>]
Aug  7 09:47:16 [...] kernel:   [<c0123a47>] [<c01534f0>] [<c0124035>] 
[<c0124288>] [<c0126408>] [<c01247fa>]
Warning (Oops_read): Code line not seen, dumping what data is available

 >>EIP; c0128c80 <kfree+30/a0>   <=====
Trace; c0132804 <block_read_full_page+c4/230>
Trace; c01328b6 <block_read_full_page+176/230>
Trace; c0132ae6 <cont_prepare_write+86/240>
Trace; c0133158 <generic_direct_IO+48/160>
Trace; c01239ad <___wait_on_page+2d/b0>
Trace; c0123a47 <unlock_page+17/70>
Trace; c01534f0 <ext3_block_truncate_page+100/360>
Trace; c0124035 <do_generic_file_read+b5/420>
Trace; c0124288 <do_generic_file_read+308/420>
Trace; c0126408 <remove_suid+58/59>
Trace; c01247fa <sys_sendfile+1a/200>

3 warnings issued.  Results may not be reliable.
-----------------------------------------------

both lsmod and ksyms produce no output, I think this is ok in case of lsmod, 
because everything is compiled in. I don't know if it is ok with ksyms; if 
you need it I can play little more with that...

[...] are my edits

