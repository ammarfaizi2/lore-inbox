Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131840AbRAHIwd>; Mon, 8 Jan 2001 03:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132903AbRAHIwX>; Mon, 8 Jan 2001 03:52:23 -0500
Received: from mail.bancorp.ru ([195.239.131.101]:7429 "EHLO tarzan.bancorp.ru")
	by vger.kernel.org with ESMTP id <S131840AbRAHIwN>;
	Mon, 8 Jan 2001 03:52:13 -0500
Message-ID: <3A597E77.FF3011DD@raiden.bancorp.ru>
Date: Mon, 08 Jan 2001 11:46:47 +0300
From: "Sergey E. Volkov" <sve@raiden.bancorp.ru>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: VM subsystem bug in 2.4.0 ?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

I have a problem with 2.4.0

I'm testing Informix IIF-2000 database server running on dual Intel
Pentium II - 233. When I run 'make -j30 bzImage' in the kernel source,
my
Linux box hangs without any messages. This occurs when Informix is
running. When I stoped Informix and tryed to do the same, all passed ok!

I think this is bug in kernel ( VM subsystem ) code.

Informix allocate about to 50% of memory as LOCKED shared memory
segments. 

I'm thinking the reason in this. Kernel wants, but can't to swap out
locked shm's segments.

Thank you.

Sergey E. Volkov
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
