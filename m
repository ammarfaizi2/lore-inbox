Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265028AbTIIXBk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 19:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265035AbTIIXBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 19:01:39 -0400
Received: from 62-43-29-174.user.ono.com ([62.43.29.174]:12676 "EHLO wanda")
	by vger.kernel.org with ESMTP id S265028AbTIIXAr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 19:00:47 -0400
From: Paco Ros <switch@tiscali.es>
Reply-To: switch@tiscali.es
To: linux-kernel@vger.kernel.org
Subject: [Oops] 2.4.22-ac1 XFS access error?
Date: Wed, 10 Sep 2003 01:00:44 +0200
User-Agent: KMail/1.5.3
Don't-Read-With: Microsoft Outlook, Microsoft Outlook Express
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309100100.44522.switch@tiscali.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm using 2.4.22-ac1 on a XFS partition and, some minutes ago, I haven't been able to login as regular user neither using Konsole, neither using a tty.
I've reastarded any services running with unsuccesfully and, finally, rebooted.

Here is the log at syslog:
Sep  9 23:55:19 wanda kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Sep  9 23:55:19 wanda kernel:  printing eip:
Sep  9 23:55:19 wanda kernel: c02ffc32
Sep  9 23:55:19 wanda kernel: *pde = 00000000
Sep  9 23:55:19 wanda kernel: Oops: 0002
Sep  9 23:55:19 wanda kernel: CPU:    0
Sep  9 23:55:19 wanda kernel: EIP:    0010:[rwsem_down_failed_common+50/112]    Tainted: PF
Sep  9 23:55:19 wanda kernel: EFLAGS: 00010286
Sep  9 23:55:19 wanda kernel: eax: ffffffff   ebx: d07d5658   ecx: 00000000   edx: ffffffff
Sep  9 23:55:19 wanda kernel: esi: c39ee000   edi: c39efed4   ebp: d55b6ec0   esp: c39efeb4
Sep  9 23:55:19 wanda kernel: ds: 0018   es: 0018   ss: 0018
Sep  9 23:55:19 wanda kernel: Process bash (pid: 32026, stackpage=c39ef000)
Sep  9 23:55:19 wanda kernel: Stack: d44fe00d d07d5658 d07d5658 d07d55dc c02ffb29 d07d5658 c39efed4 ffffffff
Sep  9 23:55:19 wanda kernel:        d07d565c 00000000 c39ee000 00000002 00000000 c0139d4f 00000000 d44fe01a
Sep  9 23:55:19 wanda kernel:        c0144925 00000000 00000000 00008202 db5f3370 00000000 c021697d dfdcd800
Sep  9 23:55:19 wanda kernel: Call Trace:    [rwsem_down_write_failed+41/64] [.text.lock.open+6/55] [link_path_walk+1333/1664] [xfs_access+77/96] [linvfs_permission+41/48]
Sep  9 23:55:19 wanda kernel:   [open_namei+548/1456] [filp_open+62/112] [sys_open+83/160] [system_call+51/56]
Sep  9 23:55:19 wanda kernel:
Sep  9 23:55:19 wanda kernel: Code: 89 39 0f c1 03 01 d0 66 85 c0 74 25 89 f6 8b 47 0c 85 c0 74

Please, could anybody give me a brief explanation about what has hapenned?

Thanks in advance.
Cheers.
-- 
Vayase usted a la puta mierda joder, por dios, venir a una lista
de linux y decirnos "gracias por todo, pero reiniciando mi
hasefroch lo hice funcionar..."
                               .: Bulmailing :.

