Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265480AbSLMVon>; Fri, 13 Dec 2002 16:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265484AbSLMVon>; Fri, 13 Dec 2002 16:44:43 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:31152 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S265480AbSLMVom>; Fri, 13 Dec 2002 16:44:42 -0500
Message-Id: <4.3.2.7.2.20021213224832.00b58670@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Fri, 13 Dec 2002 22:52:53 +0100
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: Re: Intel P6 vs P7 system call performance
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm Apples & Oranges

diff hanoi.c hanoi2.c
17a18
 > void  mov();
51c52
<               mov(disk,1,3);
---
 >               (void)mov(disk,1,3);
58c59
< mov(n,f,t)
---
 > void mov(n,f,t)
67,69c68,70
<       mov(n-1,f,o);
<       mov(1,f,t);
<       mov(n-1,o,t);
---
 >       (void)mov(n-1,f,o);
 >       (void)mov(1,f,t);
 >       (void)mov(n-1,o,t);


cc -O3 -march=i686 -mcpu=i686 -fomit-frame-pointer  hanoi.c -o hanoi
cc -O3 -march=i686 -mcpu=i686 -fomit-frame-pointer  hanoi2.c -o hanoi2
./hanoi 10
536837 loops
./hanoi 10
538709 loops
./hanoi2 10
850127 loops
./hanoi2 10
852651 loops

Huu ?

Margit 

