Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269276AbSIRSQI>; Wed, 18 Sep 2002 14:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269277AbSIRSQI>; Wed, 18 Sep 2002 14:16:08 -0400
Received: from mx1.elte.hu ([157.181.1.137]:26272 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S269276AbSIRSQH>;
	Wed, 18 Sep 2002 14:16:07 -0400
Date: Wed, 18 Sep 2002 20:28:28 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Cort Dougan <cort@fsmlabs.com>, Linus Torvalds <torvalds@transmeta.com>,
       Rik van Riel <riel@conectiva.com.br>, Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process()
 elimination, 2.5.35-BK
In-Reply-To: <344349498.1032347281@[10.10.2.3]>
Message-ID: <Pine.LNX.4.44.0209182026300.25598-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 18 Sep 2002, Martin J. Bligh wrote:

> Nobody's trying to screw the desktop users, we're being mind- bogglingly
> careful not to, in fact. If you have specific objections to a particular
> patch, raise them as technical arguments. Saying "we shouldn't do that
> because I'm not interested in it" is far less useful.

i fully agree with your points, but it does not hold in this specific
case. Eliminating for_each_task loops (the ones completely unrelated to
the get_pid() issue) is an improvement even for desktop setups, which have
at most 1000 processes running.

	Ingo

