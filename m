Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129410AbQKVTbT>; Wed, 22 Nov 2000 14:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129703AbQKVTa7>; Wed, 22 Nov 2000 14:30:59 -0500
Received: from hera.cwi.nl ([192.16.191.1]:62891 "EHLO hera.cwi.nl")
        by vger.kernel.org with ESMTP id <S129410AbQKVTay>;
        Wed, 22 Nov 2000 14:30:54 -0500
Date: Wed, 22 Nov 2000 20:00:49 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200011221900.UAA141657.aeb@aak.cwi.nl>
To: rmk@arm.linux.org.uk
Subject: Re: silly [< >] and other excess
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From rmk@flint.arm.linux.org.uk Wed Nov 22 19:20:52 2000

    > Andries.Brouwer@cwi.nl a écrit :
    > >  I also left something else
    > > that always annoyed me: valuable screen space (on a 24x80 vt)
    > > is lost by these silly [< >] around addresses in an Oops.
    > > They provide no information at all, but on the other hand
    > > cause loss of information because these lines no longer
    > > fit in 80 columns causing line wrap and the loss of the
    > > top of the Oops.]

    They provide no information to the human reader, but they tell klogd
    (and other tools) that the enclosed value is a kernel address that
    should be looked up in the System.map file and decoded into name +
    offset.

Of course. But since there is no information in [< >]
(their presence is syntactically determined, not semantically)
the tools you mention can be trivially patched to work without
this [< >] kludge. On the other hand, when the system panics
often klogd and similar nice programs do not run at all, and
hence are unable to do any good. All information available
is the information on the screen, and it is really a pity
to lose EIP and get a few parentheses instead.

Andries

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
