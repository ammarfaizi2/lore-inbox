Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130799AbQJaXVF>; Tue, 31 Oct 2000 18:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130830AbQJaXUz>; Tue, 31 Oct 2000 18:20:55 -0500
Received: from chiara.elte.hu ([157.181.150.200]:49671 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S130799AbQJaXUw>;
	Tue, 31 Oct 2000 18:20:52 -0500
Date: Wed, 1 Nov 2000 01:27:42 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Cc: Pavel Machek <pavel@suse.cz>,
        "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <39FF2663.816B8E92@timpanogas.org>
Message-ID: <Pine.LNX.4.21.0011010122160.18143-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 31 Oct 2000, Jeff V. Merkey wrote:

> [...] These types of optimizations are possible when people have
> acccess to Intel Red Cover documents, [...]

optimizing away AGIs has been documented by public Intel PDFs for years:

 [...] Since the Pentium processor has two integer pipelines, a register
 used as the base or index component of an effective address calculation
 (in either pipe) causes an additional clock cycle if that register is the
 destination of either instruction from the immediately preceding clock
 cycle. This effect is known as Address Generation Interlock (AGI).

(ditto for the p6 core CPUs), and GCC (IIRC) tries to avoid AGI conflicts
as much as possible. (and this kind of stuff belongs into the compiler)

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
