Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262827AbRE0RUj>; Sun, 27 May 2001 13:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262828AbRE0RU3>; Sun, 27 May 2001 13:20:29 -0400
Received: from ti34a31-0057.dialup.online.no ([130.67.66.57]:29700 "EHLO
	anfield.bjerkeset.com") by vger.kernel.org with ESMTP
	id <S262827AbRE0RUL>; Sun, 27 May 2001 13:20:11 -0400
Message-ID: <3B113742.518984CD@bjerkeset.com>
Date: Sun, 27 May 2001 19:20:02 +0200
From: "Bjerkeset, Svein Olav" <svein.olav@bjerkeset.com>
Reply-To: svbj@online.no
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: BUG?: 2.4.5 breaks reiserfs (kernel BUG)
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by leeloo.zip.com.au id DAA03077

Hi,

Today I downloaded kernel 2.4.5 and compiled it. The kernel worked fine
until
I tried to halt the computer. When trying to unmount the reiserfs
filesystems,
the system freezes with the following output:

journal_begin called without kernel lock held
kernel BUG at journal.c:423!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01b5fb0>]
EFLAGS: 00210282
eax: 0000001d   ebx: c1eb1f28   ecx: c7ab2000   edx: 00000001
esi: c13c8200   edi: 3b11320b   ebp: 0000000a   esp: c1eb1ec0
ds: 0018   es: 0018   ss: 0018
Process umount (pid: 1027, stackpage=c1eb1000)
Stack: c02ef289 c02ef3e4 000001a7 c01b855b c02f0401 c1eb1f28 c13c8200
c034e020
       c13c8234 3b11320b 00000000 c67f55c0 c13c8200 c1eb0000 c13c8244
c01b876e
       c1eb1f28 c13c8200 0000000a 00000000 c01a92f8 c1eb1f28 c13c8200
0000000a
Call Trace: [<c01b855b>] [<c01b876e>] [<c01a92f8>] [<c0137baa>]
[<c0137be1>] [<c0136e8c>] [<c013cecc>]
       [<c013808d>] [<c0122f62>] [<c01380c4>] [<c0106efb>]

Code: 0f 0b 83 c4 0c c3 89 f6 31 c0 c3 90 31 c0 c3 90 56 be 40 2f


BTW: The kernel is compiled with egcs 2.91.66

Please CC to svbj@online.no as I am not subscribed to this list

Svein Olav Bjerkeset
ı:.Ë›±Êâmçë¢kaŠÉb²ßìzwm…ébïîË›±Êâmébìÿ‘êçz_âØ^n‡r¡ö¦zËëh™¨è­Ú&£ûàz¿äz¹Ş—ú+€Ê+zf£¢·hšˆ§~†­†Ûiÿÿïêÿ‘êçz_è®æj:+v‰¨ş)ß£ømšSåy«­æ¶…­†ÛiÿÿğÃí»è®å’i
