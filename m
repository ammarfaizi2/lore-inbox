Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267236AbSIRQMH>; Wed, 18 Sep 2002 12:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267239AbSIRQMH>; Wed, 18 Sep 2002 12:12:07 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:63245 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267236AbSIRQMG>; Wed, 18 Sep 2002 12:12:06 -0400
Date: Wed, 18 Sep 2002 09:17:46 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process()
 elimination, 2.5.35-BK
In-Reply-To: <Pine.LNX.4.44.0209181452050.19672-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0209180915350.1913-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 18 Sep 2002, Ingo Molnar wrote:
> 
> why? For most desktop systems even 32K PIDs is probably too high. A large
> pid_max only increases the RAM footprint. (well not under the current
> allocation scheme but still.)

Yeah. It increases memory pressure for the _complex_ and _slow_ 
algorithms. Agreed.

See my two-liner suggestion (which is admittedly not even compiled, so the
one disadvantage it might have is that it might need to be debugged. But
it's only two lines and doesn't actually change any fundamental part of
any existing algorithms, so debugging shouldn't be a big problem.

		Linus

