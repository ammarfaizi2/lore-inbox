Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281835AbRKZPoM>; Mon, 26 Nov 2001 10:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281842AbRKZPoC>; Mon, 26 Nov 2001 10:44:02 -0500
Received: from abasin.nj.nec.com ([138.15.150.16]:1800 "HELO abasin.nj.nec.com")
	by vger.kernel.org with SMTP id <S281835AbRKZPnn>;
	Mon, 26 Nov 2001 10:43:43 -0500
From: Sven Heinicke <sven@research.nj.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15362.25385.224210.438095@abasin.nj.nec.com>
Date: Mon, 26 Nov 2001 10:43:37 -0500 (EST)
To: linux-kernel@vger.kernel.org
Subject: Oops 2.4.15-pre1aa1
In-Reply-To: <20011116132520.A6204@lucon.org>
X-Mailer: VM 6.72 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I came back from my Turkey Day weekend to the following, hand copied
but I beleive it is accurate:

__alloc_pages: 0-order allocation failed (gfp=0xf0/0)
__alloc_pages: 0-order allocation failed (gfp=0x1f0/0)
__alloc_pages: 0-order allocation failed (gfp=0x70/0)
Unable to handle kernel paging request at virtual address 3cdd5c20
  Printing eip:
*pde=00000000
Oops: 0000
CPU: 0
EIP: 0010:[<c01126f8>] Not tainted
EFLAGS: 00010046
eax: 00000000 ebx: 3cdd5c20 ecx: 00000000 edx: 3cdd5c20
esi: 20268f25 edi: c027e000 edp: df065de8 esp: df065dc0
Process mcrawler (pid: 26574, stockpage=df065000)
Stack: 00000268 d1b3eec0 c0204468 df064000 fffffc18 00000000 df064000 7fffffff
       e3c13434 df064000 df065e18 c0112447 dba078e0 c01e7e67 dba078e0 00000000
       c01eb6f2 d6a078e0 e3c13400 00000246 e3c13434 e3c13434 c02ed300 c01fd05f
Call Trace: [<c0204468>][<c0112447>][<c01e7e67>][<c01e7e67>][<c01eb6f2>][<c01fd05f>]
  [<c01fd6cf>][<c02160c9>][<c01e4b31>][<c01292fc>][<c01e4c48>][<c0134d76>]

  [<c0134bc9>][<c0106f1b>]
Code: 8b 02 89 c3 0f 18 03 81 fa 60 8f 26 c0 0f 85 6a ff ff ff 8b

This system has 4G of memory and two processors.  It was booted on
November 12th at about 10am and lasted until November 26 at about 5am.
I was usinmg the aa kernel as the vanilla kernel was freezing up the
system often with no Oops, and it provided some unwanted swapping.
The vanilla kernel never lasted more then a few days.

The syslog shows:

Nov 15 16:04:44 ps1 kernel: __alloc_pages: 0-order allocation failed (gfp=0xf0/0)
Nov 15 16:04:44 ps1 kernel: __alloc_pages: 0-order allocation failed (gfp=0x1f0/0)
Nov 15 16:04:44 ps1 kernel: __alloc_pages: 0-order allocation failed (gfp=0x70/0)

but it lasted happily for days after that with nothing to report.  The
mcrawler program is a inhouse program that does lots of network IO and
a good about of disk IO.  It was running for like 5 days when the
system crashed.

I just upgraded to 2.4.15-pre9aa1.  Is there a better kernel to try?
Might any more information be helpful.

  Sven
