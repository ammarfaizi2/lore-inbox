Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132828AbRDDOgr>; Wed, 4 Apr 2001 10:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132830AbRDDOgh>; Wed, 4 Apr 2001 10:36:37 -0400
Received: from chiara.elte.hu ([157.181.150.200]:43020 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S132828AbRDDOg0>;
	Wed, 4 Apr 2001 10:36:26 -0400
Date: Wed, 4 Apr 2001 15:34:22 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Hubertus Franke <frankeh@us.ibm.com>
Cc: Mike Kravetz <mkravetz@sequent.com>, Fabio Riccardi <fabio@chromium.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        <lse-tech@lists.sourceforge.net>
Subject: Re: a quest for a better scheduler
In-Reply-To: <OF401BD38B.CF3B1E9F-ON85256A24.0048543A@pok.ibm.com>
Message-ID: <Pine.LNX.4.30.0104041527190.5382-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 4 Apr 2001, Hubertus Franke wrote:

> Another point to raise is that the current scheduler does a exhaustive
> search for the "best" task to run. It touches every process in the
> runqueue. this is ok if the runqueue length is limited to a very small
> multiple of the #cpus. [...]

indeed. The current scheduler handles UP and SMP systems, up to 32
(perhaps 64) CPUs efficiently. Agressively NUMA systems need a different
approach anyway in many other subsystems too, Kanoj is doing some
scheduler work in that area.

but the original claim was that the scheduling of thousands of runnable
processes (which is not equal to having thousands of sleeping processes)
must perform well - which is a completely different issue.

	Ingo

