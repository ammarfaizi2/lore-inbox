Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265681AbSLXSmW>; Tue, 24 Dec 2002 13:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265727AbSLXSmW>; Tue, 24 Dec 2002 13:42:22 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16402 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265681AbSLXSmV>; Tue, 24 Dec 2002 13:42:21 -0500
Date: Tue, 24 Dec 2002 10:51:11 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
cc: Stephen Rothwell <sfr@canb.auug.org.au>,
       Petr Vandrovec <vandrove@vc.cvut.cz>, <lk@tantalophile.demon.co.uk>,
       Ingo Molnar <mingo@elte.hu>, <drepper@redhat.com>,
       <bart@etpmod.phys.tue.nl>, <davej@codemonkey.org.uk>,
       <hpa@transmeta.com>, <terje.eggestad@scali.com>,
       <matti.aarnio@zmailer.org>, <hugh@veritas.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <20021224090520.A19829@bitwizard.nl>
Message-ID: <Pine.LNX.4.44.0212241049100.1230-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 24 Dec 2002, Rogier Wolff wrote:
>
> Ehmm, Linus,
>
> Why do you want to align the return point? Why are jump-targets aligned?
> Because they are faster. But why are they faster? Because the
> cache-line fill is more efficient: the CPU might execute those
> instructions, while it has a smaller chance of hitting  the instructions
> before the target.

Actually, no. Many CPU's apparently also have issues with instruction
decoding etc, where certain alignments (4 or 8-byte aligned) are better
simply because they feed the decode logic more efficiently.

Everything here fits in one cache-line, so clearly the cacheline issues
don't matter.

		Linus

