Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272703AbRI3GuQ>; Sun, 30 Sep 2001 02:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272717AbRI3GuG>; Sun, 30 Sep 2001 02:50:06 -0400
Received: from msa2.hinet.net ([168.95.4.212]:54165 "EHLO msa2.hinet.net")
	by vger.kernel.org with ESMTP id <S272703AbRI3Gtx>;
	Sun, 30 Sep 2001 02:49:53 -0400
Message-ID: <001e01c1497c$24934c50$b9c3fea9@w2ktakeon2>
From: "Takeo Saito" <kernel@tranda.com.tw>
To: <fdavis@si.rr.com>, <linux-kernel@vger.kernel.org>
Cc: <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <3BB6933A.5010905@si.rr.com>
Subject: Re: 2.4.9-ac18: __cpu_raise_softirq constantly redefined
Date: Sun, 30 Sep 2001 14:50:06 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

You can remove this define on interrupt.h,
because the define on ac-17 is bellow:
-----------------------------------------------------------------------
#ifndef __cpu_raise_softirq
#define __cpu_raise_softirq(cpu, nr) \
                do { softirq_pending(cpu) |= 1UL << (nr); } while (0)
#endif
-----------------------------------------------------------------------

but on ac-18 is bellow:
-----------------------------------------------------------------------
#define __cpu_raise_softirq(cpu, nr) do { softirq_pending(cpu) |= 1UL <<
(nr); } while (0)
-----------------------------------------------------------------------

Best Regrads,
---
Takeo Tung (Takeo Saito)

----- Original Message -----
From: "Frank Davis" <fdavis@si.rr.com>
To: <linux-kernel@vger.kernel.org>
Cc: <alan@lxorguk.ukuu.org.uk>
Sent: Sunday, September 30, 2001 11:36 AM
Subject: 2.4.9-ac18: __cpu_raise_softirq constantly redefined


> Hello,
>      While building 2.4.9-ac18, I constantly received the warning that '
> __cpu_raise_softirq redefined'. I didn't notice the warning while
> building 2.4.9-ac17.
>
> gcc version 2.91.66
>
> Regards,
> Frank
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

