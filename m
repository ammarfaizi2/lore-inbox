Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbTE2Ky6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 06:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbTE2Ky6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 06:54:58 -0400
Received: from [62.75.136.201] ([62.75.136.201]:17890 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S262136AbTE2Ky5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 06:54:57 -0400
Message-ID: <3ED5E9E7.5070602@g-house.de>
Date: Thu, 29 May 2003 13:07:19 +0200
From: Christian <evil@g-house.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.4b) Gecko/20030507
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: IPv6 module oopsing on 2.5.69
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

while booting the ipv6 module gets installed, along with this message in 
the log:

prinz kernel: IPv6 v0.8 for NET4.0
prinz kernel: ------------[ cut here ]------------
prinz kernel: kernel BUG at include/linux/module.h:284!
prinz kernel: invalid operand: 0000 [#1]
prinz kernel: CPU:    0
prinz kernel: EIP:    0060:[<e5b983e8>]    Tainted: P
prinz kernel: EFLAGS: 00010246
prinz kernel: eax: 00000000   ebx: 00000000   ecx: d8872e40   edx: d916eb80
prinz kernel: esi: 0000003a   edi: e5bbfc60   ebp: d916eb80   esp: dc763efc
prinz kernel: ds: 007b   es: 007b   ss: 0068
prinz kernel: Process modprobe (pid: 917, threadinfo=dc762000 task=d8cb5300)
prinz kernel: Stack: e5bc1800 d916eb80 0000039c df109d70 00000001 
0000000a ffffff9f d8872e40
prinz kernel: c025bc90 d8872e40 0000003a 416d9c90 e5bc1060 00000000 
dffdadc0 00000003
prinz kernel: c0121765 e5bc1000 dffdadc0 dffdadc0 00000000 c030d698 
e5bc1800 00000000
prinz kernel: Call Trace: [<e5bc1800>]  [<c025bc90>]  [<e5bc1060>] 
[<c0121765>]  [<e5bc1000>]  [<e5bc1800>]  [<e498c82d>]  [<e5bc2388>] 
[<e5bc1800>]  [<e498c1bd>]  [<e5bbfc48>]  [<c01318ff>]  [<e5bc1800>] 
[<c0109137>]
prinz kernel: Code: 0f 0b 1c 01 78 d0 bb e5 e9 d6 fd ff ff 0f 0b 1e 01 
8f d0 bb


IPv6 support is not useable then, a single run of the "ping6" binary 
(even without options) gives a segfault. the machine is a Athlon 900,
running debian/testing (glibc 2.3.1), one tainted module (nvidia) 
loaded. more info available on demand.

i am a user only, so please don't expect patches from me :-(

Thank you,
Christian.

