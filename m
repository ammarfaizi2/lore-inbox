Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131514AbRAIXo2>; Tue, 9 Jan 2001 18:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131385AbRAIXoT>; Tue, 9 Jan 2001 18:44:19 -0500
Received: from hera.cwi.nl ([192.16.191.1]:2750 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S132678AbRAIXn1>;
	Tue, 9 Jan 2001 18:43:27 -0500
Date: Wed, 10 Jan 2001 00:43:24 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200101092343.AAA149309.aeb@texel.cwi.nl>
To: Andries.Brouwer@cwi.nl, maillist@chello.nl
Subject: Re: 2.2.18 and Maxtor 96147H6 (61 GB)
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Igmar Palsenberg <maillist@chello.nl>

    > > 2.2.18 sometimes sees 61 GB, sometimes 32 GB.
    > > I don't call that hard to understand.
    > 
    > The same kernel has varying behaviour?
    > Maybe not hard to understand, but rather surprising.
    > You are the first to report nondeterministic behaviour.

    You're not the only one that is suprised :

    1) Put disk in my machine (target machine hangs itself with the disk)
    2) use setmax to set the limit to 32 GB
    3) Put the disk in the target machine
    4) System boots, linux sees 64GB
    5) rebooted system, system hangs due to the soft clippig 'vanished'

    I even had occurences of the kernel setmax message showing up, and after a
    plain reboot it didn't.

    It beats me.. I can't explain, and the machine is rock solid now.

Probably you confused the proper way to use ibmsetmax with
the proper way to use setmax. For setmax, and a Maxtor disk,
you do not use a different machine, put the jumper to clip,
now the boot succeeds, and you let Linux unclip.
Either with a patched kernel that knows about these things
or with a utility run from a boot script.
(It is most convenient to have a partition boundary where
the jumper clips, so that with old kernels and without running
the utility you also have a valid filesystem.)

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
