Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266733AbSLQTgA>; Tue, 17 Dec 2002 14:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266953AbSLQTgA>; Tue, 17 Dec 2002 14:36:00 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:40967 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266733AbSLQTf7>; Tue, 17 Dec 2002 14:35:59 -0500
Date: Tue, 17 Dec 2002 11:44:34 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: Ulrich Drepper <drepper@redhat.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>, <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <3DFF7BCD.9040901@transmeta.com>
Message-ID: <Pine.LNX.4.44.0212171137420.1095-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Dec 2002, H. Peter Anvin wrote:
>
> What one can also do is that a sixth argument, if one exists, is passed
> on the stack (i.e. in (%ebp), since %ebp contains the stack pointer.)

I like this. I will make it so. It will allow the old calling conventions
and has none of the stack size issues that my "memory block" approach had.

Also since this will all be done inside the wrapper and is thus entirely
invisible to the caller. Good, this solves the six-arg case nicely.

		Linus

