Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131386AbRDJKBU>; Tue, 10 Apr 2001 06:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131407AbRDJKBL>; Tue, 10 Apr 2001 06:01:11 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:2063 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S131386AbRDJKBB>;
	Tue, 10 Apr 2001 06:01:01 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200104101000.f3AA0nZ517534@saturn.cs.uml.edu>
Subject: Re: No 100 HZ timer !
To: mj@suse.cz (Martin Mares)
Date: Tue, 10 Apr 2001 06:00:49 -0400 (EDT)
Cc: schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org
In-Reply-To: <20010410113309.A16825@atrey.karlin.mff.cuni.cz> from "Martin Mares" at Apr 10, 2001 11:33:09 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Mares writes:
> [lost]

>> Just how would you do kernel/user CPU time accounting then ?
>> It's currently done on every timer tick, and doing it less
>> often would make it useless.
>
> Except for machines with very slow timers we really should account time
> to processes during context switch instead of sampling on timer ticks.
> The current values are in many situations (i.e., lots of processes
> or a process frequently waiting for events bound to timer) a pile
> of random numbers.

Linux should maintain some sort of per-process decaying average.
This data is required for a Unix98-compliant ps program. (for %CPU)
Currently ps is using total CPU usage over the life of the process.
