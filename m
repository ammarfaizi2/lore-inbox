Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283929AbRLEKNh>; Wed, 5 Dec 2001 05:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283932AbRLEKN3>; Wed, 5 Dec 2001 05:13:29 -0500
Received: from smtp.tpomail.net ([212.246.196.7]:1477 "HELO smtp.koti.soon.fi")
	by vger.kernel.org with SMTP id <S283929AbRLEKNY>;
	Wed, 5 Dec 2001 05:13:24 -0500
From: Jouni =?ISO-8859-1?Q?Kyl=E4-Nikkil=E4?= <jounikn.linux@nic.fi>
Subject: PROBLEM: 2.4.16 kernel panics (possible reason 2.2.2 Samba)
To: linux-kernel@vger.kernel.org
Date: Wed, 5 Dec 2001 12:08:39 +0200
Message-ID: <MWMail.anmqaoic@host.none>
Reply-To: jounikn.linux@nic.fi
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below should follow REPORTING-BUGS - form.

--- snip --- snip --- snip ---

1.
2.4.16 kernel panics (possible reason 2.2.2 Samba)

2.
I updated our fileserver from 2.2.19 to 2.4.16 and same time Samba server
from 2.2.1a to 2.2.2 and after these updates kernel pniced and hole 
computer chrashed and did not respond to any commands from console or from 
network. 

3.
kernel, samba

4.
Linux version 2.4.16 (root@linux) (gcc version 2.96 20000731 (Red Hat 
Linux 7.0)) #4 Tue Dec 4 10:19:01 EET 2001

5. 
Unable to handle kernel NULL pointer dereference at virtual address 
00000200 
 printing eip:
00000200
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<00000200>]    Not tainted
EFLAGS: 00010202
eax: 00000001   ebx: c0314e60   ecx: 00000002   edx: d081a000
esi: 00000002   edi: 0000001e   ebp: 00001d41   esp: c14e9f28
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 4, stackpage=c14e9000)
Stack: c13b1b80 c0126553 c0314e60 c14e1c00 c14e8000 000000f6 000001d0 
c02baf08 
       c0330c44 c14d0600 c1405d50 00000000 00000020 000001d0 00000006 
       00015fbc c01266c8 00000006 00000003 c02baf08 00000006 000001d0 
       c02baf08 00000000 
Call Trace: [<c0126553>] [<c01266c8>] [<c012671c>] [<c01267c1>] 
[<c0126836>] 
   [<c0126971>] [<c01268d0>] [<c010555b>]

Code:  Bad EIP value.
 <1>Unable to handle kernel NULL pointer dereference at virtual address 
 00000300 printing eip:
00000300
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<00000300>]    Not tainted
EFLAGS: 00010202
eax: 00000001   ebx: c0314e60   ecx: 00000003   edx: d081a000
esi: 00000003   edi: 00000020   ebp: 00001da6   esp: c734de14
ds: 0018   es: 0018   ss: 0018
Process smbd (pid: 603, stackpage=c734d000)
Stack: c13b1b40 c0126553 c0314e60 00000001 c734c000 00000100 000001d2 
c02baf08 
       c0330c44 00000000 c14058f0 00000000 00000020 000001d2 00000006 
       000163e0 c01266c8 00000006 00000003 c02baf08 00000006 000001d2 
       c02baf08 00000000 
Call Trace: [<c0126553>] [<c01266c8>] [<c012671c>] [<c0126fb3>] 
[<c012721b>] 
   [<c01206d1>] [<c0120c85>] [<c0120edf>] [<c01213ec>] [<c0121310>] 
   [<c012c6b6>] [<c012c380>] [<c012c530>] [<c0106d47>]

6.
Can't be reproduced with a shell script but occurs very often. Like 2 times
per minute.

7.
What goes here..?

7.1
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux linux 2.4.16 #4 Tue Dec 4 10:19:01 EET 2001 i686 unknown

Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.0.18
util-linux             2.10m
mount                  2.10m
modutils               2.3.14
e2fsprogs              1.18
pcmcia-cs              3.1.19
PPP                    2.3.11
Linux C Library        2.1.92
Dynamic linker (ldd)   2.1.92
Procps                 2.0.7
Net-tools              1.56
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         8139too

7.2.
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 3
model name      : AMD Duron(tm) Processor
stepping        : 1
cpu MHz         : 699.692
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov 
pat pse 36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1395.91

7.3.
8139too                13332   1 (autoclean)


7.4.
Attached devices:
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: HP       Model: C1537A           Rev: L907
  Type:   Sequential-Access                ANSI SCSI revision: 02

--- snip --- snip --- snip ---

- Jouni


