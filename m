Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130110AbRAJQBV>; Wed, 10 Jan 2001 11:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131001AbRAJQBB>; Wed, 10 Jan 2001 11:01:01 -0500
Received: from ns.sysgo.de ([213.68.67.98]:53998 "EHLO dagobert.svc.sysgo.de")
	by vger.kernel.org with ESMTP id <S130110AbRAJQAy>;
	Wed, 10 Jan 2001 11:00:54 -0500
Date: Wed, 10 Jan 2001 17:00:20 +0100 (MET)
From: Robert Kaiser <rob@sysgo.de>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Anybody got 2.4.0 running on a 386 ?
In-Reply-To: <Pine.LNX.4.30.0101100109270.11542-100000@e2>
Message-ID: <Pine.LNX.4.21.0101101640460.20028-100000@dagobert.svc.sysgo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jan 2001, Ingo Molnar wrote:

> math-FPU emulation takes up quite some space in the kernel image, so this
> could indeed be the case. Could you disable any non-boot-essential
> subsystem (networking, or the serial driver, or anything else), to
> significantly reduce the image size?
> 

I tried this: apparently no effect. However, there may be hardware
issues involved (see below).

> not really. Could you write a small function that just reads the kernel
> image from the first symbol to the last one, and see whether it crashes?
> (read it into a volatile variable to make sure GCC reads it.)

I tried this: Reading the entire image never caused any crashes.

However, I did have some (rare) instances of the kernel booting
successfully. Then it would fail again, booting the very same image
that had worked before.

I am beginning to suspect that I may be dealing with flaky hardware.
(I'm working from home today and I only have access to one of my 386
specimen here).

I guess I'll better shut up until I can double check on
some other 386 boards tomorrow....

In the meantime, it would be helpful if anyone who has successfully
booted a 2.4.0 kernel on a 386 could report this to the list.

----------------------------------------------------------------
Robert Kaiser                          email: rkaiser@sysgo.de
SYSGO RTS GmbH
Am Pfaffenstein 14
D-55270 Klein-Winternheim / Germany    fax:   (49) 6136 9948-10

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
