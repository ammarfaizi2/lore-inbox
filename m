Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262310AbTJXPmw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 11:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbTJXPmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 11:42:52 -0400
Received: from port-212-202-177-96.reverse.qdsl-home.de ([212.202.177.96]:61545
	"EHLO fbunet.dyndns.org") by vger.kernel.org with ESMTP
	id S262310AbTJXPmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 11:42:50 -0400
From: Fridtjof Busse <linux-kernel@fbunet.de>
To: linux-kernel@vger.kernel.org
Date: Fri, 24 Oct 2003 17:42:58 +0200
MIME-Version: 1.0
Content-Disposition: inline
Subject: [2.4.23-pre8] sk98lin Oops
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200310241742.58328@fbunet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
I'm getting this with 2.4.23-pre8 while starting eth0 (a 3Com 3C940 on 
an ASUS A7V600):

Unable to handle kernel NULL pointer dereference at virtual address 
0000004e
 printing eip:
0000004e
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<0000004e>]    Not tainted
EFLAGS: 00010206
eax: 0000004e   ebx: dfff0c00   ecx: 00000000   edx: c02dea16
esi: df33b143   edi: 00000000   ebp: 00000400   esp: df343ee4
ds: 0018   es: 0018   ss: 0018
Process ifconfig (pid: 877, stackpage=df343000)
Stack: c025fafb dfff0c00 c02de9c0 c02fff40 00000000 00000000 00000000 
00000000
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 
00000000
       00000000 00000000 00000000 00000000 00000143 dfff0c00 c025fb56 
df33b143
Call Trace:    [<c025fafb>] [<c025fb56>] [<c01587c0>] [<c0137a23>] 
[<c01073af>]

Code:  Bad EIP value.
 <1>Unable to handle kernel paging request at virtual address 2d303031
 printing eip:
c025e830
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c025e830>]    Not tainted
EFLAGS: 00010216
eax: ffffffff   ebx: df303f54   ecx: 0000000f   edx: 2d303031
esi: 2d303031   edi: df303f54   ebp: 00000010   esp: df303ef4
ds: 0018   es: 0018   ss: 0018
Process ifconfig (pid: 880, stackpage=df303000)
Stack: df303f54 00000001 00000000 00000000 c025e88f df303f54 c025eb73 
df303f54
       df303f54 c0290f70 df303f54 df303f64 00000010 00000009 df605d40 
00030002
       00000000 00000000 0028c301 00000000 00000002 0200a8c0 bfffb3c8 
08048d61
Call Trace:    [<c025e88f>] [<c025eb73>] [<c0290f70>] [<c02582e0>] 
[<c0258306>]
  [<c014616c>] [<c01073af>]

Code: ac ae 75 08 84 c0 75 f5 31 c0 eb 04 19 c0 0c 01 85 c0 89 d1


Please CC me, thanks.
-- 
Fridtjof Busse

