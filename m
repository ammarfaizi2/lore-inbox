Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130524AbQK1DlE>; Mon, 27 Nov 2000 22:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130561AbQK1Dkz>; Mon, 27 Nov 2000 22:40:55 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:41632 "EHLO
        fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
        id <S130524AbQK1Dkt>; Mon, 27 Nov 2000 22:40:49 -0500
From: kumon@flab.fujitsu.co.jp
Date: Tue, 28 Nov 2000 12:10:33 +0900
Message-Id: <200011280310.MAA27358@asami.proc.flab.fujitsu.co.jp>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Michael Meissner <meissner@spectacle-pond.org>,
        "David S. Miller" <davem@redhat.com>, Werner.Almesberger@epfl.ch,
        adam@yggdrasil.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0"
In-Reply-To: <20001127200618.A19980@athlon.random>
In-Reply-To: <200011270556.VAA12506@baldur.yggdrasil.com>
        <20001127094139.H599@almesberger.net>
        <200011270839.AAA28672@pizda.ninka.net>
        <20001127182113.A15029@athlon.random>
        <20001127123655.A16930@munchkin.spectacle-pond.org>
        <20001127200618.A19980@athlon.random>
Reply-To: kumon@flab.fujitsu.co.jp
Cc: kumon@flab.fujitsu.co.jp
X-Mailer: Handmade Mailer version 1.0
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli writes:
 > I'd like if it will be written explicitly in the specs that it's forbidden to
 > rely on that. I grepped the specs and I didn't find anything. So I wasn't sure
 > if I missed the information in the specs or not. I never investigated on it

If you have two files:
test1.c:
int a,b,c;

test2.c:
int a,c;

Which is _stronger_?


If somebody adds such a file to the kernel tree, the layout is changed
by link orderling, irrelevant option on/off or other magical
environments. Spec doesn't say anything about the layout of the
variables.

--
Computer Systems Laboratory, Fujitsu Labs.
kumon@flab.fujitsu.co.jp
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
