Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131661AbRCSXO3>; Mon, 19 Mar 2001 18:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131662AbRCSXOU>; Mon, 19 Mar 2001 18:14:20 -0500
Received: from colorfullife.com ([216.156.138.34]:32017 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S131661AbRCSXOI>;
	Mon, 19 Mar 2001 18:14:08 -0500
Message-ID: <001201c0b0ca$30eb1910$5517fea9@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "Rik van Riel" <riel@conectiva.com.br>
Cc: <linux-kernel@vger.kernel.org>, <torvalds@transmeta.com>
Subject: Re: 3rd version of R/W mmap_sem patch available
Date: Tue, 20 Mar 2001 00:13:14 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Besides, the fair semaphores would potentially slow things down, while
> this potentially speeds things up. So.. It looks obvious enough.
>

Rik, did you check that {pte,pmd}_alloc are thread safe? At least in
2.4.2 they aren't (include/asm-i386/pgalloc.h), and your patch doesn't
touch pgalloc.

{pte,pmd}_alloc are called from handle_mm_fault, and that function is
now running with down_read().
--

    Manfred



