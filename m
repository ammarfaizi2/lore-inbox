Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291332AbSBGV0R>; Thu, 7 Feb 2002 16:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291324AbSBGV0I>; Thu, 7 Feb 2002 16:26:08 -0500
Received: from mx2.elte.hu ([157.181.151.9]:39819 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S291323AbSBGV0C>;
	Thu, 7 Feb 2002 16:26:02 -0500
Date: Fri, 8 Feb 2002 00:23:51 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Performance of Ingo's O(1) scheduler on NUMA-Q
In-Reply-To: <241920000.1013087323@flay>
Message-ID: <Pine.LNX.4.33.0202080021520.7544-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 7 Feb 2002, Martin J. Bligh wrote:

> Measuring kernel compile times on a 16 way NUMA-Q, adding Ingo's
> scheduler patch takes kernel compiles down from 47 seconds to 31
> seconds .... pretty impressive benefit.

cool! By the way, could you try a test-compile with a 'big' .config file?

The reason i'm asking this is that with 31 seconds compiles, the final
link time serialization has a significant effect, which makes the compile
itself less scalable. Adding lots of subsystems to the .config will create
a compilation that takes much longer, but which should also compare the
two schedulers better.

	Ingo

