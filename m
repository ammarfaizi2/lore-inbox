Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318170AbSGWTBE>; Tue, 23 Jul 2002 15:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318172AbSGWTBE>; Tue, 23 Jul 2002 15:01:04 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:31627 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318170AbSGWTA6>; Tue, 23 Jul 2002 15:00:58 -0400
Subject: Re: [OOPS] 2.5.27 - __free_pages_ok()
From: Paul Larson <plars@austin.ibm.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Rik van Riel <riel@conectiva.com.br>, lkml <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org, haveblue@us.ibm.com
In-Reply-To: <20020723174942.GL919@holomorphy.com>
References: <Pine.LNX.4.44L.0207221704120.3086-100000@imladris.surriel.com>
	<1027377273.5170.37.camel@plars.austin.ibm.com>
	<20020722225251.GG919@holomorphy.com>
	<1027446044.7699.15.camel@plars.austin.ibm.com> 
	<20020723174942.GL919@holomorphy.com>
Content-Type: multipart/mixed; boundary="=-VvWKq+/h2OK/C1hRsztg"
X-Mailer: Ximian Evolution 1.0.5 
Date: 23 Jul 2002 14:02:09 -0500
Message-Id: <1027450930.7700.26.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-VvWKq+/h2OK/C1hRsztg
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2002-07-23 at 12:49, William Lee Irwin III wrote:
> Stands a good chance of being fixed by the recent rmap.c bugfix posted
> by Rik. I'm seeing deadlocks every other boot over here, the cause of
> which I've not yet been able to discover.
Still broken with the rmap patch posted today. Output attached.

-Paul Larson


--=-VvWKq+/h2OK/C1hRsztg
Content-Disposition: attachment; filename=c5.out
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=c5.out; charset=ISO-8859-1

ksymoops 2.4.5 on i686 2.4.18-mts.  Options used
     -V (default)
     -K (specified)
     -L (specified)
     -O (specified)
     -m linux-2.5.27/System.map (specified)

15488MB HIGHMEM available.
WARNING: MP table in the EBDA can be UNSAFE, contact linux-smp@vger.kernel.=
org if you experience SMP problems!
cpu: 0, clocks: 99990, slice: 3030
cpu: 6, clocks: 99990, slice: 3030
cpu: 5, clocks: 99990, slice: 3030
cpu: 7, clocks: 99990, slice: 3030
cpu: 1, clocks: 99990, slice: 3030
cpu: 2, clocks: 99990, slice: 3030
cpu: 3, clocks: 99990, slice: 3030
cpu: 4, clocks: 99990, slice: 3030
ds: no socket drivers loaded!
               Press 'I' to ekernel BUG at page_alloc.c:98!
CPU:    6
EIP:    0010:[<c01311b6>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 02010110   ebx: cbffd104   ecx: 00000000   edx: 00000000
esi: 00000120   edi: 00000000   ebp: cbffd104   esp: f7517c68
ds: 0018   es: 0018   ss: 0018
Stack: cbffd104 00000120 c03e10f8 f7512f00 c03e10e8 c01268ad 00000000 00000=
000=20
       c03e10e8 f7512f00 c03e10f8 cbffd104 c0130432 c0131b25 cbffd104 c0132=
3ee=20
       00000059 c0129789 cbffd104 f7512f00 00000000 c02d9d9c f7512f00 c0116=
185=20
Call Trace: [<c01268ad>] [<c0130432>] [<c0131b25>] [<c01323ee>] [<c0129789>=
]=20
   [<c0116185>] [<c0142393>] [<c0142557>] [<c0157f45>] [<c0157b04>] [<c012a=
c41>]=20
   [<c0142b2e>] [<c0142df7>] [<c0142e0e>] [<c0105af3>] [<c0106df3>]=20
Code: 0f 0b 62 00 f1 60 2d c0 89 f6 8b 45 14 a8 10 74 29 b8 04 00=20


>>EIP; c01311b6 <__free_pages_ok+86/308>   <=3D=3D=3D=3D=3D

>>eax; 02010110 Before first symbol
>>ebx; cbffd104 <END_OF_CODE+bbc4bc0/????>
>>ebp; cbffd104 <END_OF_CODE+bbc4bc0/????>
>>esp; f7517c68 <END_OF_CODE+370df724/????>

Trace; c01268ad <unmap_page_range+3d/5c>
Trace; c0130432 <lru_cache_del+e/16>
Trace; c0131b25 <page_cache_release+2d/30>
Trace; c01323ee <free_page_and_swap_cache+32/34>
Trace; c0129789 <exit_mmap+13d/1f8>
Trace; c0116185 <mmput+49/60>
Trace; c0142393 <exec_mmap+17b/1a4>
Trace; c0142557 <flush_old_exec+9f/2e0>
Trace; c0157f45 <load_elf_binary+441/ac0>
Trace; c0157b04 <load_elf_binary+0/ac0>
Trace; c012ac41 <file_read_actor+b5/e0>
Trace; c0142b2e <search_binary_handler+a2/1c8>
Trace; c0142df7 <do_execve+1a3/258>
Trace; c0142e0e <do_execve+1ba/258>
Trace; c0105af3 <sys_execve+2f/60>
Trace; c0106df3 <syscall_call+7/b>

Code;  c01311b6 <__free_pages_ok+86/308>
00000000 <_EIP>:
Code;  c01311b6 <__free_pages_ok+86/308>   <=3D=3D=3D=3D=3D
   0:   0f 0b                     ud2a      <=3D=3D=3D=3D=3D
Code;  c01311b8 <__free_pages_ok+88/308>
   2:   62 00                     bound  %eax,(%eax)
Code;  c01311ba <__free_pages_ok+8a/308>
   4:   f1                        (bad) =20
Code;  c01311bb <__free_pages_ok+8b/308>
   5:   60                        pusha =20
Code;  c01311bc <__free_pages_ok+8c/308>
   6:   2d c0 89 f6 8b            sub    $0x8bf689c0,%eax
Code;  c01311c1 <__free_pages_ok+91/308>
   b:   45                        inc    %ebp
Code;  c01311c2 <__free_pages_ok+92/308>
   c:   14 a8                     adc    $0xa8,%al
Code;  c01311c4 <__free_pages_ok+94/308>
   e:   10 74 29 b8               adc    %dh,0xffffffb8(%ecx,%ebp,1)
Code;  c01311c8 <__free_pages_ok+98/308>
  12:   04 00                     add    $0x0,%al

Configurikernel BUG at page_alloc.c:98!
CPU:    0
EIP:    0010:[<c01311b6>]    Not tainted
EFLAGS: 00010286
eax: 02010110   ebx: c393ab08   ecx: 00000000   edx: 00000000
esi: 0000007f   edi: 00000000   ebp: c393ab08   esp: f751bc68
ds: 0018   es: 0018   ss: 0018
Stack: c393ab08 0000007f c03de110 f750af20 c03de100 c01268ad 00000000 00000=
000=20
       c03de100 f750af20 c03de110 c393ab08 c0130432 c0131b25 c393ab08 c0132=
3ee=20
       00000007 c0129789 c393ab08 f750af20 00000000 c02d9d9c f750af20 c0116=
185=20
Call Trace: [<c01268ad>] [<c0130432>] [<c0131b25>] [<c01323ee>] [<c0129789>=
]=20
   [<c0116185>] [<c0142393Setting clock  (localtime): Tue Jul 23 13:55:02 C=
DT 2002 >] [<c0142557>] [<c0157f45>] [<c0157b04>] [<c012ac41>]=20
   [<c0142b2e>] [<c0142df7>] [<c0142e0e>] [<c0105af3>] [<c0106df3>]=20
Code: 0f 0b 62 00 f1 60 2d c0 89 f6 8b 45 14 a8 10 74 29 b8 04 00=20


>>EIP; c01311b6 <__free_pages_ok+86/308>   <=3D=3D=3D=3D=3D

>>eax; 02010110 Before first symbol
>>ebx; c393ab08 <END_OF_CODE+35025c4/????>
>>ebp; c393ab08 <END_OF_CODE+35025c4/????>
>>esp; f751bc68 <END_OF_CODE+370e3724/????>

Trace; c01268ad <unmap_page_range+3d/5c>
Trace; c0130432 <lru_cache_del+e/16>
Trace; c0131b25 <page_cache_release+2d/30>
Trace; c01323ee <free_page_and_swap_cache+32/34>
Trace; c0129789 <exit_mmap+13d/1f8>
Trace; c0116185 <mmput+49/60>
Trace; c0142b2e <search_binary_handler+a2/1c8>
Trace; c0142df7 <do_execve+1a3/258>
Trace; c0142e0e <do_execve+1ba/258>
Trace; c0105af3 <sys_execve+2f/60>
Trace; c0106df3 <syscall_call+7/b>

Code;  c01311b6 <__free_pages_ok+86/308>
00000000 <_EIP>:
Code;  c01311b6 <__free_pages_ok+86/308>   <=3D=3D=3D=3D=3D
   0:   0f 0b                     ud2a      <=3D=3D=3D=3D=3D
Code;  c01311b8 <__free_pages_ok+88/308>
   2:   62 00                     bound  %eax,(%eax)
Code;  c01311ba <__free_pages_ok+8a/308>
   4:   f1                        (bad) =20
Code;  c01311bb <__free_pages_ok+8b/308>
   5:   60                        pusha =20
Code;  c01311bc <__free_pages_ok+8c/308>
   6:   2d c0 89 f6 8b            sub    $0x8bf689c0,%eax
Code;  c01311c1 <__free_pages_ok+91/308>
   b:   45                        inc    %ebp
Code;  c01311c2 <__free_pages_ok+92/308>
   c:   14 a8                     adc    $0xa8,%al
Code;  c01311c4 <__free_pages_ok+94/308>
   e:   10 74 29 b8               adc    %dh,0xffffffb8(%ecx,%ebp,1)
Code;  c01311c8 <__free_pages_ok+98/308>
  12:   04 00                     add    $0x0,%al

kernel BUG at page_alloc.c:98!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01311b6>]    Not tainted
EFLAGS: 00010286
eax: 02010110   ebx: cbffa2f4   ecx: 00000000   edx: 00000000
esi: 0000009a   edi: 00000000   ebp: cbffa2f4   esp: f74d5f38
ds: 0018   es: 0018   ss: 0018
Stack: cbffa2f4 0000009a c03de110 f7512dc0 c03de100 c01268ad 00000000 4212e=
c44=20
       c03de100 f7512dc0 c03de110 cbffa2f4 c0130432 c0131b25 cbffa2f4 c0132=
3ee=20
       00000007 c0129789 cbffa2f4 f7512dc0 4212ec44 f79166e0 00000000 c0116=
185=20
Call Trace: [<c01268ad>] [<c0130432>] [<c0131b25>] [<c01323ee>] [<c0129789>=
]=20
   [<c0116185>] [<c011ae72>] [<c011b096>] [<c0106df3>]=20
Code: 0f 0b 62 00 f1 60 2d c0 89 f6 8b 45 14 a8 10 74 29 b8 04 00=20


>>EIP; c01311b6 <__free_pages_ok+86/308>   <=3D=3D=3D=3D=3D

>>eax; 02010110 Before first symbol
>>ebx; cbffa2f4 <END_OF_CODE+bbc1db0/????>
>>ebp; cbffa2f4 <END_OF_CODE+bbc1db0/????>
>>esp; f74d5f38 <END_OF_CODE+3709d9f4/????>

Trace; c01268ad <unmap_page_range+3d/5c>
Trace; c0130432 <lru_cache_del+e/16>
Trace; c0131b25 <page_cache_release+2d/30>
Trace; c01323ee <free_page_and_swap_cache+32/34>
Trace; c0129789 <exit_mmap+13d/1f8>
Trace; c0116185 <mmput+49/60>
Trace; c011ae72 <do_exit+c2/2c0>
Trace; c011b096 <sys_exit+e/10>
Trace; c0106df3 <syscall_call+7/b>

Code;  c01311b6 <__free_pages_ok+86/308>
00000000 <_EIP>:
Code;  c01311b6 <__free_pages_ok+86/308>   <=3D=3D=3D=3D=3D
   0:   0f 0b                     ud2a      <=3D=3D=3D=3D=3D
Code;  c01311b8 <__free_pages_ok+88/308>
   2:   62 00                     bound  %eax,(%eax)
Code;  c01311ba <__free_pages_ok+8a/308>
   4:   f1                        (bad) =20
Code;  c01311bb <__free_pages_ok+8b/308>
   5:   60                        pusha =20
Code;  c01311bc <__free_pages_ok+8c/308>
   6:   2d c0 89 f6 8b            sub    $0x8bf689c0,%eax
Code;  c01311c1 <__free_pages_ok+91/308>
   b:   45                        inc    %ebp
Code;  c01311c2 <__free_pages_ok+92/308>
   c:   14 a8                     adc    $0xa8,%al
Code;  c01311c4 <__free_pages_ok+94/308>
   e:   10 74 29 b8               adc    %dh,0xffffffb8(%ecx,%ebp,1)
Code;  c01311c8 <__free_pages_ok+98/308>
  12:   04 00                     add    $0x0,%al

kernel BUG at page_alloc.c:98!
invalid operand: 0000
CPU:    2
EIP:    0010:[<c01311b6>]    Not tainted
EFLAGS: 00010282
eax: 02010110   ebx: cbff9cf0   ecx: 00000000   edx: 00000000
esi: 0000008a   edi: 00000000   ebp: cbff9cf0   esp: f74d5c68
ds: 0018   es: 0018   ss: 0018
Stack: cbff9cf0 0000008a c03df108 f7955bc0 c03df0f8 c01268ad c035aca8 c19a0=
01c=20
       c035acc0 00000206 ffffffff cbff9cf0 c0130432 c0131b25 cbff9cf0 c0132=
3ee=20
       00000085 c0129789 cbff9cf0 f7955bc0 00000000 c02d9d9c f7955bc0 c0116=
185=20
Call Trace: [<c01268ad>] [<c0130432>] [<c0131b25>] [<c01323ee>] [<c0129789>=
]=20
   [<c0116185>] [<c0142393>] [<c0142557>] [<c0157f45>] [<c0157b04>] [<c0114=
435>]=20
   [<c012ac41>] [<c0142b2e>] [<c0142df7>] [<c0142e0e>] [<c0105af3>] [<c0106=
df3>]=20
Code: 0f 0b 62 00 f1 60 2d c0 89 f6 8b 45 14 a8 10 74 29 b8 04 00=20


>>EIP; c01311b6 <__free_pages_ok+86/308>   <=3D=3D=3D=3D=3D

>>eax; 02010110 Before first symbol
>>ebx; cbff9cf0 <END_OF_CODE+bbc17ac/????>
>>ebp; cbff9cf0 <END_OF_CODE+bbc17ac/????>
>>esp; f74d5c68 <END_OF_CODE+3709d724/????>

Trace; c01268ad <unmap_page_range+3d/5c>
Trace; c0130432 <lru_cache_del+e/16>
Trace; c0131b25 <page_cache_release+2d/30>
Trace; c01323ee <free_page_and_swap_cache+32/34>
Trace; c0129789 <exit_mmap+13d/1f8>
Trace; c0116185 <mmput+49/60>
Trace; c0142393 <exec_mmap+17b/1a4>
Trace; c0142557 <flush_old_exec+9f/2e0>
Trace; c0157f45 <load_elf_binary+441/ac0>
Trace; c0157b04 <load_elf_binary+0/ac0>
Trace; c0114435 <default_wake_function+1d/34>
Trace; c012ac41 <file_read_actor+b5/e0>
Trace; c0142b2e <search_binary_handler+a2/1c8>
Trace; c0142df7 <do_execve+1a3/258>
Trace; c0142e0e <do_execve+1ba/258>
Trace; c0105af3 <sys_execve+2f/60>
Trace; c0106df3 <syscall_call+7/b>

Code;  c01311b6 <__free_pages_ok+86/308>
00000000 <_EIP>:
Code;  c01311b6 <__free_pages_ok+86/308>   <=3D=3D=3D=3D=3D
   0:   0f 0b                     ud2a      <=3D=3D=3D=3D=3D
Code;  c01311b8 <__free_pages_ok+88/308>
   2:   62 00                     bound  %eax,(%eax)
Code;  c01311ba <__free_pages_ok+8a/308>
   4:   f1                        (bad) =20
Code;  c01311bb <__free_pages_ok+8b/308>
   5:   60                        pusha =20
Code;  c01311bc <__free_pages_ok+8c/308>
   6:   2d c0 89 f6 8b            sub    $0x8bf689c0,%eax
Code;  c01311c1 <__free_pages_ok+91/308>
   b:   45                        inc    %ebp
Code;  c01311c2 <__free_pages_ok+92/308>
   c:   14 a8                     adc    $0xa8,%al
Code;  c01311c4 <__free_pages_ok+94/308>
   e:   10 74 29 b8               adc    %dh,0xffffffb8(%ecx,%ebp,1)
Code;  c01311c8 <__free_pages_ok+98/308>
  12:   04 00                     add    $0x0,%al

 kernel BUG at page_alloc.c:98!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01311b6>]    Not tainted
EFLAGS: 00010282
eax: 02010110   ebx: cbfe3e24   ecx: 00000000   edx: 00000000
esi: 00000128   edi: 00000000   ebp: cbfe3e24   esp: f74cff38
ds: 0018   es: 0018   ss: 0018
Stack: cbfe3e24 00000128 c03de110 f7512c80 c03de100 c01268ad 00000000 4212e=
c44=20
       c03de100 f7512c80 c03de110 cbfe3e24 c0130432 c0131b25 cbfe3e24 c0132=
3ee=20
       0000005b c0129789 cbfe3e24 f7512c80 4212ec44 f79166e0 00000100 c0116=
185=20
Call Trace: [<c01268ad>] [<c0130432>] [<c0131b25>] [<c01323ee>] [<c0129789>=
]=20
   [<c0116185>] [<c011ae72>] [<c011b096>] [<c0106df3>]=20
Code: 0f 0b 62 00 f1 60 2d c0 89 f6 8b 45 14 a8 10 74 29 b8 04 00=20


>>EIP; c01311b6 <__free_pages_ok+86/308>   <=3D=3D=3D=3D=3D

>>eax; 02010110 Before first symbol
>>ebx; cbfe3e24 <END_OF_CODE+bbab8e0/????>
>>ebp; cbfe3e24 <END_OF_CODE+bbab8e0/????>
>>esp; f74cff38 <END_OF_CODE+370979f4/????>

Trace; c01268ad <unmap_page_range+3d/5c>
Trace; c0130432 <lru_cache_del+e/16>
Trace; c0131b25 <page_cache_release+2d/30>
Trace; c01323ee <free_page_and_swap_cache+32/34>
Trace; c0129789 <exit_mmap+13d/1f8>
Trace; c0116185 <mmput+49/60>
Trace; c011ae72 <do_exit+c2/2c0>
Trace; c011b096 <sys_exit+e/10>
Trace; c0106df3 <syscall_call+7/b>

Code;  c01311b6 <__free_pages_ok+86/308>
00000000 <_EIP>:
Code;  c01311b6 <__free_pages_ok+86/308>   <=3D=3D=3D=3D=3D
   0:   0f 0b                     ud2a      <=3D=3D=3D=3D=3D
Code;  c01311b8 <__free_pages_ok+88/308>
   2:   62 00                     bound  %eax,(%eax)
Code;  c01311ba <__free_pages_ok+8a/308>
   4:   f1                        (bad) =20
Code;  c01311bb <__free_pages_ok+8b/308>
   5:   60                        pusha =20
Code;  c01311bc <__free_pages_ok+8c/308>
   6:   2d c0 89 f6 8b            sub    $0x8bf689c0,%eax
Code;  c01311c1 <__free_pages_ok+91/308>
   b:   45                        inc    %ebp
Code;  c01311c2 <__free_pages_ok+92/308>
   c:   14 a8                     adc    $0xa8,%al
Code;  c01311c4 <__free_pages_ok+94/308>
   e:   10 74 29 b8               adc    %dh,0xffffffb8(%ecx,%ebp,1)
Code;  c01311c8 <__free_pages_ok+98/308>
  12:   04 00                     add    $0x0,%al

 kernel BUG at page_alloc.c:98!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01311b6>]    Not tainted
EFLAGS: 00010282
eax: 02010110   ebx: cbfe3b64   ecx: 00000000   edx: 00000000
esi: 00000128   edi: 00000000   ebp: cbfe3b64   esp: f74abc68
ds: 0018   es: 0018   ss: 0018
Stack: cbfe3b64 00000128 c03de110 f7512d20 c03de100 c01268ad 00000000 00000=
000=20
       c03de100 f7512d20 c03de110 cbfe3b64 c0130432 c0131b25 cbfe3b64 c0132=
3ee=20
       0000005b c0129789 cbfe3b64 f7512d20 00000000 c02d9d9c f7512d20 c0116=
185=20
Call Trace: [<c01268ad>] [<c0130432>] [<c0131b25>] [<c01323ee>] [<c0129789>=
]=20
   [<c0116185>] [<c0142393>] [<c0142557>] [<c0157f45>] [<c0157b04>] [<c012a=
c41>]=20
   [<c0142b2e>] [<c0142df7>] [<c0142e0e>] [<c0105af3>] [<c0106df3>]=20
Code: 0f 0b 62 00 f1 60 2d c0 89 f6 8b 45 14 a8 10 74 29 b8 04 00=20


>>EIP; c01311b6 <__free_pages_ok+86/308>   <=3D=3D=3D=3D=3D

>>eax; 02010110 Before first symbol
>>ebx; cbfe3b64 <END_OF_CODE+bbab620/????>
>>ebp; cbfe3b64 <END_OF_CODE+bbab620/????>
>>esp; f74abc68 <END_OF_CODE+37073724/????>

Trace; c01268ad <unmap_page_range+3d/5c>
Trace; c0130432 <lru_cache_del+e/16>
Trace; c0131b25 <page_cache_release+2d/30>
Trace; c01323ee <free_page_and_swap_cache+32/34>
Trace; c0129789 <exit_mmap+13d/1f8>
Trace; c0116185 <mmput+49/60>
Trace; c0142393 <exec_mmap+17b/1a4>
Trace; c0142557 <flush_old_exec+9f/2e0>
Trace; c0157f45 <load_elf_binary+441/ac0>
Trace; c0157b04 <load_elf_binary+0/ac0>
Trace; c012ac41 <file_read_actor+b5/e0>
Trace; c0142b2e <search_binary_handler+a2/1c8>
Trace; c0142df7 <do_execve+1a3/258>
Trace; c0142e0e <do_execve+1ba/258>
Trace; c0105af3 <sys_execve+2f/60>
Trace; c0106df3 <syscall_call+7/b>

Code;  c01311b6 <__free_pages_ok+86/308>
00000000 <_EIP>:
Code;  c01311b6 <__free_pages_ok+86/308>   <=3D=3D=3D=3D=3D
   0:   0f 0b                     ud2a      <=3D=3D=3D=3D=3D
Code;  c01311b8 <__free_pages_ok+88/308>
   2:   62 00                     bound  %eax,(%eax)
Code;  c01311ba <__free_pages_ok+8a/308>
   4:   f1                        (bad) =20
Code;  c01311bb <__free_pages_ok+8b/308>
   5:   60                        pusha =20
Code;  c01311bc <__free_pages_ok+8c/308>
   6:   2d c0 89 f6 8b            sub    $0x8bf689c0,%eax
Code;  c01311c1 <__free_pages_ok+91/308>
   b:   45                        inc    %ebp
Code;  c01311c2 <__free_pages_ok+92/308>
   c:   14 a8                     adc    $0xa8,%al
Code;  c01311c4 <__free_pages_ok+94/308>
   e:   10 74 29 b8               adc    %dh,0xffffffb8(%ecx,%ebp,1)
Code;  c01311c8 <__free_pages_ok+98/308>
  12:   04 00                     add    $0x0,%al

 kernel BUG at page_alloc.c:98!
invalid operand: 0000
CPU:    6
EIP:    0010:[<c01311b6>]    Not tainted
EFLAGS: 00010286
eax: 02010110   ebx: cbfe4194   ecx: 00000000   edx: 00000000
esi: 00000128   edi: 00000000   ebp: cbfe4194   esp: f74cff38
ds: 0018   es: 0018   ss: 0018
Stack: cbfe4194 00000128 c03e10f8 f7512b40 00000010 00000293 c035aca8 c19a0=
01c=20
       c035acc0 00000207 ffffffff cbfe4194 c0130432 c0131b25 cbfe4194 c0132=
3ee=20
       0000005d c0129789 cbfe4194 f7512b40 4212ec44 f79166e0 00008b00 c0116=
185=20
Call Trace: [<c0130432>] [<c0131b25>] [<c01323ee>] [<c0129789>] [<c0116185>=
]=20
   [<c011ae72>] [<c011b096>] [<c0106df3>]=20
Code: 0f 0b 62 00 f1 60 2d c0 89 f6 8b 45 14 a8 10 74 29 b8 04 00=20


>>EIP; c01311b6 <__free_pages_ok+86/308>   <=3D=3D=3D=3D=3D

>>eax; 02010110 Before first symbol
>>ebx; cbfe4194 <END_OF_CODE+bbabc50/????>
>>ebp; cbfe4194 <END_OF_CODE+bbabc50/????>
>>esp; f74cff38 <END_OF_CODE+370979f4/????>

Trace; c0130432 <lru_cache_del+e/16>
Trace; c0131b25 <page_cache_release+2d/30>
Trace; c01323ee <free_page_and_swap_cache+32/34>
Trace; c0129789 <exit_mmap+13d/1f8>
Trace; c0116185 <mmput+49/60>
Trace; c011ae72 <do_exit+c2/2c0>
Trace; c011b096 <sys_exit+e/10>
Trace; c0106df3 <syscall_call+7/b>

Code;  c01311b6 <__free_pages_ok+86/308>
00000000 <_EIP>:
Code;  c01311b6 <__free_pages_ok+86/308>   <=3D=3D=3D=3D=3D
   0:   0f 0b                     ud2a      <=3D=3D=3D=3D=3D
Code;  c01311b8 <__free_pages_ok+88/308>
   2:   62 00                     bound  %eax,(%eax)
Code;  c01311ba <__free_pages_ok+8a/308>
   4:   f1                        (bad) =20
Code;  c01311bb <__free_pages_ok+8b/308>
   5:   60                        pusha =20
Code;  c01311bc <__free_pages_ok+8c/308>
   6:   2d c0 89 f6 8b            sub    $0x8bf689c0,%eax
Code;  c01311c1 <__free_pages_ok+91/308>
   b:   45                        inc    %ebp
Code;  c01311c2 <__free_pages_ok+92/308>
   c:   14 a8                     adc    $0xa8,%al
Code;  c01311c4 <__free_pages_ok+94/308>
   e:   10 74 29 b8               adc    %dh,0xffffffb8(%ecx,%ebp,1)
Code;  c01311c8 <__free_pages_ok+98/308>
  12:   04 00                     add    $0x0,%al

 kernel BUG at page_alloc.c:98!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01311b6>]    Not tainted
EFLAGS: 00010282
eax: 02010110   ebx: cbfe2c9c   ecx: 00000000   edx: 00000000
esi: 00000128   edi: 00000000   ebp: cbfe2c9c   esp: f74a1c68
ds: 0018   es: 0018   ss: 0018
Stack: cbfe2c9c 00000128 c03de110 f7512aa0 c03de100 c01268ad 00000000 00000=
000=20
       c03de100 f7512aa0 c03d
Warning (Oops_read): Code line not seen, dumping what data is available


>>EIP; c01311b6 <__free_pages_ok+86/308>   <=3D=3D=3D=3D=3D

>>eax; 02010110 Before first symbol
>>ebx; cbfe2c9c <END_OF_CODE+bbaa758/????>
>>ebp; cbfe2c9c <END_OF_CODE+bbaa758/????>
>>esp; f74a1c68 <END_OF_CODE+37069724/????>


1 warning issued.  Results may not be reliable.

--=-VvWKq+/h2OK/C1hRsztg--

