Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283840AbRK3XzJ>; Fri, 30 Nov 2001 18:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283835AbRK3XzA>; Fri, 30 Nov 2001 18:55:00 -0500
Received: from sunfish.linuxis.net ([64.71.162.66]:43736 "HELO
	sunfish.linuxis.net") by vger.kernel.org with SMTP
	id <S283916AbRK3Xyl>; Fri, 30 Nov 2001 18:54:41 -0500
Date: Fri, 30 Nov 2001 15:50:22 -0800
To: linux-kernel@vger.kernel.org
Subject: 2.4.5 oops in VM
Message-ID: <20011130155022.I2009@flounder.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.21i
Mail-Copies-To: never
X-Delivery-Agent: TMDA v0.41/Python 2.1.1 (sunos5)
From: "Adam McKenna" <adam-dated-1007596224.7b8cf1@flounder.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sure this is probably not needed by now, but I had a 2.4.5 box crash
today.  It's already been upgraded to 2.4.14, but just in case this is
useful:

Bad swap file entry 80016464
VM: killing process oracle
kernel BUG at page_alloc.c:75
invalid operand: 0000
CPU:	1
EIP:	0010:[<c012b96e>]
EFLAGS:	00010286

eax: 0000001f	ebx: c2aaa910	ecx: 0000002e	edx: 00000002
esi: c2aaa938	edi: 00000000	ebp: 00000000	esp: c52abf64
as: 0018    es: 0018    ss:0018

process kswapd (pid:3, stackpage=c52ab000)
stack: c0239b26 c0239bf8 0000004b c2aaa910 c2aaa938 00000000 0000dfd7 00000000
       0000dfd7 00000018 00000000 c012abab c012c1f3 c012ad95 00000004 00000000
       00000000 0008e000 00000000 00000004 00000000 00024189 00000000 c012b3b9

call trace: [<c012ab8b>] [<c012df37>] [<c012as95>] [<c012b3b9>] [<c012b44b>]
[<c01054cc>]

code: 0f 0b 83 c4 0c 89 d8 2b 05 18 57 30 c0 69 c0 f1 f0 f0 f0 c1

--Adam
-- 
Adam McKenna <adam@flounder.net>   | GPG: 17A4 11F7 5E7E C2E7 08AA
http://flounder.net/publickey.html |      38B0 05D0 8BF7 2C6D 110A
