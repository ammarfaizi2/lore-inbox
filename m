Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277541AbRJOSlH>; Mon, 15 Oct 2001 14:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277866AbRJOSk5>; Mon, 15 Oct 2001 14:40:57 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:49668 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S277541AbRJOSku>;
	Mon, 15 Oct 2001 14:40:50 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200110151840.WAA24000@ms2.inr.ac.ru>
Subject: Re: TCP acking too fast
To: Mika.Liljeberg@welho.com (Mika Liljeberg)
Date: Mon, 15 Oct 2001 22:40:52 +0400 (MSK DST)
Cc: ak@muc.de, davem@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <3BC9F029.3897ABE5@welho.com> from "Mika Liljeberg" at Oct 14, 1 11:06:01 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Well, I think this "problem" is way overstated.

Understated. :-)

Actually, people who designed all this engine always kept in the mind
only two cases: ftp and telnet. Who did care that some funny
protocols sort of smtp work thousand times slower than they could?
Nobody. Until the time when mail agents started to push really
lots of mails.

> Besides, as I said, you can always disable Nagle

And you will finish with Nagle enabled only on ftp-data. I do not know
another standard protosols which are not broken by delack+nagle. :-)

This is sad but this is already truth: apache, samba etc, even ssh(!),
each of them disable nagle by default, even despite of they are able
to cure this problem with less of damage.

Well, I answered to the question: "tcp is slow!" --- "Guy, you forgot
to enable TCP_NODELAY. TCP is not supposed to work well in your case
without this" so much of times, that started to suspect that nagling
must be disabled by default. It would cause less of troubles. :-)

Alexey
