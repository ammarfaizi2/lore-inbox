Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131877AbRCVHSt>; Thu, 22 Mar 2001 02:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131878AbRCVHSj>; Thu, 22 Mar 2001 02:18:39 -0500
Received: from adsl-63-194-27-48.dsl.lsan03.pacbell.net ([63.194.27.48]:51976
	"EHLO ion.thebilberry.com") by vger.kernel.org with ESMTP
	id <S131877AbRCVHSZ>; Thu, 22 Mar 2001 02:18:25 -0500
Message-ID: <3AB9A682.43D20AD7@thebilberry.com>
Date: Wed, 21 Mar 2001 23:15:14 -0800
From: Greg Billock <greg@thebilberry.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.2-0.1.28 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [BUG] kernel BUG at slab.c:1402! -- 2.4.2-0.1.28
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary: Hotplugging a USB device causes an unrecoverable kernel Aiee!

Copied from screen after interrupt handler killed, so sorry for
incompleteness. This
bug is reproducable so if necessary, I can try it again....

kernel BUG at slab.c:1402!
invalid operand: 0000
CPU: 0
EIP: 0010: [<c012ddb4>]
EFLAGS: 00010086
eax: 1b ebx: 26d6a4 ecx: 81 edx: 14
esi: c82d3 edi: c82d3564 ebp: cdffb0a0 esp: c0289e98
ds: 18 es: 18 ss: 18
Process swapper (pid: 0, stackpage= c0289000)
.......
Kernel panic: Aiee, killing interrupt handler!

Sorry for the incomplete data. The system doesn't write anything to logs

about the crash, since it is a pretty hard one, but I can reproduce this
bug
if it hasn't been reported yet (I didn't find it in archives) or the
above is
insufficient.

More data:

AMD K6-2 400 processor, >200MB memory
Gnu C    2.96
Binutils 2.10.0.18
Linux C library 1.92.so
Procps 2.0.7
Mount 2.10m
Net-tools (2000-05-21)
sh-utils 2.0

Modules: 8139too, nls_iso8859-1, nls_cp437, vfat, fat, usb-ohci, usbcore

-Greg Billock
 greg@thebilberry.com



