Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135200AbRAYAXS>; Wed, 24 Jan 2001 19:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129441AbRAYAXI>; Wed, 24 Jan 2001 19:23:08 -0500
Received: from voyager.scifi.eu.org ([62.21.15.1]:28935 "EHLO
	voyager.scifi.eu.org") by vger.kernel.org with ESMTP
	id <S129406AbRAYAW4>; Wed, 24 Jan 2001 19:22:56 -0500
Date: Thu, 25 Jan 2001 01:22:50 +0100
From: Bartosz Waszak <waszi@pld.org.pl>
To: linux-kernel@vger.kernel.org
Subject: 2.4.1-pre9 Oops
Message-ID: <20010125012250.A24368@voyager.scifi.eu.org>
Mail-Followup-To: Bartosz Waszak <waszi@pld.org.pl>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: PLD Team (http://www.pld.org.pl/)
X-Geekcode-Version: 3.12
X-Geekcode: GCS/M  d- s+:+ a16 C+++ UL+++>$ P+>+++ L+++>++++ E- W++ N++ o? K? w-- O- M- PS-- PE++ Y+ PGP++ t+++ 5+ X- R tv b DI D++ G++ e->e h! r- !y+
X-Linux-User: 153066
X-Registered-Linux-Machine: 82867
X-Operating-System: Linux voyager 2.4.1-pre9 i686 pld
X-info: VOYAGER - Our Warp to The World
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux voyager 2.4.1-pre9 #1 nie sty 21 23:42:43 CET 2001 i686 pld
Kernel modules         2.4.1
Gnu C                  2.95.3
Gnu Make               3.79.1
Binutils               2.10.1.0.4
Linux C Library        > libc.2.2
Dynamic linker         ldd (GNU libc) 2.2
Linux C++ Library      2.10.0
Procps                 2.0.7
Mount                  2.10r
Net-tools              1.57
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         es1371 ac97_codec serial isa-pnp ipip ne2k-pci
		       8390 ipt_TOS iptable_mangle ipt_limit ipt_LOG 
		       ip_nat_ftp ip_conntrack_ftp ip6table_filter 
		       ipv6 iptable_nat ip_conntrack iptable_filter 
		       ip6_tables ip_tables reiserfs sr_mod scsi_mod 
		       cdrom ext2 ide-disk ide-probe-mod ide-mod

-- 
< Bartosz Waszak >---<             It is easier to fix               >
< waszi@pld.org.pl >-<          Unix than to live with NT.           >
< www.ipv6.n.pl >----<                                               >
                  PGP: finger waszi@voyager.ipv6.n.pl

--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops.log"

ksymoops 2.3.7 on i686 2.4.1-pre9.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.1-pre9/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

CPU:    0
EIP:    0010:[<c0111d94>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 0000001b ebx: 7fffffff ecx: c5b94000 edx: c0206508
esi: c4df1c14 edi: c5b24000 ebp: c5b25e78 esp: c5b25e48
ds: 0018 es: 0018: ss: 0018
Process pure-ftpd (pid: 5019, stackpage=c5b22000)
Stack: c01d9805 c01d9956 000002b0 7fffffff c4df1c14 7fffffff c4df1e54 c4df1dfc
       c8adbd72 c4df1be0 00000000 c4df1be0 c5b25e9c c011197f c4df1be0 c4df1c14
       00000011 c4df1cc0 c4df1d10 00000286 c4df1be0 c5b25ec4 c01bd170 c4df1be0
Call Trace: [<c8adbd72>] [<c011197f>] [<c01bd170>] [<c01bd317>] [<c0190b87>] [<c019027e>] [<c0191484>] [<c0108f50>] [<c0108e33>]
Code: 0f 0b 8d 65 dc 5b 5e 5f 89 ec 5d c3 55 89 e5 83 ec 10 57 56

>>EIP; c0111d94 <schedule+388/394>   <=====
Trace; c8adbd72 <END_OF_CODE+7584f/????>
Trace; c011197f <schedule_timeout+17/94>
Trace; c01bd170 <inet_wait_for_connect+b8/130>
Trace; c01bd317 <inet_stream_connect+12f/1f0>
Trace; c0190b87 <sys_connect+5b/78>
Trace; c019027e <sock_read+92/a0>
Trace; c0191484 <sys_socketcall+8c/200>
Trace; c0108f50 <error_code+34/3c>
Trace; c0108e33 <system_call+33/38>
Code;  c0111d94 <schedule+388/394>
00000000 <_EIP>:
Code;  c0111d94 <schedule+388/394>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0111d96 <schedule+38a/394>
   2:   8d 65 dc                  lea    0xffffffdc(%ebp),%esp
Code;  c0111d99 <schedule+38d/394>
   5:   5b                        pop    %ebx
Code;  c0111d9a <schedule+38e/394>
   6:   5e                        pop    %esi
Code;  c0111d9b <schedule+38f/394>
   7:   5f                        pop    %edi
Code;  c0111d9c <schedule+390/394>
   8:   89 ec                     mov    %ebp,%esp
Code;  c0111d9e <schedule+392/394>
   a:   5d                        pop    %ebp
Code;  c0111d9f <schedule+393/394>
   b:   c3                        ret    
Code;  c0111da0 <__wake_up+0/98>
   c:   55                        push   %ebp
Code;  c0111da1 <__wake_up+1/98>
   d:   89 e5                     mov    %esp,%ebp
Code;  c0111da3 <__wake_up+3/98>
   f:   83 ec 10                  sub    $0x10,%esp
Code;  c0111da6 <__wake_up+6/98>
  12:   57                        push   %edi
Code;  c0111da7 <__wake_up+7/98>
  13:   56                        push   %esi


1 warning issued.  Results may not be reliable.

--sm4nu43k4a2Rpi4c--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
