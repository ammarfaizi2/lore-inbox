Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268384AbSIRSj5>; Wed, 18 Sep 2002 14:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268395AbSIRSj5>; Wed, 18 Sep 2002 14:39:57 -0400
Received: from mx1.elte.hu ([157.181.1.137]:46242 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S268384AbSIRSj5>;
	Wed, 18 Sep 2002 14:39:57 -0400
Date: Wed, 18 Sep 2002 20:51:54 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Cort Dougan <cort@fsmlabs.com>,
       Rik van Riel <riel@conectiva.com.br>, Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process()
 elimination, 2.5.35-BK
In-Reply-To: <Pine.LNX.4.44.0209181124120.1883-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209182049170.26337-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 18 Sep 2002, Linus Torvalds wrote:

> If you really really want to do this, then at least get it integrated
> better (ie it should _replace_ pidhash since it appears to just
> duplicate the functionality), and get the locking right. Maybe that will
> make it look better.

yes, i'm in the process of doing this. I havent cleaned up idtag.c (and
its impact) yet, i started with pid.c. Once cleaned up it should have the
same hashing overhead as the existing pidhash.

	Ingo

