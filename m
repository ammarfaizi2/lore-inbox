Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129524AbQLRNEs>; Mon, 18 Dec 2000 08:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130247AbQLRNEi>; Mon, 18 Dec 2000 08:04:38 -0500
Received: from hera.cwi.nl ([192.16.191.1]:17566 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S129524AbQLRNEd>;
	Mon, 18 Dec 2000 08:04:33 -0500
Date: Mon, 18 Dec 2000 13:33:53 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200012181233.NAA176015.aeb@aak.cwi.nl>
To: koenig@tat.physik.uni-tuebingen.de, torvalds@transmeta.com
Subject: Re: BUG: isofs broken (2.2 and 2.4)
Cc: Andries.Brouwer@cwi.nl, aeb@veritas.com, emoenke@gwdg.de, eric@andante.org,
        kobras@tat.physik.uni-tuebingen.de, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From koenig@orion.tat.physik.uni-tuebingen.de Mon Dec 18 11:34:14 2000

    On Nov 17, Linus Torvalds wrote:

    > ...

    better you'd have tested it;)  while Andries' patch works fine (2 CDs of
    data copied and checked a bit, seems to work ok with no obvious problems)
    your new patch still shows a number of problems:

    I've got a SIGSEGV in "find" and ...

Ah yes, but Nov 17 and 2.4.0test10 is ancient history.
You do not mention a kernel version, but if it is older
than 2.4.0test12, upgrade.

(Before 2.4.0test11: a few complaints. On 2.4.0test11: a deluge
of complaints. On later kernels: one or two complaints. Must still
look at the case where someone has problems with isofs over nfs -
maybe this is nfs-related, not isofs-related.)

(The story here was interesting: Linus' patch did part of the
work required, good enough for most people. Nevertheless there were
many complaints, and it turned out that gcc 2.95.2 mistranslated
the code. Removing a superfluous line made things work again,
leaving us worried how many other problems in kernel and user
software are caused by this compiler bug. Then I added the part of
my patch that Linus hadnt done yet, so now all should be well again.)

Andries

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
