Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129282AbRAZTo2>; Fri, 26 Jan 2001 14:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129706AbRAZToS>; Fri, 26 Jan 2001 14:44:18 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:61963 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S129282AbRAZToI>;
	Fri, 26 Jan 2001 14:44:08 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200101261943.WAA28202@ms2.inr.ac.ru>
Subject: Re: [UPDATE] Zerocopy patches, against 2.4.1-pre10
To: ionut@cs.columbia.EDU (Ion Badulescu), davem@redhat.com (Dave Miller)
Date: Fri, 26 Jan 2001 22:43:05 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0101251253300.20615-100000@age.cs.columbia.edu> from "Ion Badulescu" at Jan 26, 1 00:15:01 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> drivers use it at this time, I see a grand total of 2 (hamachi and hme) in

Plus acenic in zerocopy.
Plus patch to do this is available for eepro100.


> I'm just wondering, if a card supports sg but *not* TX csum, is it worth
> it to make use of sg? eepro100 falls into this category..

This is simply not permitted just now.

Mea culpa...

Dave, seems, it is better to repair this. Code really assumes
that SG cannot be used without one of CSUM flags...

Actually, drivers which are able to SG without checksumming
should do this. Even though just this minute this feature
has no applications. Next minute it will. Not only with decnet,
but for IP too.

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
