Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261434AbVFAPgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbVFAPgz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 11:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbVFAPgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 11:36:54 -0400
Received: from mail.timesys.com ([65.117.135.102]:52965 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261434AbVFAPff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 11:35:35 -0400
Message-ID: <429DD553.3080509@timesys.com>
Date: Wed, 01 Jun 2005 11:33:39 -0400
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Paulo Marques <pmarques@grupopie.com>, Ingo Molnar <mingo@elte.hu>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Esben Nielsen <simlo@phys.au.dk>, James Bruce <bruce@andrew.cmu.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       john cooper <john.cooper@timesys.com>
Subject: Re: RT patch acceptance
References: <Pine.OSF.4.05.10505311652140.1707-100000@da410.phys.au.dk> <20050531161157.GQ5413@g5.random> <20050531183627.GA1880@us.ibm.com> <20050531204544.GU5413@g5.random> <429DA7AE.5000304@grupopie.com> <20050601135154.GF5413@g5.random> <20050601141919.GA9282@elte.hu> <20050601143202.GI5413@g5.random> <20050601144612.GJ5413@g5.random> <429DCD25.3010800@grupopie.com> <20050601151701.GM5413@g5.random>
In-Reply-To: <20050601151701.GM5413@g5.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Jun 2005 15:28:48.0562 (UTC) FILETIME=[9B527920:01C566BE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> The reason I raise this topic is that the fact spin_lock_irq wasn't
> disabling irqs like it does in the non-RT configuration, sounded like
> the technique described in the patent and it's one technique I always
> considered not-usable. I possibly wrongly remembered that redefining the
> disable-interrupt operation not to disable irqs, was the crucial point
> of the patent. But as I've said I'm not a lawyer and so I may have
> misunderstood completely the technique that the rtlinux patent is
> covering (the way patents are written is not very readable to me).

FWIW the decoupling of interrupt mask levels from
spinlocks is a technique which predates the patent
under discussion by a decade or so.  And yes IANAL
as well but it seems the patent would/should not
have been awarded if it conflicted/overlapped with
preexisting usage.  I'd hazard this is a non-issue.

-john


-- 
john.cooper@timesys.com
