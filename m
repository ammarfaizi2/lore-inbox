Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132255AbQLPSWa>; Sat, 16 Dec 2000 13:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132253AbQLPSWT>; Sat, 16 Dec 2000 13:22:19 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:6920 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132252AbQLPSWH>; Sat, 16 Dec 2000 13:22:07 -0500
Date: Sat, 16 Dec 2000 09:51:00 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Harald Welte <laforge@gnumonks.org>
cc: linux-kernel@vger.kernel.org, "Barry K. Nathan" <barryn@pobox.com>,
        Rusty Russell <rusty@linuxcare.com>, Marc Boucher <marc@mbsi.ca>,
        James Morris <jmorris@intercode.com.au>
Subject: Re: test13pre2 - netfilter modiles compile failure
In-Reply-To: <20001216140941.A7422@coruscant.gnumonks.org>
Message-ID: <Pine.LNX.4.10.10012160946450.21362-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 16 Dec 2000, Harald Welte wrote:
> 
> well... the 'true library' doesn't make sense, because of the exclusiveness.
> In any case there's only one instance of ip_fw_compat inside the kernel:

The patch looks fine, and thanks for the commentary on why it was done
this way.

The other module problem (the fact that nfsd and nfs didn't resolve the
symbols in lockd, and couldn't be used as modules for that reason) seems
to be due to the "EXPORT_NO_SYMBOLS" in fs/lockd/svc.c. Thanks to Keith
Owens for debugging that one (which looks like a potential bug in "ld",
actually).

Can anybody else find build irregularities with the new Makefiles? Please
holler..

	Thanks,
		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
