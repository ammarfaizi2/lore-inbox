Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130271AbRATUWp>; Sat, 20 Jan 2001 15:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131633AbRATUWg>; Sat, 20 Jan 2001 15:22:36 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:2823 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S130271AbRATUWZ>;
	Sat, 20 Jan 2001 15:22:25 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200101202022.XAA05556@ms2.inr.ac.ru>
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
To: torvalds@transmeta.COM (Linus Torvalds)
Date: Sat, 20 Jan 2001 23:22:14 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10101201138100.10317-100000@penguin.transmeta.com> from "Linus Torvalds" at Jan 20, 1 10:45:00 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> > 	write(100000*MSS)
> > 	write(1)
> > 	write(1)
...
> As far as I can tell, the second "write(1)" will always merge with the
> first one

This would be true, if Andrea wrote not exactly 100000*MSS,
but 100000*MSS+1 or just write(<lots of data>).

In some exceptional situations (sort of writing exactly N*MSS,
then remnant, then something) Minshall's and bsd coalescing
are a bit different.

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
