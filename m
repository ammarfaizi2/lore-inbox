Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261988AbSJHLda>; Tue, 8 Oct 2002 07:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262043AbSJHLda>; Tue, 8 Oct 2002 07:33:30 -0400
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:12501 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S261988AbSJHLda>; Tue, 8 Oct 2002 07:33:30 -0400
Content-Type: text/plain; charset=US-ASCII
From: Duncan Sands <baldrick@wanadoo.fr>
To: zlatko.calusic@iskon.hr, Alessandro Suardi <alessandro.suardi@oracle.com>
Subject: Re: [PATCH] Re: Shared memory shmat/dt not working well in 2.5.x
Date: Tue, 8 Oct 2002 13:38:50 +0200
User-Agent: KMail/1.4.3
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0210011401360.991-100000@localhost.localdomain> <874rc4fzml.fsf@atlas.iskon.hr> <87ptulcgzc.fsf@atlas.iskon.hr>
In-Reply-To: <87ptulcgzc.fsf@atlas.iskon.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210081338.50495.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I also observed that other application I use occasionally - LXR (Linux
> source cross referencing tool) - takes much longer to generate xref
> database (which is in Berkeley DB files). It works in three passes,
> where the last one, when it dumps symbols into DB, is interesting. In
> 2.4 it finishes quickly (it uses 100% CPU, then occasionally syncs the
> databases - heavy write traffic for a second - then continues), but
> 2.5 has problems with it (it stucks writing to disk all the time, CPU
> usage is minimal and process progresses very slowly). Andrew, if
> you're interested I can send you some numbers to describe the case
> better.

Hmmm, are you using ext3?  Changes to the meaning of yield sometimes
make fsync go very slowly.  This problem has been around since 2.5.28,
and hasn't yet been fixed (As for a fix, Andrew Morton said "I'll sit tight for
the while, see where shed_yield() behaviour ends up").

All the best,

Duncan.
