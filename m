Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264204AbTEGTB5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 15:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264210AbTEGTB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 15:01:57 -0400
Received: from simmts7.bellnexxia.net ([206.47.199.165]:27902 "EHLO
	simmts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S264204AbTEGTB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 15:01:28 -0400
Subject: Kernel Panic - IDE-SCSI
From: Nicolas Couture <nc@stormvault.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9.7x.1) 
Date: 07 May 2003 15:13:59 -0400
Message-Id: <1052334839.3394.31.camel@gsiserver.gsitechusa.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found a bug in the scsi emulation support in the 2.4 serie.

--- snip ---
kung-foo:/home/user# echo foo > /proc/scsi/ide-scsi/0
<1>Unable to handle kernel NULL pointer dereference at virtual address
00000000
 printing eip:
00000000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<00000000>]    Not tainted
EFLAGS: 00010246
eax: 00000000   ebx: c6b80000   ecx: 00000000   edx: c032c620
esi: c11ffdb0   edi: 00000004   ebp: 00000004   esp: c70c1f5c
ds: 0018   es: 0018   ss: 0018
Process bash (pid: 5072, stackpage=c70c1000)
Stack: c0207a4a c6b80000 c70c1f84 00000000 00000004 00000000 00000001
00000000
       c47db120 ffffffea c010d09c c014c3df c47db120 40015000 00000004
c11ffdb0
       c0131715 c47db120 40015000 00000004 c47db140 c70c0000 00000004
40015000
Call Trace:    [<c0207a4a>] [<c010d09c>] [<c014c3df>] [<c0131715>]
[<c01086df>]

Code:  Bad EIP value.
 Segmentation fault
user@kung-foo:~$
--- snip ---

Nicolas Couture

