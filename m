Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264777AbTBTXam>; Thu, 20 Feb 2003 18:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265687AbTBTXam>; Thu, 20 Feb 2003 18:30:42 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:7686 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264777AbTBTXal>; Thu, 20 Feb 2003 18:30:41 -0500
Date: Thu, 20 Feb 2003 15:36:31 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Zwane Mwaikambo <zwane@holomorphy.com>, Chris Wedgwood <cw@f00f.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: doublefault debugging (was Re: Linux v2.5.62 --- spontaneous
 reboots)
In-Reply-To: <Pine.LNX.4.44.0302210020490.6298-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0302201536010.1304-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 21 Feb 2003, Ingo Molnar wrote:
> 
> if possible i'd avoid putting more overhead into the scheduler - it's
> clearly more performance-sensitive than the task create/exit path.

This is a single non-serializing bit test, and if it means that the task 
counters are _right_, that's definitely the right thing to do.

		Linus

