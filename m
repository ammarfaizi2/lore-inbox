Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315758AbSFJS4q>; Mon, 10 Jun 2002 14:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315760AbSFJS4p>; Mon, 10 Jun 2002 14:56:45 -0400
Received: from ip68-9-71-221.ri.ri.cox.net ([68.9.71.221]:35625 "EHLO
	mail.blue-labs.org") by vger.kernel.org with ESMTP
	id <S315758AbSFJS4p>; Mon, 10 Jun 2002 14:56:45 -0400
Message-ID: <3D04F667.8090701@blue-labs.org>
Date: Mon, 10 Jun 2002 14:56:39 -0400
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0+) Gecko/20020501
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [OOPS] 2.4.19-pre4, oops when dumping scsi data
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Bmilter: Processing completed, Bmilter version 0.1.0 build 556; timestamp 2002-06-10 14:56:10, message serial number 4177
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# echo "scsi dump #1" > /proc/scsi/scsi

[...] long scsi dump goes here

( 47)  2:0: 4: 0 ( 00:00    0    0    0 ffffffff 0) (0 0 0x 0) (   0    
0    0) 
0x00 0x00 0x00000000
( 48)  2:0: 4: 0 ( 00:00    0    0    0 ffffffff 0) (0 0 0x 0) (   0    
0    0) 
0x00 0x00 0x00000000
( 49)  2:0: 4: 0 ( 00:00    0    0    0 ffffffff 0) (0 0 0x 0) (   0    
0    0) 
0x00 0x00 0x00000000
Dump of pending block device requests
0: <1>Unable to handle kernel NULL pointer dereference at virtual 
address 000000
34
 printing eip:
c0280280
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0280280>]    Not tainted
EFLAGS: 00010292
eax: 00000000   ebx: 00000000   ecx: 00000000   edx: c03e444a
esi: cbf1147c   edi: cbf5d58c   ebp: c04df098   esp: c25d9ec4
ds: 0018   es: 0018   ss: 0018
Process bash (pid: 11010, stackpage=c25d9000)
Stack: 00000000 00000000 c58d2005 c03e40a0 c58d2009 0000000d c027f5a9 
00000000
       c58d200a 00000000 00000000 c4f6ab30 00000000 00000000 00000000 
00000002
       c4f6ab30 c0113aec c70dc27c c86af9a0 08109168 00000001 00000001 
08109168
Call Trace: [<c027f5a9>] [<c0113aec>] [<c01535a8>] [<c0134a50>] 
[<c013449f>]
   [<c0106deb>]

Code: 8b 43 34 50 8b 4b 20 51 8b 53 1c 52 8b 43 14 50 0f b7 43 10


[...]

 >>EIP; c0280280 <scsi_dump_status+220/260>   <=====
Trace; c027f5a9 <proc_scsi_gen_write+749/780>
Trace; c0113aec <do_page_fault+2fc/4d7>
Trace; c01535a8 <proc_file_write+28/40>
Trace; c0134a50 <sys_write+e0/110>
Trace; c013449f <filp_close+3f/60>
Trace; c0106deb <system_call+33/38>



