Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129696AbQKESIe>; Sun, 5 Nov 2000 13:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129821AbQKESIO>; Sun, 5 Nov 2000 13:08:14 -0500
Received: from priv6.onet.pl ([213.180.128.83]:27923 "EHLO friko6.onet.pl")
	by vger.kernel.org with ESMTP id <S129696AbQKESIK>;
	Sun, 5 Nov 2000 13:08:10 -0500
Message-ID: <002001c04753$818e05c0$0b00a8c0@Standard>
From: "Maciej Hrebien" <m_hrebien@poczta.onet.pl>
To: <linux-kernel@vger.kernel.org>
Subject: linux-2.4.0-test7 bug
Date: Sun, 5 Nov 2000 19:09:12 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Compiling linux kernel using gcc-2.95.2 I've received some errors in emd.c
file. That was in 145 line and similar bug in 264 line.

gcc has problems with binary - :

int part = (page_address(page) + PAGE_CACHE_SIZE) - p->spare;

I think that there must be explicit casting to int, like this:

int part = (int)(page_address(page) + PAGE_CACHE_SIZE) - (int)p->spare;

and there won't be errors in compile time.

BFN
            Maciej Hrebien


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
