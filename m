Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281000AbRKCRzW>; Sat, 3 Nov 2001 12:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280998AbRKCRzC>; Sat, 3 Nov 2001 12:55:02 -0500
Received: from mailhost.iitb.ac.in ([203.197.74.142]:25862 "HELO
	mailhost.iitb.ac.in") by vger.kernel.org with SMTP
	id <S280997AbRKCRyw>; Sat, 3 Nov 2001 12:54:52 -0500
Date: Sat, 3 Nov 2001 23:20:35 +0530
From: N S S Kishore K <kishore@cse.iitb.ac.in>
To: linux-kernel@vger.kernel.org
Subject: Oops 2.4.9
Message-ID: <20011103232035.A13334@cse.iitb.ac.in>
Reply-To: N S S Kishore K <kishore@cse.iitb.ac.in>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=uAKRQypu60I7Lcqm
X-Mailer: Mutt 0.95.1i
X-Useless-Header: ??? # sign! 
X-Operating-System: SunOS chandra 5.6 Generic_105181-11 sun4u sparc
Organization: Dept. of Computer Science and Engineering, IIT Bombay
X-Url: http://www.cse.iitb.ac.in/~kishore
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii

hi,
	I am incorporating MPLS (Multi Protocol Label Switching) support
to the linux kernel 2.4.9.

	I am getting oops when calling dst_alloc(). My oops file is 
enclosed with this mail.

Processor: Pentium III (coppermine)
RAM : 128 MB
OS: Redhat 7.0

Kernel Version: 2.4.9

Thank you in advance
kishore


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=mail2

ksymoops 2.4.0 on i686 2.4.9.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.9/ (default)
     -m /home/pg00/kishore/linux2.4.9/System.map (specified)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says c0213090, System.map says c0150cf0.  Ignoring ksyms_base entry
  Receiver lock-up bug exists -- enabling work-around.
ac97_codec: AC97 Audio codec, id: 0x4352:0x5914 (Cirrus Logic CS4297A rev B)
Unable to handle kernel NULL pointer dereference at virtual address 00000008
c0129540
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0129540>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010082
eax: 00000000   ebx: 00000020   ecx: 00000282   edx: c029b8d0
esi: 00000000   edi: c1260800   ebp: 00000000   esp: c1a9dcf4
ds: 0018   es: 0018   ss: 0018
Process update_ftn (pid: 948, stackpage=c1a9d000)
Stack: 00000286 00000001 00000000 00001f4e 00000063 c033ec00 c022ce6b 00000000 
       00000020 c0382f43 00000063 c1260800 c1260800 c033eb00 c029b97d c033ec00 
       c03142a3 c033ec00 c0314280 00000063 c0314260 00000001 c0382f3c 00000019 
Call Trace: [<c022ce6b>] [<c029b97d>] [<c029bade>] [<c029aec8>] [<c029ac29>] 
   [<c025df42>] [<c0122911>] [<c0263bb5>] [<c022482c>] [<c0122787>] [<c0224372>] 
   [<c02255d8>] [<c0143629>] [<c02245ae>] [<c0225017>] [<c0225ddb>] [<c0106fcc>] 
   [<c0106edb>] 
Code: 8b 56 08 39 f2 74 29 ff 42 10 8b 42 14 89 c3 8b 44 82 18 0f 

>>EIP; c0129540 <kmem_cache_alloc+10/60>   <=====
Trace; c022ce6b <dst_alloc+2b/80>
Trace; c029b97d <mpls_dst_create_ipv4+3d/f0>
Trace; c029bade <mpls_nh_to_dst_ipv4+ae/130>
Trace; c029aec8 <update_ftn+178/310>
Trace; c029ac29 <mpls_rcv_LDP_msg+19/30>
Trace; c025df42 <udp_sendmsg+b2/410>
Trace; c0122911 <handle_mm_fault+61/d0>
Trace; c0263bb5 <inet_sendmsg+35/40>
Trace; c022482c <sock_sendmsg+6c/90>
Trace; c0122787 <do_anonymous_page+37/a0>
Trace; c0224372 <move_addr_to_kernel+32/50>
Trace; c02255d8 <sys_sendto+c8/f0>
Trace; c0143629 <d_alloc+19/170>
Trace; c02245ae <sock_map_fd+ee/180>
Trace; c0225017 <sock_create+d7/100>
Trace; c0225ddb <sys_socketcall+13b/200>
Trace; c0106fcc <error_code+34/3c>
Trace; c0106edb <system_call+33/38>
Code;  c0129540 <kmem_cache_alloc+10/60>
00000000 <_EIP>:
Code;  c0129540 <kmem_cache_alloc+10/60>   <=====
   0:   8b 56 08                  mov    0x8(%esi),%edx   <=====
Code;  c0129543 <kmem_cache_alloc+13/60>
   3:   39 f2                     cmp    %esi,%edx
Code;  c0129545 <kmem_cache_alloc+15/60>
   5:   74 29                     je     30 <_EIP+0x30> c0129570 <kmem_cache_alloc+40/60>
Code;  c0129547 <kmem_cache_alloc+17/60>
   7:   ff 42 10                  incl   0x10(%edx)
Code;  c012954a <kmem_cache_alloc+1a/60>
   a:   8b 42 14                  mov    0x14(%edx),%eax
Code;  c012954d <kmem_cache_alloc+1d/60>
   d:   89 c3                     mov    %eax,%ebx
Code;  c012954f <kmem_cache_alloc+1f/60>
   f:   8b 44 82 18               mov    0x18(%edx,%eax,4),%eax
Code;  c0129553 <kmem_cache_alloc+23/60>
  13:   0f 00 00                  sldt   (%eax)


2 warnings issued.  Results may not be reliable.

--uAKRQypu60I7Lcqm--
