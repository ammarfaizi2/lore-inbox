Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129274AbRCHQmn>; Thu, 8 Mar 2001 11:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129272AbRCHQmd>; Thu, 8 Mar 2001 11:42:33 -0500
Received: from roadrunner.inf.hs-anhalt.de ([193.25.37.130]:58380 "EHLO
	roadrunner.inf.hs-anhalt.de") by vger.kernel.org with ESMTP
	id <S129249AbRCHQmV>; Thu, 8 Mar 2001 11:42:21 -0500
Message-ID: <3AA7B66D.B32E0FF2@darmstadt.gmd.de>
Date: Thu, 08 Mar 2001 17:42:21 +0100
From: Tino Keitel <tino.keitel@darmstadt.gmd.de>
X-Mailer: Mozilla 4.6 [de] (WinNT; I)
X-Accept-Language: de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: crashes if accassing FAT MO
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I use kernel 2.4.2. If I try to access files on a 640 MB MO (2048 bytes
hardware sector size) and the MO is using FAT fs I only got messages
like these:

Unable to handle kernel NULL pointer dereference at virtual address
00000000
 printing eip:
00000000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<00000000>]
EFLAGS: 00010286
eax: 00000000   ebx: c798d740   ecx: 00000003   edx: c798d740
esi: ffffffea   edi: 00000000   ebp: 00004000   esp: c576bf88
ds: 0018   es: 0018   ss: 0018
Process cat (pid: 458, stackpage=c576b000)
Stack: cc993428 c798d740 0804b220 00004000 c798d760 c012d465 c798d740
0804b220
       00004000 c798d760 c576a000 00004000 0804b220 bffff994 c0108d43
00000003
       0804b220 00004000 00004000 0804b220 bffff994 00000003 0000002b
0000002b
Call Trace: [<cc993428>] [<c012d465>] [<c0108d43>]

Code:  Bad EIP value.
Segmentation fault

There are no problems if I use ext2fs, exept that I can't use them for
data exchange with Windows. It also works with 2.2 kernels but the MO
drive will be much slower.

Tino
