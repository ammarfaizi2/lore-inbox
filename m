Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285053AbRLRUaN>; Tue, 18 Dec 2001 15:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285067AbRLRUaD>; Tue, 18 Dec 2001 15:30:03 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:20487 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S285053AbRLRU3o>;
	Tue, 18 Dec 2001 15:29:44 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200112182029.XAA11287@ms2.inr.ac.ru>
Subject: ARM: Re: TCP LAST-ACK state broken in 2.4.17-pre2 [NEW DATA]
To: Mika.Liljeberg@welho.com (Mika Liljeberg)
Date: Tue, 18 Dec 2001 23:29:06 +0300 (MSK)
Cc: Mika.Liljeberg@nokia.com, davem@redhat.com, linux-kernel@vger.kernel.org,
        sarolaht@cs.helsinki.fi, rmk@arm.linux.ORG.UK
In-Reply-To: <3C1FA558.E889A00D@welho.com> from "Mika Liljeberg" at Dec 18, 1 10:21:44 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> It's ARM in little endian mode.

I think it is answer to the question.

No doubts it still has broken misaligned access.


> Now that you mention it, tcp_parse_options() in input.c seems to expect
> that the timestamps are word aligned,

Nope. It does not expect any alignment, but it is really supposed
to penalise misbehaving cases.

Alexey
