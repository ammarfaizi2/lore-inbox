Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129413AbRAXUZO>; Wed, 24 Jan 2001 15:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129444AbRAXUYy>; Wed, 24 Jan 2001 15:24:54 -0500
Received: from [192.203.80.144] ([192.203.80.144]:29445 "HELO kaiser.inr.ac.ru")
	by vger.kernel.org with SMTP id <S129413AbRAXUYv>;
	Wed, 24 Jan 2001 15:24:51 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200101242003.XAA21040@ms2.inr.ac.ru>
Subject: Re: Linux 2.2.16 through 2.2.18preX TCP hang bug triggered by rsync
To: manfred@colorfullife.COM (Manfred Spraul)
Date: Wed, 24 Jan 2001 23:03:34 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A6E02E6.B3261E1@colorfullife.com> from "Manfred Spraul" at Jan 24, 1 11:15:01 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> I read through the tcpdump, and it seems that Linux completely ignores
> packets with out-of-window sequence numbers:

Yes, Linux is __very__ not right doing this. RFC requires to accept
ACK, URG and RST on any segment adjacent to window, even if window
is zero.

Solaris also does thing, formally wrong, but it would work if linux
would be formally correct.

O-ho-ho... It is difficult bug.

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
