Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129807AbRATRpV>; Sat, 20 Jan 2001 12:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129901AbRATRpM>; Sat, 20 Jan 2001 12:45:12 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:11014 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S129807AbRATRow>;
	Sat, 20 Jan 2001 12:44:52 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200101201728.UAA04351@ms2.inr.ac.ru>
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
To: andrea@suse.de (Andrea Arcangeli)
Date: Sat, 20 Jan 2001 20:28:04 +0300 (MSK)
Cc: mingo@elte.hu, torvalds@transmeta.com, raj@cup.hp.com,
        linux-kernel@vger.kernel.org, davem@redhat.com
In-Reply-To: <20010119221327.C8717@athlon.random> from "Andrea Arcangeli" at Jan 19, 1 10:13:27 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> My argument applies to 2.4. The uncork _won't_ push on the wire the last
> not mss-sized fragment until it's the last one in the write queue even once
> cwnd and receiver window allows that. I think 

Look at the code again. You misread it.


> wouldn't be setting nonalge unconditionally to 1 in

You could guess that "1" in variable with name "nodelay" means nodelay. 8)

The checks for tcp_skb_is_last() have nothing to do with nagling.
Look into comments, they explain all the whys and whos.


> The manpage disagrees with you:

Do you jest?

This manpages is wrong, or, to be more exact, is incomplete,
which is common flaw of them.

get/set mean nothing but read-only/changing, i.e.
another important property missing in ioctl interface.

Andrea, how long do you use manpages when designing? 8)


> The BKL will be moved down in the next months

Excellent.

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
