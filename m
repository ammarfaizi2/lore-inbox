Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129532AbQLWUnD>; Sat, 23 Dec 2000 15:43:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130774AbQLWUmo>; Sat, 23 Dec 2000 15:42:44 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:50438 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S129532AbQLWUmd>;
	Sat, 23 Dec 2000 15:42:33 -0500
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
Subject: Re: bigphysarea support in 2.2.19 and 2.4.0 kernels
In-Reply-To: <200012222311.eBMNBgr459298@saturn.cs.uml.edu>
From: Jes Sorensen <jes@linuxcare.com>
Date: 23 Dec 2000 21:11:20 +0100
In-Reply-To: "Albert D. Cahalan"'s message of "Fri, 22 Dec 2000 18:11:42 -0500 (EST)"
Message-ID: <d34rzulwyf.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Albert" == Albert D Cahalan <acahalan@cs.uml.edu> writes:

>> bigmem is 'last resort' stuff. I'd much rather it is as now a
>> seperate allocator so you actually have to sit and think and decide
>> to give up on kmalloc/vmalloc/better algorithms and only use it
>> when the hardware sucks

Albert> It isn't just for sucky hardware. It is for performance too.

Albert> 1. Linux isn't known for cache coloring ability. Even if it
Albert> was, users want to take advantage of large pages or BAT
Albert> registers to reduce TLB miss costs. (that is, mapping such
Albert> areas into a process is needed... never mind security for now)

Albert> 2. Programming a DMA controller with multiple addresses isn't
Albert> as fast as programming it with one.

LOL

Consider that allocating the larger block of memory is going to take a
lot longer than it will take for the DMA engine to read the
scatter/gather table entries and fetch a new address word now and
then.

Jes
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
