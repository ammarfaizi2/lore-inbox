Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264926AbRFWKgB>; Sat, 23 Jun 2001 06:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265013AbRFWKfw>; Sat, 23 Jun 2001 06:35:52 -0400
Received: from hssx-sktn-167-47.sasknet.sk.ca ([142.165.167.47]:24336 "HELO
	mail.thock.com") by vger.kernel.org with SMTP id <S264926AbRFWKfq>;
	Sat, 23 Jun 2001 06:35:46 -0400
Message-ID: <3B34711A.F25ED753@bigfoot.com>
Date: Sat, 23 Jun 2001 04:36:10 -0600
From: Dylan Griffiths <Dylan_G@bigfoot.com>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Kernel BUG in inode.c line 486 in 2.4.5 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Found these lurking in dmesg.. no timestamp on them, so I have no idea when
they happened.. the system seems ok, but I'm going to go fsck it a bit now..

Asus A7M266 board (VIA Southbridge).  VIA82CXXX chipset support is on, use
DMA by default is on.  ext2 partitions on a 20gb drive:
Filesystem            Size  Used Avail Use% Mounted on
/dev/hda5             2.9G  1.9G  873M  69% /
/dev/hda7              13G   10G  2.6G  80% /home
tmpfs                 103M     0  103M   0% /var/shm

Hope this helps..

-=-

kernel BUG at inode.c:486!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0141e43>]
EFLAGS: 00013286
eax: 0000001b   ebx: c726a2c0   ecx: 00000001   edx: c022a068
esi: c022cee0   edi: d489c9c0   ebp: d501dfa4   esp: d501deec
ds: 0018   es: 0018   ss: 0018
Process gmc (pid: 169, stackpage=d501d000)
Stack: c01f602c c01f608b 000001e6 c726a2c0 c0142887 c726a2c0 d4221a40
c726a2c0 
       c015a66d c726a2c0 c01402f6 d4221a40 c726a2c0 d4221a40 00000000
c0138d18 
       d4221a40 d501df68 c013945a d489c9c0 d501df68 00000000 cc51b000
00000000 
Call Trace: [<c0142887>] [<c015a66d>] [<c01402f6>] [<c0138d18>] [<c013945a>]
[<c0139a8c>] [<c01368a6>] 
       [<c0106b9b>] 

Code: 0f 0b 83 c4 0c f6 83 f4 00 00 00 10 75 1f 68 e8 01 00 00 68 

-=-

kernel BUG at inode.c:486!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0141e43>]
EFLAGS: 00010286
eax: 0000001b   ebx: c6bab980   ecx: 00000001   edx: c022a068
esi: c022cee0   edi: d489c9c0   ebp: d5559fa4   esp: d5559eec
ds: 0018   es: 0018   ss: 0018
Process gmc (pid: 18464, stackpage=d5559000)
Stack: c01f602c c01f608b 000001e6 c6bab980 c0142887 c6bab980 d4221dc0
c6bab980 
       c015a66d c6bab980 c01402f6 d4221dc0 c6bab980 d4221dc0 00000000
c0138d18 
       d4221dc0 d5559f68 c013945a d489c9c0 d5559f68 00000000 cae3b000
00000000 
Call Trace: [<c0142887>] [<c015a66d>] [<c01402f6>] [<c0138d18>] [<c013945a>]
[<c0139a8c>] [<c01368a6>] 
       [<c0106b9b>] 

Code: 0f 0b 83 c4 0c f6 83 f4 00 00 00 10 75 1f 68 e8 01 00 00 68 

-=-

kernel BUG at inode.c:486!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0141e43>]
EFLAGS: 00010286
eax: 0000001b   ebx: cf9b4640   ecx: 00000001   edx: c022a068
esi: c022cee0   edi: d489c9c0   ebp: c3bd1fa4   esp: c3bd1eec
ds: 0018   es: 0018   ss: 0018
Process gmc (pid: 18470, stackpage=c3bd1000)
Stack: c01f602c c01f608b 000001e6 cf9b4640 c0142887 cf9b4640 c1c1b5c0
cf9b4640 
       c015a66d cf9b4640 c01402f6 c1c1b5c0 cf9b4640 c1c1b5c0 00000000
c0138d18 
       c1c1b5c0 c3bd1f68 c013945a d489c9c0 c3bd1f68 00000000 c6087000
00000000 
Call Trace: [<c0142887>] [<c015a66d>] [<c01402f6>] [<c0138d18>] [<c013945a>]
[<c0139a8c>] [<c01368a6>] 
       [<c0106b9b>] 

Code: 0f 0b 83 c4 0c f6 83 f4 00 00 00 10 75 1f 68 e8 01 00 00 68 

-=-

kernel BUG at inode.c:486!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0141e43>]
EFLAGS: 00010286
eax: 0000001b   ebx: cf9b4040   ecx: 00000001   edx: c022a068
esi: c022cee0   edi: d489c9c0   ebp: d4ea1fa4   esp: d4ea1eec
ds: 0018   es: 0018   ss: 0018
Process xmms (pid: 14150, stackpage=d4ea1000)
Stack: c01f602c c01f608b 000001e6 cf9b4040 c0142887 cf9b4040 c1c1b9c0
cf9b4040 
       c015a66d cf9b4040 c01402f6 c1c1b9c0 cf9b4040 c1c1b9c0 00000000
c0138d18 
       c1c1b9c0 d4ea1f68 c013945a d489c9c0 d4ea1f68 00000000 d3693000
00000000 
Call Trace: [<c0142887>] [<c015a66d>] [<c01402f6>] [<c0138d18>] [<c013945a>]
[<c0139a8c>] [<c01367c6>] 
       [<c0106b9b>] 

Code: 0f 0b 83 c4 0c f6 83 f4 00 00 00 10 75 1f 68 e8 01 00 00 68 

--
    www.kuro5hin.org -- technology and culture, from the trenches.
