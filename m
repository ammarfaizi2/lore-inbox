Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288144AbSAMUqg>; Sun, 13 Jan 2002 15:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288146AbSAMUqU>; Sun, 13 Jan 2002 15:46:20 -0500
Received: from mx2.elte.hu ([157.181.151.9]:40325 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S288144AbSAMUqN>;
	Sun, 13 Jan 2002 15:46:13 -0500
Date: Sun, 13 Jan 2002 23:43:35 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] SMP kernel deadlocking on UP boxen
In-Reply-To: <Pine.GSO.4.21.0201131540550.27390-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0201132343130.10912-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 13 Jan 2002, Alexander Viro wrote:

> -	if (!need_resched)
> +	if (!need_resched && p->cpu != smp_processor_id())
>  		smp_send_reschedule(p->cpu);

this is DaveM's fix, which is in the -H7 scheduler patch.

	Ingo

