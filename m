Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264706AbSLQGJj>; Tue, 17 Dec 2002 01:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264715AbSLQGJj>; Tue, 17 Dec 2002 01:09:39 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18707 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264706AbSLQGJh>; Tue, 17 Dec 2002 01:09:37 -0500
Date: Mon, 16 Dec 2002 22:18:27 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dave Jones <davej@codemonkey.org.uk>
cc: Ingo Molnar <mingo@elte.hu>, <linux-kernel@vger.kernel.org>,
       <hpa@transmeta.com>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <Pine.LNX.4.44.0212162204300.1800-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0212162211110.1810-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 16 Dec 2002, Linus Torvalds wrote:
>
> For gettimeofday(), the results on my P4 are:
>
> 	sysenter:	1280.425844 cycles
> 	int/iret:	2415.698224 cycles
> 			1135.272380 cycles diff
> 	factor 1.886637
>
> ie sysenter makes that system call almost twice as fast.

Final comparison for the evening: a PIII looks very different, since the
system call overhead is much smaller to begin with. On a PIII, the above
ends up looking like

   gettimeofday() testing:
	sysenter:	561.697236 cycles
	int/iret:	686.170463 cycles
			124.473227 cycles diff
	factor 1.221602

ie the speedup is much less because the original int/iret numbers aren't
nearly as embarrassing as the P4 ones. It's still a win, though.

		Linus

