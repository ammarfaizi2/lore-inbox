Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265729AbTL3KzS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 05:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265734AbTL3KzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 05:55:18 -0500
Received: from dodge.jordet.nu ([217.13.8.142]:53956 "EHLO dodge.jordet.nu")
	by vger.kernel.org with ESMTP id S265729AbTL3KzI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 05:55:08 -0500
Subject: Oops with 2.4.23 in kswapd
From: Stian Jordet <liste@jordet.nu>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-CQXMibdlEqJJrz9lbqzB"
Message-Id: <1072781694.530.9.camel@buick>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 30 Dec 2003 11:54:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CQXMibdlEqJJrz9lbqzB
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Oops run through ksymoops attached. Had a similar oops with 2.4.22,
never any problems with .18, .19 or .20. Never tried .21.

kswapd process is now

root         4  0.0  0.0     0    0 ?        Z    Nov29  14:03 [kswapd
<defunct>]

in processlist.

Best regards,
Stian

--=-CQXMibdlEqJJrz9lbqzB
Content-Disposition: attachment; filename=oops2.txt
Content-Type: text/plain; name=oops2.txt; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

Unable to handle kernel NULL pointer dereference at virtual address 00000018
 printing eip:
c0132f30
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0132f30>]    Not tainted
EFLAGS: 00010207
eax: 00000000   ebx: c1047e20   ecx: 000001d0   edx: 00000000
esi: 00000000   edi: c17e3440   ebp: c1047e20   esp: cb73bf30
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 4, stackpage=cb73b000)
Stack: c1047e20 000001d0 00000001 0000003e c01313ec c17e3440 c1047e20 c0129ae2 
       c1047e20 000001d0 00000004 000001d0 c029d85c c029d85c cb73a000 0000153e 
       000001d0 c029d85c c0129de3 cb73bfa8 0000003b 000001d0 00000004 c0129e50 
Call Trace:    [<c01313ec>] [<c0129ae2>] [<c0129de3>] [<c0129e50>] [<c0129fde>]
  [<c012a046>] [<c012a15d>] [<c0105568>]

Code: 8b 56 18 8b 46 10 83 e2 06 09 d0 75 78 8b 76 28 39 fe 75 ec 
 <1>Unable to handle kernel paging request at virtual address 6465708c
 printing eip:
c01313cb
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01313cb>]    Not tainted
EFLAGS: 00010286
eax: 64657070   ebx: c1047110   ecx: 000001d2   edx: 00000001
esi: 000001d2   edi: 00000015   ebp: 00000c80   esp: c6e95cf0
ds: 0018   es: 0018   ss: 0018
Process rsync (pid: 5586, stackpage=c6e95000)
Stack: c06612a0 c1047110 c0129ae2 c1047110 000001d2 00000020 000001d2 c029d85c 
       c029d85c c6e94000 00001b44 000001d2 c029d85c c0129de3 c6e95d54 0000003c 
       000001d2 00000020 c0129e50 c6e95d54 c6e94000 00000000 00000010 00000000 
Call Trace:    [<c0129ae2>] [<c0129de3>] [<c0129e50>] [<c012a8a5>] [<c012aba6>]
  [<c0129302>] [<c012a866>] [<c012114c>] [<c012121f>] [<c01213ca>] [<c0111754>]
  [<c01115f4>] [<c01de800>] [<c01e237e>] [<c01ddfae>] [<c01bc8ef>] [<c01c2f11>]
  [<c0106ce4>] [<c01241ce>] [<c0123ca3>] [<c012428b>] [<c0124174>] [<c012f586>]
  [<c0106bf3>]

Code: 83 78 1c 00 74 12 56 53 8b 40 1c ff d0 83 c4 08 85 c0 75 04 
 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000021
 printing eip:
c0132e86
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0132e86>]    Not tainted
EFLAGS: 00010203
eax: 00000000   ebx: 00000009   ecx: 000001d2   edx: 00000012
esi: 00000000   edi: c17e38c0   ebp: c1047a00   esp: c86cbdb4
ds: 0018   es: 0018   ss: 0018
Process pisg (pid: 6201, stackpage=c86cb000)
Stack: c1047a00 c17e38c0 c17e38c0 c0132fdc c17e38c0 c1047a00 000001d2 0000001c 
       00000c7d c01313ec c17e38c0 c1047a00 c0129ae2 c1047a00 000001d2 00000020 
       000001d2 c029d85c c029d85c c86ca000 00001b4a 000001d2 c029d85c c0129de3 
Call Trace:    [<c0132fdc>] [<c01313ec>] [<c0129ae2>] [<c0129de3>] [<c0129e50>]
  [<c012a8a5>] [<c012aba6>] [<c0129302>] [<c012a866>] [<c012114c>] [<c012121f>]
  [<c01213ca>] [<c0111754>] [<c01115f4>] [<c0123ee6>] [<c011b517>] [<c0122656>]
  [<c01216fb>] [<c0106ce4>]

Code: f6 43 18 06 74 7c b8 07 00 00 00 0f ab 43 18 19 c0 85 c0 74 
 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000028
 printing eip:
c015e3a2
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c015e3a2>]    Not tainted
EFLAGS: 00010203
eax: 0100004d   ebx: 00000000   ecx: 000001d2   edx: 00000000
esi: c02d7480   edi: 00000001   ebp: 00000050   esp: c17b5df4
ds: 0018   es: 0018   ss: 0018
Process imapd (pid: 7852, stackpage=c17b5000)
Stack: c10474d8 000001d2 00000007 00000c80 00000000 c015684e cb4ab000 c10474d8 
       000001d2 c01313d8 c10474d8 000001d2 c02d7480 c10474d8 c0129ae2 c10474d8 
       000001d2 00000020 000001d2 c029d85c c029d85c c17b4000 000014fc 000001d2 
Call Trace:    [<c015684e>] [<c01313d8>] [<c0129ae2>] [<c0129de3>] [<c0129e50>]
  [<c012a8a5>] [<c012aba6>] [<c0155cfc>] [<c012a866>] [<c01233ea>] [<c0123a55>]
  [<c0123c72>] [<c012428b>] [<c0124174>] [<c012f586>] [<c0106bf3>]

Code: 8b 5b 28 f6 42 19 04 74 17 8d 44 24 10 50 52 e8 0a ff ff ff 
 

--=-CQXMibdlEqJJrz9lbqzB--

