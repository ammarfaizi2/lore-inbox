Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265198AbTBTMGY>; Thu, 20 Feb 2003 07:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265201AbTBTMGY>; Thu, 20 Feb 2003 07:06:24 -0500
Received: from holomorphy.com ([66.224.33.161]:25502 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265198AbTBTMGY>;
	Thu, 20 Feb 2003 07:06:24 -0500
Date: Thu, 20 Feb 2003 04:12:16 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Zwane Mwaikambo <zwane@holomorphy.com>, Chris Wedgwood <cw@f00f.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: doublefault debugging (was Re: Linux v2.5.62 --- spontaneous reboots)
Message-ID: <20030220121216.GK22687@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@transmeta.com>,
	Zwane Mwaikambo <zwane@holomorphy.com>,
	Chris Wedgwood <cw@f00f.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"Martin J. Bligh" <mbligh@aracnet.com>
References: <Pine.LNX.4.44.0302192039400.1453-100000@home.transmeta.com> <Pine.LNX.4.44.0302201245100.10184-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302201245100.10184-100000@localhost.localdomain>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2003 at 12:46:51PM +0100, Ingo Molnar wrote:
> i think i managed to trigger a potentially useful oops, with BK-curr:
> Stack: c02dd6ac 0000002b 6b6b6b6b 6b6b6b6b 6b6b6b6b 6b6b6b8b 6b6b6b6b 6b6b6b6b
>        6b6b6b6b 00030001 6b6b6b6b 6b6b6b6b 6b6b6b6b 6b6b6b6b 6b6b6b6b 6b6b6b6b
>        6b6b6b6b 6b6b6b6b 6b6b6b6b 6b6b6b6b 6b6b6b6b 6b6b6b6b 6b6b6b6b 6b6b6b6b

Looks like some kind of serious use-after-free slab issue. IF is clear,
so we aren't under spin_lock_irq(&rq->lock) on the initial fault. It
might be interesting to find a way to trap it earlier. Reproducible?
If so, how?


-- wli
