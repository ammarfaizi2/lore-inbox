Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318903AbSHMBrT>; Mon, 12 Aug 2002 21:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318904AbSHMBrT>; Mon, 12 Aug 2002 21:47:19 -0400
Received: from 12-235-88-76.client.attbi.com ([12.235.88.76]:18440 "EHLO
	mail.wine.dyndns.org") by vger.kernel.org with ESMTP
	id <S318903AbSHMBrT>; Mon, 12 Aug 2002 21:47:19 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Jakub Jelinek <jakub@redhat.com>, Linus Torvalds <torvalds@transmeta.com>,
       <linux-kernel@vger.kernel.org>, Luca Barbieri <ldb@ldb.ods.org>
Subject: Re: [patch] tls-2.5.31-D5
References: <Pine.LNX.4.44.0208121939260.22188-100000@localhost.localdomain>
From: Alexandre Julliard <julliard@winehq.com>
Date: 12 Aug 2002 18:50:44 -0700
In-Reply-To: <Pine.LNX.4.44.0208121939260.22188-100000@localhost.localdomain>
Message-ID: <873ctjle6j.fsf@mail.wine.dyndns.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> well, i think i have to agree ... if it wasnt for Wine's 0x40 descriptor.  
> But it certainly does not come free. We could have 3 TLS entries (0x40
> will be the last entry), and the copying cost is 9 cycles. (compared to 6
> cycles in the 2 entries case.) Good enough?

Note that Wine doesn't really require the 0x40 descriptor. As long as
we can trap accesses to it and emulate them like we do now, that's
good enough. Of course having a GDT entry would save a few cycles, but
this only matters for old Win16 apps, so I'm not sure adding even 1
cycle to the task switch time is worth it.

-- 
Alexandre Julliard
julliard@winehq.com
