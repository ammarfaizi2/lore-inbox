Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264446AbRFXTqL>; Sun, 24 Jun 2001 15:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264433AbRFXTqB>; Sun, 24 Jun 2001 15:46:01 -0400
Received: from femail14.sdc1.sfba.home.com ([24.0.95.141]:50160 "EHLO
	femail14.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S264432AbRFXTpq>; Sun, 24 Jun 2001 15:45:46 -0400
Date: Sun, 24 Jun 2001 15:45:44 -0400
From: Tom Vier <tmv5@home.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.5-ac17 swapoff machine check
Message-ID: <20010624154544.A863@zero>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i had about 50megs of swap "used" when i ran swapoff -a. that trigger two
machine checks, but the box stayed up and seemed none the worse. here's the
syslog.

Jun 24 12:55:54 zero kernel: CIA machine check: vector=0x670 pc=0xfffffc00008470b8 code=0x98
Jun 24 12:55:54 zero kernel: machine check type: processor detected hard error
Jun 24 12:55:54 zero kernel: pc = [__get_swap_page+120/832]  ra = [try_to_swap_out+656/896]  ps = 0000
Jun 24 12:55:54 zero kernel: v0 = 0000000000000001  t0 = 0000000000000000  t1 = 0000000149177150
Jun 24 12:55:54 zero kernel: t2 = fffffc0000ace084  t3 = fffffc0149c77c58  t4 = 0000000000000001
Jun 24 12:55:54 zero kernel: t5 = ffffffffffffffff  t6 = 00000000041d17d1  t7 = fffffc001ffe4000
Jun 24 12:55:54 zero kernel: a0 = fffffc001ffe7ce0  a1 = 0000000000000001  a2 = fffffc00008428b0
Jun 24 12:55:54 zero kernel: a3 = fffffc0016563ff8  a4 = fffffc0000cf1460  a5 = 0000000000000000
Jun 24 12:55:54 zero kernel: t8 = 0000000000000000  t9 = fffffc0000b00b08  t10= fffffc0000ace084
Jun 24 12:55:54 zero kernel: t11= 0000000010745f44  pv = fffffc0000847040  at = fffffc0000acf208
Jun 24 12:55:54 zero kernel: gp = fffffc0000ac53a0  sp = fffffc001ffe7ca0
Jun 24 12:55:54 zero kernel: CIA machine check: vector=0x670 pc=0xfffffc0000847330 code=0x98
Jun 24 12:55:54 zero kernel: machine check type: processor detected hard error
Jun 24 12:55:54 zero kernel: pc = [__get_swap_page+752/832]  ra = [try_to_swap_out+656/896]  ps = 0000
Jun 24 12:55:54 zero kernel: v0 = 0000000000000001  t0 = 0000000000000000  t1 = 0000000149177150
Jun 24 12:55:54 zero kernel: t2 = fffffc0000ace084  t3 = fffffc0149c77c58  t4 = 0000000000000001
Jun 24 12:55:54 zero kernel: t5 = ffffffffffffffff  t6 = 0000000000000000  t7 = fffffc001ffe4000
Jun 24 12:55:54 zero kernel: a0 = fffffc001ffe7ce0  a1 = 0000000000000001  a2 = fffffc00008428b0
Jun 24 12:55:54 zero kernel: a3 = fffffc0016563ff8  a4 = fffffc0000cf1460  a5 = 0000000000000000
Jun 24 12:55:54 zero kernel: t8 = 0000000000000000  t9 = fffffc0000b00b08  t10= fffffc0000ace084
Jun 24 12:55:54 zero kernel: t11= 0000000010745f44  pv = fffffc0000847040  at = fffffc0000acf208
Jun 24 12:55:54 zero kernel: gp = fffffc0000ac53a0  sp = fffffc001ffe7ca0


-- 
Tom Vier <tmv5@home.com>
DSA Key id 0x27371A2C
