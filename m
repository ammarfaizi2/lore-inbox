Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281808AbRLQRnq>; Mon, 17 Dec 2001 12:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281806AbRLQRnh>; Mon, 17 Dec 2001 12:43:37 -0500
Received: from grunt.ksu.ksu.edu ([129.130.12.17]:22947 "EHLO
	mailhub.cns.ksu.edu") by vger.kernel.org with ESMTP
	id <S281795AbRLQRnY>; Mon, 17 Dec 2001 12:43:24 -0500
Date: Mon, 17 Dec 2001 11:43:22 -0600
From: Joseph Pingenot <jap3003@ksu.edu>
To: linux-kernel@vger.kernel.org
Subject: USB [Toshiba PCX1100U CableModem] panic
Message-ID: <20011217114322.D16465@ksu.edu>
Reply-To: jap3003+response@ksu.edu
Mail-Followup-To: linux-kernel@vger.kernel.org.
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
X-School: Kansas State University
X-vi-or-emacs: vi
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Sorry for the resend, but I didn't get any responses, nor a copy
[ back (I usually do), nor did it appear in the archives.
[ Did Majordomo burp?
[As a postscript, I haven't found anything out yet.]


I get the following oops if I try and run pump on eth1, the cable
  modem:
[First, machine info:
[  Toshiba Satellite 1605CDS
[    AMD K6-3, 450MHz
[    160MB RAM
[  linux 2.4.16
[  Debian unstable
[Cable modem is a Toshiba PCX1100U

#pump -i eth1
CDCEther.c: eth1: set multicast filters
Scheduling in interrupt
kernel BUG at sched.c 551!
invalid operand: 0000
CPU: 0
EIP: 0010:[<c01125b0>]	Not tainted
EFLAGS: 00010282
eax: 0000001b	ebx: c9199de4	ecx: c029ad60	edx: 00001ce1
esi: 0000ccab	edi: 00000000	ebp: c9199dd0	esp: c9199da4
ds: 0018   es: 0018   ss: 0018
Process pump (pid: 374, stackpage=c9199000)
Stack: c0248916 00000227 c9199de4 0000ccab 00000000 c01f404f c02b2000 c9199e1c
       00000000 c9198000 00000202 c9199df8 c011251a c9199de4 c9198000 c930c600
       c02f687c c02f687c 0000ccab c9198000 c011245c c9198000 c01ec667 c930c600
Call Trace: [<c01f404f>] [<c011251a>] [<c011245c>] [<c01ec667>] [<c01ec782>]
   [<c01ec80f>] [<ca868787>] [<c02003ae>] [<c02003c4>] [<c01fe9fd>] [<c01ff833>]

   [<c02256a1>] [<c0227417>] [<c01f8e26>] [<c013a0c6>] [<c0106b33>]

Code: 0f 0b 83 c4 08 0b 4d f4 c1 e1 05 81 c1 40 b5 2e c0 89 4d fc
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
[Freeze]
(Paraphrased; I typed this in manually)

I'm going to try and dig around and figure stuff out, but, being new
  to such things, any help would be appeciated.  
Likewise for anyone else dinking with this, I'll provide what info I can.
Quick note to ext3 developers: THANKS for journaling!!  :)


-- 
Joseph=========<Free Software User and Developer>===========jap3003@ksu.edu
"If you really want to toggle [Internet Explorer] into secure mode, you
  just need to click the little 'X" in the top right corner of the window."
     --User dsb3 on www.slashdot.org.       [Use Mozilla! www.mozilla.org.]
