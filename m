Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269081AbSIRS2x>; Wed, 18 Sep 2002 14:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269325AbSIRS2x>; Wed, 18 Sep 2002 14:28:53 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:20487 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269081AbSIRS2w>; Wed, 18 Sep 2002 14:28:52 -0400
Date: Wed, 18 Sep 2002 11:33:44 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, Cort Dougan <cort@fsmlabs.com>,
       Rik van Riel <riel@conectiva.com.br>, Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process()
 elimination, 2.5.35-BK
In-Reply-To: <Pine.LNX.4.44.0209182026300.25598-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0209181124120.1883-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 18 Sep 2002, Ingo Molnar wrote:
> 
> Eliminating for_each_task loops (the ones completely unrelated to
> the get_pid() issue) is an improvement even for desktop setups, which have
> at most 1000 processes running.

If you really really want to do this, then at least get it integrated
better (ie it should _replace_ pidhash since it appears to just duplicate
the functionality), and get the locking right. Maybe that will make it
look better.

		Linus

