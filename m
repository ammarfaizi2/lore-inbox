Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131056AbQKLQAo>; Sun, 12 Nov 2000 11:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131102AbQKLQAe>; Sun, 12 Nov 2000 11:00:34 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:29445 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S131041AbQKLQAY>;
	Sun, 12 Nov 2000 11:00:24 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200011121600.TAA17075@ms2.inr.ac.ru>
Subject: Re: Missing ACKs with Linux 2.2/2.4?
To: ak@suse.de (Andi Kleen)
Date: Sun, 12 Nov 2000 18:59:27 +0300 (MSK)
Cc: ak@suse.de, linux-kernel@vger.rutgers.edu
In-Reply-To: <20001112163538.A10339@gruyere.muc.suse.de> from "Andi Kleen" at Nov 12, 0 04:35:38 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> The probability of just exactly the zero packet hitting you is very small.

... long laughter ...

Andi, I see you are not very strong in methematics. 8)
Timestamp is not a random number, so that probability of PAWS failure
does not depend on restricting it at all. The only thing which can help
to reduce probability is dropping all tpacket with ts_val==0
or shutting down your machine while time of your peers passes through zero. 8)

BTW I looked to netbsd and certainly did not find any signs of said by you.
They drop packet with ts_val before ts_recent, even if ts_val is zero.

They really have bug, considering zero value of ts_recent as invalid one.
This make PAWS something absolutely useless. 8)

Alexey

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
