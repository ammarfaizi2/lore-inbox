Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272247AbRIKBd1>; Mon, 10 Sep 2001 21:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272253AbRIKBdR>; Mon, 10 Sep 2001 21:33:17 -0400
Received: from [209.247.180.230] ([209.247.180.230]:63240 "HELO RAS-SERVER")
	by vger.kernel.org with SMTP id <S272247AbRIKBdE>;
	Mon, 10 Sep 2001 21:33:04 -0400
From: "Bao C. Ha" <baoha@sensoria.com>
To: <linux-kernel@vger.kernel.org>
Subject: Different old_mmap behavior between  2.4.5 and 2.4.8
Date: Mon, 10 Sep 2001 18:30:55 -0700
Message-ID: <028701c13a61$67bf17e0$456c020a@SENSORIA>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Importance: Normal
X-GCMulti: 1
X-SMTP-Server: PostCast Server 1.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We are moving from kernel 2.4.5 to kernel 2.4.8 and above.
One of our applications broke due to different behaviors
of the system call old_mmap.

In kernel 2.4.5:
307   old_mmap(0x7b7f7000, 36864, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7b7f7000

In kernel 2.4.8:
[pid   313] old_mmap(0x7b7f7000, 36864, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7b7f8000

In 2.4.5, we request 0x7b7f7000 and get the same area back.
In 2.4.8, we also request 0x7b7f7000, but we are getting a
different area pointed by 0x7b7f8000.

Is this supposed to be the correct behavior?  What changes 
make the newer kernels to return different pointers?  We
are running on the sh4 architecture but I think these calls
come from malloc() which should be arch-independent.

Appreciate any pointers/suggestions.

Thanks.
Bao

