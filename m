Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316235AbSGSNMf>; Fri, 19 Jul 2002 09:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316289AbSGSNMf>; Fri, 19 Jul 2002 09:12:35 -0400
Received: from dracula.gtri.gatech.edu ([130.207.193.70]:56706 "EHLO
	shaft.shaftnet.org") by vger.kernel.org with ESMTP
	id <S316235AbSGSNMb>; Fri, 19 Jul 2002 09:12:31 -0400
Date: Fri, 19 Jul 2002 09:14:27 -0400
From: Stuffed Crust <pizza@shaftnet.org>
To: linux-kernel@vger.kernel.org
Subject: VM oops with 2.4.19rc1aa1
Message-ID: <20020719131427.GA23103@shaftnet.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This box has been up for about 12 days, running a relatively light load,
with postgresql 7.2.1 on top of ext3, which is in turn running on a
3Ware RAID controller.  It's a P3-1G, with 512M RAM and a gig of swap.
CONFIG_2GB is set.  I can provide the .config and dmesg output if
necessary.

Postgresql mysteriously crashed last night, and five oopsen showed up in
the dmesg output.  I shoved 'em through ksymoops and dropped 'em here.

I'm going to be rebooting this box with rc2aa1 tonight; perhaps that
will be an improvement.

If you'd please CC me on replies..=20

ksymoops 2.4.4 on i686 2.4.19-rc1aa1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-rc1aa1/ (default)
     -m /boot/System.map-2.4.19-rc1aa1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request at virtual address 60000809
80126bb7
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<80126bb7>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 60000801   ebx: 00000000   ecx: 8023c8e0   edx: 0001c500
esi: 00000005   edi: 200ab738   ebp: 0001c500   esp: 81bc1e48
ds: 0018   es: 0018   ss: 0018
Process postmaster (pid: 28721, stackpage=3D81bc1000)
Stack: 8012ee1b 8023c8e0 0001c500 9feb1cf4 00000000 00000005 00000008 83896=
080=20
       8012427d 0001c500 000001c5 081c1fdc 00000000 0001c700 801242bd 0001c=
700=20
       00000001 9ee213e0 80124525 96a64320 080c0000 83896080 081c1fdc 8c046=
260=20
Call Trace: [<8012ee1b>] [<8012427d>] [<801242bd>] [<80124525>] [<801246d8>=
]=20
   [<80124ba4>] [<80112c00>] [<801251a0>] [<8010ce1f>] [<80124a97>] [<80112=
a40>]    [<80108894>]=20
Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d b4=20

>>EIP; 80126bb7 <__find_get_page+17/30>   <=3D=3D=3D=3D=3D
Trace; 8012ee1b <read_swap_cache_async+4b/b0>
Trace; 8012427d <swapin_readahead+3d/50>
Trace; 801242bd <do_swap_page+2d/140>
Trace; 80124525 <do_no_page+55/190>
Trace; 801246d8 <handle_mm_fault+78/e0>
Trace; 80124ba4 <__vma_link+64/c0>
Trace; 80112c00 <do_page_fault+1c0/5a0>
Trace; 801251a0 <do_mmap_pgoff+4b0/570>
Trace; 8010ce1f <sys_mmap2+6f/b0>
Trace; 80124a97 <sys_brk+d7/110>
Trace; 80112a40 <do_page_fault+0/5a0>
Trace; 80108894 <error_code+34/3c>
Code;  80126bb7 <__find_get_page+17/30>
00000000 <_EIP>:
Code;  80126bb7 <__find_get_page+17/30>   <=3D=3D=3D=3D=3D
   0:   39 48 08                  cmp    %ecx,0x8(%eax)   <=3D=3D=3D=3D=3D
Code;  80126bba <__find_get_page+1a/30>
   3:   75 f4                     jne    fffffff9 <_EIP+0xfffffff9> 80126bb=
0 <__find_get_page+10/30>
Code;  80126bbc <__find_get_page+1c/30>
   5:   39 50 0c                  cmp    %edx,0xc(%eax)
Code;  80126bbf <__find_get_page+1f/30>
   8:   75 ef                     jne    fffffff9 <_EIP+0xfffffff9> 80126bb=
0 <__find_get_page+10/30>
Code;  80126bc1 <__find_get_page+21/30>
   a:   85 c0                     test   %eax,%eax
Code;  80126bc3 <__find_get_page+23/30>
   c:   74 03                     je     11 <_EIP+0x11> 80126bc8 <__find_ge=
t_page+28/30>
Code;  80126bc5 <__find_get_page+25/30>
   e:   ff 40 14                  incl   0x14(%eax)
Code;  80126bc8 <__find_get_page+28/30>
  11:   c3                        ret   =20
Code;  80126bc9 <__find_get_page+29/30>
  12:   8d b4 00 00 00 00 00      lea    0x0(%eax,%eax,1),%esi

 <1>Unable to handle kernel paging request at virtual address 60000809
80126bb7
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<80126bb7>]    Not tainted
EFLAGS: 00010202
eax: 60000801   ebx: 00000000   ecx: 8023c8e0   edx: 0001c500
esi: 00000005   edi: 200ab738   ebp: 0001c500   esp: 9d69be48
ds: 0018   es: 0018   ss: 0018
Process postmaster (pid: 26994, stackpage=3D9d69b000)
Stack: 8012ee1b 8023c8e0 0001c500 9feb1cf4 00000000 00000005 00000008 9a997=
080=20
       8012427d 0001c500 000001c5 081c1fd0 00000000 0001c700 801242bd 0001c=
700=20
       00000001 9fe13ba0 80124525 83c31200 081a3000 9a997080 081c1fd0 83c31=
440=20
Call Trace: [<8012ee1b>] [<8012427d>] [<801242bd>] [<80124525>] [<801246d8>=
]=20
   [<8013d23e>] [<80112c00>] [<8013c850>] [<8013dcd4>] [<801acae7>] [<80133=
6b6>]=20
   [<8013c65a>] [<80112a40>] [<80108894>]=20
Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d b4=20

>>EIP; 80126bb7 <__find_get_page+17/30>   <=3D=3D=3D=3D=3D
Trace; 8012ee1b <read_swap_cache_async+4b/b0>
Trace; 8012427d <swapin_readahead+3d/50>
Trace; 801242bd <do_swap_page+2d/140>
Trace; 80124525 <do_no_page+55/190>
Trace; 801246d8 <handle_mm_fault+78/e0>
Trace; 8013d23e <link_path_walk+7be/8d0>
Trace; 80112c00 <do_page_fault+1c0/5a0>
Trace; 8013c850 <path_release+10/30>
Trace; 8013dcd4 <open_namei+4e4/5e0>
Trace; 801acae7 <scsi_finish_command+97/a0>
Trace; 801336b6 <filp_open+36/60>
Trace; 8013c65a <getname+5a/a0>
Trace; 80112a40 <do_page_fault+0/5a0>
Trace; 80108894 <error_code+34/3c>
Code;  80126bb7 <__find_get_page+17/30>
00000000 <_EIP>:
Code;  80126bb7 <__find_get_page+17/30>   <=3D=3D=3D=3D=3D
   0:   39 48 08                  cmp    %ecx,0x8(%eax)   <=3D=3D=3D=3D=3D
Code;  80126bba <__find_get_page+1a/30>
   3:   75 f4                     jne    fffffff9 <_EIP+0xfffffff9> 80126bb=
0 <__find_get_page+10/30>
Code;  80126bbc <__find_get_page+1c/30>
   5:   39 50 0c                  cmp    %edx,0xc(%eax)
Code;  80126bbf <__find_get_page+1f/30>
   8:   75 ef                     jne    fffffff9 <_EIP+0xfffffff9> 80126bb=
0 <__find_get_page+10/30>
Code;  80126bc1 <__find_get_page+21/30>
   a:   85 c0                     test   %eax,%eax
Code;  80126bc3 <__find_get_page+23/30>
   c:   74 03                     je     11 <_EIP+0x11> 80126bc8 <__find_ge=
t_page+28/30>
Code;  80126bc5 <__find_get_page+25/30>
   e:   ff 40 14                  incl   0x14(%eax)
Code;  80126bc8 <__find_get_page+28/30>
  11:   c3                        ret   =20
Code;  80126bc9 <__find_get_page+29/30>
  12:   8d b4 00 00 00 00 00      lea    0x0(%eax,%eax,1),%esi

 <1>Unable to handle kernel paging request at virtual address 60000809
80126bb7
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<80126bb7>]    Not tainted
EFLAGS: 00010202
eax: 60000801   ebx: 00000000   ecx: 8023c8e0   edx: 0001c500
esi: 00000005   edi: 200ab738   ebp: 0001c500   esp: 84d61e48
ds: 0018   es: 0018   ss: 0018
Process postmaster (pid: 26996, stackpage=3D84d61000)
Stack: 8012ee1b 8023c8e0 0001c500 9feb1cf4 00000000 00000005 00000008 90f19=
080=20
       8012427d 0001c500 000001c5 081c084c 00000000 0001c600 801242bd 0001c=
600=20
       00000001 9fe13420 80124525 90df5bc0 0816e000 90f19080 081c084c 90df5=
140=20
Call Trace: [<8012ee1b>] [<8012427d>] [<801242bd>] [<80124525>] [<801246d8>=
]=20
   [<80113b48>] [<80112c00>] [<80141892>] [<80112a40>] [<80108894>]=20
Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d b4=20

>>EIP; 80126bb7 <__find_get_page+17/30>   <=3D=3D=3D=3D=3D
Trace; 8012ee1b <read_swap_cache_async+4b/b0>
Trace; 8012427d <swapin_readahead+3d/50>
Trace; 801242bd <do_swap_page+2d/140>
Trace; 80124525 <do_no_page+55/190>
Trace; 801246d8 <handle_mm_fault+78/e0>
Trace; 80113b48 <schedule+1e8/210>
Trace; 80112c00 <do_page_fault+1c0/5a0>
Trace; 80141892 <sys_select+472/480>
Trace; 80112a40 <do_page_fault+0/5a0>
Trace; 80108894 <error_code+34/3c>
Code;  80126bb7 <__find_get_page+17/30>
00000000 <_EIP>:
Code;  80126bb7 <__find_get_page+17/30>   <=3D=3D=3D=3D=3D
   0:   39 48 08                  cmp    %ecx,0x8(%eax)   <=3D=3D=3D=3D=3D
Code;  80126bba <__find_get_page+1a/30>
   3:   75 f4                     jne    fffffff9 <_EIP+0xfffffff9> 80126bb=
0 <__find_get_page+10/30>
Code;  80126bbc <__find_get_page+1c/30>
   5:   39 50 0c                  cmp    %edx,0xc(%eax)
Code;  80126bbf <__find_get_page+1f/30>
   8:   75 ef                     jne    fffffff9 <_EIP+0xfffffff9> 80126bb=
0 <__find_get_page+10/30>
Code;  80126bc1 <__find_get_page+21/30>
   a:   85 c0                     test   %eax,%eax
Code;  80126bc3 <__find_get_page+23/30>
   c:   74 03                     je     11 <_EIP+0x11> 80126bc8 <__find_ge=
t_page+28/30>
Code;  80126bc5 <__find_get_page+25/30>
   e:   ff 40 14                  incl   0x14(%eax)
Code;  80126bc8 <__find_get_page+28/30>
  11:   c3                        ret   =20
Code;  80126bc9 <__find_get_page+29/30>
  12:   8d b4 00 00 00 00 00      lea    0x0(%eax,%eax,1),%esi

 <1>Unable to handle kernel paging request at virtual address 60000809
80126c08
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<80126c08>]    Not tainted
EFLAGS: 00010202
eax: 60000801   ebx: 0001c500   ecx: 00000011   edx: 0000c73d
esi: 8023c8e0   edi: 80297760   ebp: 83f81ff0   esp: 84d61c50
ds: 0018   es: 0018   ss: 0018
Process postmaster (pid: 26996, stackpage=3D84d61000)
Stack: 0001c500 00000000 8012f3e2 8023c8e0 0001c500 0001c500 00001000 00005=
000=20
       801234e6 0001c500 00000000 00000000 80000000 90f197fc 7fffb000 00000=
000=20
       80000000 90f197fc 802a96b4 060cf2ab 80185b16 00000001 20000000 80241=
440=20
Call Trace: [<8012f3e2>] [<801234e6>] [<80185b16>] [<80125d68>] [<801168cb>=
]=20
   [<80115089>] [<80119399>] [<80112a2d>] [<80108d5d>] [<80126bb7>] [<80126=
bb7>]=20
   [<80112e37>] [<8018f11e>] [<801b9c3b>] [<801ac2af>] [<801b2f7c>] [<80112=
a40>]=20
   [<80108894>] [<80126bb7>] [<8012ee1b>] [<8012427d>] [<801242bd>] [<80124=
525>]=20
   [<801246d8>] [<80113b48>] [<80112c00>] [<80141892>] [<80112a40>] [<80108=
894>]=20
Code: 39 70 08 75 f4 39 58 0c 75 ef 89 c1 85 c9 74 0d 31 c0 0f ab=20

>>EIP; 80126c08 <find_trylock_page+38/60>   <=3D=3D=3D=3D=3D
Trace; 8012f3e2 <free_swap_and_cache+32/70>
Trace; 801234e6 <zap_page_range+1a6/260>
Trace; 80185b16 <vt_console_print+2a6/2c0>
Trace; 80125d68 <exit_mmap+b8/120>
Trace; 801168cb <call_console_drivers+eb/100>
Trace; 80115089 <mmput+39/60>
Trace; 80119399 <do_exit+a9/240>
Trace; 80112a2d <bust_spinlocks+3d/50>
Trace; 80108d5d <die+4d/70>
Trace; 80126bb7 <__find_get_page+17/30>
Trace; 80126bb7 <__find_get_page+17/30>
Trace; 80112e37 <do_page_fault+3f7/5a0>
Trace; 8018f11e <generic_make_request+10e/130>
Trace; 801b9c3b <tw_scsi_queue+fb/1e0>
Trace; 801ac2af <scsi_dispatch_cmd+11f/210>
Trace; 801b2f7c <scsi_request_fn+31c/360>
Trace; 80112a40 <do_page_fault+0/5a0>
Trace; 80108894 <error_code+34/3c>
Trace; 80126bb7 <__find_get_page+17/30>
Trace; 8012ee1b <read_swap_cache_async+4b/b0>
Trace; 8012427d <swapin_readahead+3d/50>
Trace; 801242bd <do_swap_page+2d/140>
Trace; 80124525 <do_no_page+55/190>
Trace; 801246d8 <handle_mm_fault+78/e0>
Trace; 80113b48 <schedule+1e8/210>
Trace; 80112c00 <do_page_fault+1c0/5a0>
Trace; 80141892 <sys_select+472/480>
Trace; 80112a40 <do_page_fault+0/5a0>
Trace; 80108894 <error_code+34/3c>
Code;  80126c08 <find_trylock_page+38/60>
00000000 <_EIP>:
Code;  80126c08 <find_trylock_page+38/60>   <=3D=3D=3D=3D=3D
   0:   39 70 08                  cmp    %esi,0x8(%eax)   <=3D=3D=3D=3D=3D
Code;  80126c0b <find_trylock_page+3b/60>
   3:   75 f4                     jne    fffffff9 <_EIP+0xfffffff9> 80126c0=
1 <find_trylock_page+31/60>
Code;  80126c0d <find_trylock_page+3d/60>
   5:   39 58 0c                  cmp    %ebx,0xc(%eax)
Code;  80126c10 <find_trylock_page+40/60>
   8:   75 ef                     jne    fffffff9 <_EIP+0xfffffff9> 80126c0=
1 <find_trylock_page+31/60>
Code;  80126c12 <find_trylock_page+42/60>
   a:   89 c1                     mov    %eax,%ecx
Code;  80126c14 <find_trylock_page+44/60>
   c:   85 c9                     test   %ecx,%ecx
Code;  80126c16 <find_trylock_page+46/60>
   e:   74 0d                     je     1d <_EIP+0x1d> 80126c25 <find_tryl=
ock_page+55/60>
Code;  80126c18 <find_trylock_page+48/60>
  10:   31 c0                     xor    %eax,%eax
Code;  80126c1a <find_trylock_page+4a/60>
  12:   0f ab 00                  bts    %eax,(%eax)

 <1>Unable to handle kernel paging request at virtual address 60000809
80126bb7
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<80126bb7>]    Not tainted
EFLAGS: 00010202
eax: 60000801   ebx: 00000000   ecx: 8023c8e0   edx: 0001c500
esi: 00000005   edi: 200ab738   ebp: 0001c500   esp: 83ecfe48
ds: 0018   es: 0018   ss: 0018
Process postmaster (pid: 26997, stackpage=3D83ecf000)
Stack: 8012ee1b 8023c8e0 0001c500 9feb1cf4 00000000 00000005 00000008 83f86=
080=20
       8012427d 0001c500 000001c5 081c084c 00000000 0001c600 801242bd 0001c=
600=20
       00000001 9fe13b20 80124525 8e293980 0816e000 83f86080 081c084c 8e293=
b60=20
Call Trace: [<8012ee1b>] [<8012427d>] [<801242bd>] [<80124525>] [<801246d8>=
]=20
   [<8015aca2>] [<80145725>] [<80112c00>] [<8013f69a>] [<801259c0>] [<80112=
a40>]=20
   [<80108894>]=20
Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d b4=20

>>EIP; 80126bb7 <__find_get_page+17/30>   <=3D=3D=3D=3D=3D
Trace; 8012ee1b <read_swap_cache_async+4b/b0>
Trace; 8012427d <swapin_readahead+3d/50>
Trace; 801242bd <do_swap_page+2d/140>
Trace; 80124525 <do_no_page+55/190>
Trace; 801246d8 <handle_mm_fault+78/e0>
Trace; 8015aca2 <ext3_delete_inode+e2/120>
Trace; 80145725 <destroy_inode+25/30>
Trace; 80112c00 <do_page_fault+1c0/5a0>
Trace; 8013f69a <sys_rename+1fa/210>
Trace; 801259c0 <do_munmap+250/260>
Trace; 80112a40 <do_page_fault+0/5a0>
Trace; 80108894 <error_code+34/3c>
Code;  80126bb7 <__find_get_page+17/30>
00000000 <_EIP>:
Code;  80126bb7 <__find_get_page+17/30>   <=3D=3D=3D=3D=3D
   0:   39 48 08                  cmp    %ecx,0x8(%eax)   <=3D=3D=3D=3D=3D
Code;  80126bba <__find_get_page+1a/30>
   3:   75 f4                     jne    fffffff9 <_EIP+0xfffffff9> 80126bb=
0 <__find_get_page+10/30>
Code;  80126bbc <__find_get_page+1c/30>
   5:   39 50 0c                  cmp    %edx,0xc(%eax)
Code;  80126bbf <__find_get_page+1f/30>
   8:   75 ef                     jne    fffffff9 <_EIP+0xfffffff9> 80126bb=
0 <__find_get_page+10/30>
Code;  80126bc1 <__find_get_page+21/30>
   a:   85 c0                     test   %eax,%eax
Code;  80126bc3 <__find_get_page+23/30>
   c:   74 03                     je     11 <_EIP+0x11> 80126bc8 <__find_ge=
t_page+28/30>
Code;  80126bc5 <__find_get_page+25/30>
   e:   ff 40 14                  incl   0x14(%eax)
Code;  80126bc8 <__find_get_page+28/30>
  11:   c3                        ret   =20
Code;  80126bc9 <__find_get_page+29/30>
  12:   8d b4 00 00 00 00 00      lea    0x0(%eax,%eax,1),%esi


1 warning issued.  Results may not be reliable.

 - Pizza
--=20
Solomon Peachy                                   pizza@f*cktheusers.org
I'm not broke, but I'm badly bent.                         ICQ #1318344
Patience comes to those who wait.                         Melbourne, FL

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9OBCzPuLgii2759ARAtmoAKC/ZNtPGAy5/KqlQcx9Nvm2bBILDQCgoWVo
apfVH0+3WCyT/hW2tVBiWKk=
=hfMA
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
