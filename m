Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132513AbQL3Ioh>; Sat, 30 Dec 2000 03:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130614AbQL3Io1>; Sat, 30 Dec 2000 03:44:27 -0500
Received: from barnowl.demon.co.uk ([158.152.23.247]:59908 "EHLO
	barnowl.demon.co.uk") by vger.kernel.org with ESMTP
	id <S132513AbQL3IoP>; Sat, 30 Dec 2000 03:44:15 -0500
Mail-Copies-To: never
To: linux-kernel@vger.kernel.org
Subject: Re: test13-pre6 (Fork Bug with Athlons? Temporary Fix)
In-Reply-To: <Pine.LNX.4.21.0012292156200.11714-200000@winds.org>
From: Graham Murray <graham@barnowl.demon.co.uk>
Date: 30 Dec 2000 08:13:02 +0000
In-Reply-To: <Pine.LNX.4.21.0012292156200.11714-200000@winds.org>
Message-ID: <m2snn6uy29.fsf@barnowl.demon.co.uk>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Byron Stanoszek <gandalf@winds.org> writes:

> I narrowed the problem down to a subset of patches from the MM set in
> test13-pre2. Reversing the attached 'context.patch' fixes the problem (only for
> i386), but I'm not yet sure why. test13-pre2 and up work without any problems
> on an Intel cpu (Pentium 180 & P3 800 tested).
[Snip] 
> root       351  0.0  1.2  9292 1576 ?        S    21:42   0:00 named
> root       361  0.0  0.0     0    0 ?        Z    21:42   0:00 [named <defunct>]
> root       363  0.0  1.2  9292 1576 ?        S    21:42   0:00 named
> root       364  0.0  1.2  9292 1576 ?        S    21:42   0:00 named
> root       365  0.0  0.7  2064  936 ?        S    21:42   0:00 /usr/sbin/sshd
> ..etc
> (Note PID 361)

I am seeing the same thing with the [named <defunct>] on a PIII 600,
so it is not Athlon specific. I haven't yet tried test13-pre6 but it
happens with pre3,4,5. So I am still running on test12.

I will try running pre6 then, if it still fails will try with your
context.patch and see if that fixes it.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
