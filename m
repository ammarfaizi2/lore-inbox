Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129367AbRAYTaV>; Thu, 25 Jan 2001 14:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129431AbRAYTaB>; Thu, 25 Jan 2001 14:30:01 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:7951 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S129274AbRAYT3q>;
	Thu, 25 Jan 2001 14:29:46 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200101251929.WAA10001@ms2.inr.ac.ru>
Subject: Re: [UPDATE] Zerocopy patches, against 2.4.1-pre10
To: andrewm@uow.EDU.AU (Andrew Morton)
Date: Thu, 25 Jan 2001 22:29:14 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A6F8415.8EC5DB23@uow.edu.au> from "Andrew Morton" at Jan 25, 1 04:45:00 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> no problems.  I simply mounted an NFS server with rsize=wsize=8192
> and read a few files - I assume this is sufficient?

This is orthogonal.

Only TCP uses this and you need not to do something special
to test it. Any TCP connection going through 3c tests it.


> rather than using the IS_CYCLONE stuff.  Then we can add cards
> individually as confirmation comes in.

Seems, you meaned opposite way. To add this flag to all the chips,
except for several, and to remove it as soon as it is "confirmed"
that it does not work. 8)

Also, please, reset the state. Until this snapshot, hw checksumming
did not work due to bugs in netfilter, so that all the reports about
failures to checksum are dubious.

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
