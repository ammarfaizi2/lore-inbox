Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129370AbQLXIqv>; Sun, 24 Dec 2000 03:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129460AbQLXIql>; Sun, 24 Dec 2000 03:46:41 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:50700 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S129370AbQLXIq0>;
	Sun, 24 Dec 2000 03:46:26 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200012240815.eBO8FjG523728@saturn.cs.uml.edu>
Subject: Re: bigphysarea support in 2.2.19 and 2.4.0 kernels
To: jes@linuxcare.com (Jes Sorensen)
Date: Sun, 24 Dec 2000 03:15:45 -0500 (EST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <d34rzulwyf.fsf@lxplus015.cern.ch> from "Jes Sorensen" at Dec 23, 2000 09:11:20 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen writes:
> Albert D Cahalan <acahalan@cs.uml.edu> writes:

[about using huge physical allocations for number crunching]

>> 2. Programming a DMA controller with multiple addresses isn't
>> as fast as programming it with one.
>
> LOL
>
> Consider that allocating the larger block of memory is going
> to take a lot longer than it will take for the DMA engine to
> read the scatter/gather table entries and fetch a new address
> word now and then.

Say it takes a whole minute to allocate the memory. It wouldn't
of course, because you'd allocate memory at boot, but anyway...
Then the app runs, using that memory, for a multi-hour surgery.
The allocation happens once; the inter-node DMA transfers occur
dozens or hundreds of times per second.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
