Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265691AbUAHSuN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 13:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265692AbUAHSuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 13:50:13 -0500
Received: from sitemail3.everyone.net ([216.200.145.37]:13035 "EHLO
	omta06.mta.everyone.net") by vger.kernel.org with ESMTP
	id S265691AbUAHSuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 13:50:06 -0500
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
Date: Thu, 8 Jan 2004 10:49:35 -0800 (PST)
From: john moser <bluefoxicy@linux.net>
To: linux-kernel@vger.kernel.org
Subject: Oops 0002
Reply-To: bluefoxicy@linux.net
X-Originating-Ip: [68.33.187.247]
Message-Id: <20040108184935.BD5E3E4B8@sitemail.everyone.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

icebox regression # ./memkmemport_test
Testing denied write of /dev/mem... : FAILED
Testing denied mmap write of /dev/kmem... : FAILED
Testing denied open of /dev/port... : FAILED
<1>Unable to handle kernel NULL pointer dereference at virtual address
00000000
 printing eip:
c0387645
*pde = 00000000
Oops: 0002 [#3]
CPU:    0
EIP:    0060:[<c0387645>]    Tainted: PF
EFLAGS: 00010246
eax: 00000000   ebx: 00000004   ecx: 00000004   edx: 00000000
esi: 080487eb   edi: 00000000   ebp: 080487ef   esp: d0f55e80
ds: 007b   es: 007b   ss: 0068
Process memkmemport_tes (pid: 7355, threadinfo=d0f54000 task=dbdd0c80)
Stack: 00000004 00000004 efd516c0 c02b7523 ef5aa9c0 00000004 00000000 c02b6a48
       00000000 080487eb 00000004 e69cd140 c02b6dd0 00000004 e69cd160 080487eb
       c02b6e39 e69cd140 00000000 00000000 080487eb 00000004 e69cd160 e69cd140
Call Trace: [<c02b7523>]  [<c02b6a48>]  [<c02b6dd0>]  [<c02b6e39>]
[<c02b6dd0>]  [<c01ed0e8>]  [<c01ed212>]  [<c019d417>]  [<c019d42f>]
Code: f3 aa 58 59 e9 fc 4c f0 ff b8 f2 ff ff ff e9 b3 9e f0 ff b8
 Segmentation fault


regression tools that I pulled out of the grsecurity.net cvs and tested on a PaX patched kernel AND a kernel that I'm working a bit on (without pax), neither should oops.  I don't readily reboot to run vanillas. This is a NULL dereference INSIDE the kernel, right?  Something's broke, and it does this on 2.6.1-rc2 so whatever it is is probably still broke.

--Bluefox

_____________________________________________________________
Linux.Net -->Open Source to everyone
Powered by Linare Corporation
http://www.linare.com/
