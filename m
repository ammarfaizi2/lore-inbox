Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129444AbRATTTE>; Sat, 20 Jan 2001 14:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129729AbRATTSy>; Sat, 20 Jan 2001 14:18:54 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:48646 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S129444AbRATTSl>;
	Sat, 20 Jan 2001 14:18:41 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200101201905.WAA05165@ms2.inr.ac.ru>
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
To: andrea@suse.de (Andrea Arcangeli)
Date: Sat, 20 Jan 2001 22:05:45 +0300 (MSK)
Cc: mingo@elte.hu, torvalds@transmeta.com, raj@cup.hp.com,
        linux-kernel@vger.kernel.org, davem@redhat.com
In-Reply-To: <20010120192320.J8717@athlon.random> from "Andrea Arcangeli" at Jan 20, 1 07:23:20 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> semantics of snd_sml), maybe it makes the difference but then I don't see how.

It makes. One small packet is allowed to fly, not depending on packets_out.
This is idea of Minshall.

"Classic" Nagle also does not prohibit this, but it is difficult
to formulate it in terms of presegmented queue, used in linux,
so that we preferred Minshall's approach.

Third algo, used by linux-2.2: "queue as soon as packet is small
and packets_out!=0" is _not_ Nagle's one, it is surely wrong.

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
