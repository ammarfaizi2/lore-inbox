Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131735AbQKXFvb>; Fri, 24 Nov 2000 00:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131764AbQKXFvV>; Fri, 24 Nov 2000 00:51:21 -0500
Received: from hera.cwi.nl ([192.16.191.1]:64484 "EHLO hera.cwi.nl")
        by vger.kernel.org with ESMTP id <S131735AbQKXFvM>;
        Fri, 24 Nov 2000 00:51:12 -0500
Date: Fri, 24 Nov 2000 06:20:33 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200011240520.GAA143373.aeb@aak.cwi.nl>
To: greg@linuxpower.cx, viro@math.psu.edu
Subject: gcc-2.95.2-51 is buggy
Cc: Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk, bernds@redhat.com,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> ... RedHat's GCC snapshot "2.96" handles this case just fine.

> Now, if you can isolate the relevant part of the diff between
> 2.95.2 and RH 2.96...

Maybe I have to be more precise in the statement "gcc 2.95.2 is buggy".

I just installed gcc 2.95.2 freshly ftp'ed from ftp.gnu.org, and

% /usr/bin/gcc -v
Reading specs from /usr/lib/gcc-lib/i486-suse-linux/2.95.2/specs
gcc version 2.95.2 19991024 (release)
% /usr/bin/gcc -Wall -O2 -o bug bug.c; ./bug
0x84800000
% /usr/gcc/aeb/bin/gcc -v
Reading specs from /usr/gcc/aeb/lib/gcc-lib/i686-pc-linux-gnu/2.95.2/specs
gcc version 2.95.2 19991024 (release)
% /usr/gcc/aeb/bin/gcc -Wall -O2 -o nobug bug.c; ./nobug
0x0

So, not all versions of gcc 2.95.2 are equal.

% rpm -qf /usr/bin/gcc
gcc-2.95.2-51

This is from a SuSE distribution, I forget which, not very recent.
Revised summary: gcc-2.95.2-51 from SuSE is buggy.

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
