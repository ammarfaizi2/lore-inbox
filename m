Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291278AbSBGUay>; Thu, 7 Feb 2002 15:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291279AbSBGUao>; Thu, 7 Feb 2002 15:30:44 -0500
Received: from mx2.elte.hu ([157.181.151.9]:49797 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S291278AbSBGUaf>;
	Thu, 7 Feb 2002 15:30:35 -0500
Date: Thu, 7 Feb 2002 23:28:20 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Jussi Laako <jussi.laako@kolumbus.fi>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] improving O(1)-J9 in heavily threaded situations
In-Reply-To: <3C607C43.92262E82@kolumbus.fi>
Message-ID: <Pine.LNX.4.33.0202072326410.4773-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jussi,

there is one more thing in the -K2 patch that could cause your problems.
In kernel/softirq.c, you'll find this line:

//__initcall(spawn_ksoftirqd);

please uncomment it - this was just a debugging thing that was left in the
patch accidentally. I've made a -K3 patch that has this fixed. Do you
still see the audio problems?

	Ingo

