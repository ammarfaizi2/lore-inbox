Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266277AbRGLRF7>; Thu, 12 Jul 2001 13:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266271AbRGLRFj>; Thu, 12 Jul 2001 13:05:39 -0400
Received: from dialup91.kiss.uni-lj.si ([193.2.98.91]:40196 "EHLO
	redos-go.redos.si") by vger.kernel.org with ESMTP
	id <S266269AbRGLRFc>; Thu, 12 Jul 2001 13:05:32 -0400
Content-Type: text/plain; charset=US-ASCII
From: Sasa Ostrouska <maja.ostrouska@kiss.uni-lj.si>
Reply-To: info@rcdiostrouska.com
To: linux-kernel@vger.kernel.org
Subject: linux-2.4.5 BUG when shutdown
Date: Sun, 3 Jun 2001 19:42:09 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01060319420900.01287@redos-go>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi to all !

	I get the following message when I want to shutdown the machine:

------------

journal_begin called without kernel lock held
kernel BUG at journal.c:423!
invalid operand: 0000
CPU:    1
EIP:    0010:[<c0175420>]
EFLAGS: 00010286

eax: 0000001d ebx: c12b3f2c ecx: 00000001 edx: 00000001
esi: c7f41600 edi: c12b3f2c ebp: 0000000a esp: c12b3ec4
ds: 0018  es: 0018  ss: 0018

Process umount (pid: 2861, stackpage = c12b3000)

Stack: c025416c c0254304 000001a7 c017791e c0255321 c12b3f2c c7f41600 c02996a0
       c7f41644 3b1a4df9 c12b3f98 00000000 3b1a4df9 00000010 c025532f c0177b4e
       c12b3f2c c7f41600 0000000a 00000000 c0169d7c c12b3f2c c7f41600 0000000a

Call Trace: [<c017791e>] [<c0177b4e>] [<c0169d7c>] [<c013722c>] [<c013725f>]
            [<c01365a0>] [<c013c2e8>] [<c0137721>] [<c0137754>] [<c0106c6b>]

Code: 0f 0b 83 c4 0c c3 89 f6 31 c0 c3 90 31 c0 c3 90 56 53 31 db

Unmounting any remaining filesystems...

-------------

I use linux 2.4.5 and glibc-2.2.2
with reiserfs
If somebody can help to solve this would be very apreciated.

Best Regards
Sasa Ostrouska

