Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276665AbRJYXVs>; Thu, 25 Oct 2001 19:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276670AbRJYXVc>; Thu, 25 Oct 2001 19:21:32 -0400
Received: from f118.pav2.hotmail.com ([64.4.37.118]:57874 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S276665AbRJYXVR>;
	Thu, 25 Oct 2001 19:21:17 -0400
X-Originating-IP: [128.173.125.231]
From: "rem0ve _nosp4m" <one_wanderer_nosp4m@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.13 raid5d Oops, very repeatable.
Date: Thu, 25 Oct 2001 19:21:47 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F1183nOeEMxzGPItmI00000cdf4@hotmail.com>
X-OriginalArrivalTime: 25 Oct 2001 23:21:47.0380 (UTC) FILETIME=[D1353340:01C15DAB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware problems or kernel bug?  Please help.
Remove _nosp4m to reply directly.

-------------------------------------------------

kernel: 2.4.13
I got this during a sync 6 disk raid5 IDE raid partition.  Each time I try 
it fails at some point during the sync.


Unable to handle kernel paging request at virtual address 228f5268
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01f2de0>]    Not tainted
EFLAGS: 00010202
eax: 00000028   ebx: 228f5234   ecx: d7acb080   edx: d7edb014
esi: d7edb000   edi: 00000014   ebp: d7addbc0   esp: d7ecde98
ds: 0018   es: 0018   ss: 0018
Process raid5d (pid: 11, stackpage=d7ecd000)
Stack: d7acb000 d7edb000 c1644bc8 d7ecdfe0 c16661c0 40880016 c01aeff8 
d7ecdee4
       c01af055 d7edb014 00000028 d7ae5c14 00000014 00000001 00000001 
00000001
       00000001 00000001 00000004 d7acb158 d7ecdf2c d7acb0ec d7acb080 
c0118ad2
Call Trace: [<c01aeff8>] [<c01af055>] [<c0118ad2>] [<c01f3eb8>] [<c01fc8e6>]
   [<c01054e8>]

Code: 8b 7b 34 8b 75 34 0f b7 45 08 3d ff 01 00 00 77 14 89 c1 c1



Additional information from syslogd:

kernel: EIP:    0010:[handle_stripe+400/3712]    Not tainted
kernel: Call Trace: [start_request+312/528] [start_request+405/528] 
[timer_bh+546/608] [raid5d+280/304] [md_thread+246/336]
kernel:    [kernel_thread+40/64]

-------------------------------------------------

Another oops with 2.4.13-pre2 that I hand copied since the machine locked up 
altogether.  Same situation.

Unable to handle kernel paging request at virtual address 08e3dd09
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01b3586>]       Not tainted
EFLAGS: 00010202
eax: de835b3d   ebx: 0000000c   ecx: 00000018   edx: 08e3dcd5
esi: 0000cad0   edi: 0000000d   ebp: de82906d   esp: d2ab3bac
ds: 0018        es: 0018        ss: 0018
Process raid5d (pid: 415, stackpage=d2ab3000)
Stack: c167b000 00000000 c02e9684 c02e9510 00000084 c167a084 0000000d 
c167a000
       c01b3604 c02e9510 c16528c0 0000e408 00000000 c02e9684 c02e9510 
d7cb9008
       c01b3b10 c02e9684 00000000 0000dc06 c02e9510 c02e9681 c02e9684 
00d50000
Call Trace: [<c01b3604>] [<c01b3b10>] [<c01b343e>] [<c01b8532>] [<c01aefc8>]
  [<c01af025>] [<c01af396>] [<c01af85b>] [<c01b3450>] [<c0107f2f>] 
[<c01080ae>]
  [<c0109fd8>] [<c01f5543>] [<c01f6878>] [<c01f286e>] [<c01f3515>] 
[<c01aefc8>]
  [<c01af025>] [<c0118a52>] [<c01f3c18>] [<c01fc656>] [<c01054e8>]

Code: 3b 42 34 74 eb 8d 04 0b c1 e0 02 89 44 24 10 03 44 24 1c 89
<0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
-------------------------------------------------


_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp

