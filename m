Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263311AbTFWPEl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 11:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263945AbTFWPEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 11:04:40 -0400
Received: from [62.75.136.201] ([62.75.136.201]:20115 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S263311AbTFWPEj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 11:04:39 -0400
Message-ID: <3EF71A54.7010909@g-house.de>
Date: Mon, 23 Jun 2003 17:18:44 +0200
From: Christian Kujau <evil@g-house.de>
Reply-To: evil@g-house.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.4b) Gecko/20030507
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: kernel BUG at jfs_dmap.c:776 (2.4.21)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

while doing some benchmarks, i noticed a segfault when trying to mount a 
newly created JFS. mkfs.jfs passes, but mount gives:


BUG at jfs_dmap.c:776 assert(hint < mapSize)
kernel BUG at jfs_dmap.c:776!
mount(1055): Kernel Bug 1
pc = [<fffffffc003236b4>]  ra = [<fffffffc003236a8>]  ps = 0000    Not 
tainted
v0 = 000000000000001e  t0 = 0000000000000001  t1 = 0000000000000000
t2 = fffffc00011d2948  t3 = 0000000000000000  t4 = ffffffff00000000
t5 = 0000000000000001  t6 = 343c0a29657a6953  t7 = fffffc0002cf8000
a0 = 0000000000000000  a1 = 0000000000000001  a2 = 0000000000000001
a3 = 0000000000000001  a4 = 0000000000000001  a5 = 0000000000000002
t8 = 0000000000000004  t9 = 0000000000001c0e  t10= 0000000000001c0f
t11= fffffc00011f0988  pv = fffffc000101fb90  at = fffffc00011f0988
gp = fffffffc00347c88  sp = fffffc0002cfb9e8
Trace:fffffc0001029f50 fffffc0001053b88 fffffc0001054838 
fffffc000103e1ac fffffc00010168b0 fffffc000105808c fffffc00010585a4 
fffffc0001058434 fffffc0001070b28 fffffc0001070f3c fffffc0001070d18 
fffffc000107155c fffffc0001071538 fffffc0001010d30 fffffc0001010c88
Code: 22106a0c  47e90411  6b5b4106  27ba0002  23bd45e0  00000081 
<c3fffecb> 47ff041f


this is with vanilla 2.4.21 (Alpha), compiled with gcc3.3, glibc 2.3.1,
util-linux 2.11z.


thanks,
Christian.

