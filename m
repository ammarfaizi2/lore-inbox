Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129741AbQKKOvU>; Sat, 11 Nov 2000 09:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130515AbQKKOvK>; Sat, 11 Nov 2000 09:51:10 -0500
Received: from [62.172.234.2] ([62.172.234.2]:49095 "EHLO saturn.homenet")
	by vger.kernel.org with ESMTP id <S129741AbQKKOuy>;
	Sat, 11 Nov 2000 09:50:54 -0500
Date: Sat, 11 Nov 2000 14:51:21 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: "H. Peter Anvin" <hpa@transmeta.com>, Max Inux <maxinux@bigfoot.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: bzImage ~ 900K with i386 test11-pre2
In-Reply-To: <20001111154209.A3450@inspiron.suse.de>
Message-ID: <Pine.LNX.4.21.0011111448200.1511-100000@saturn.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Nov 2000, Andrea Arcangeli wrote:

> On Sat, Nov 11, 2000 at 11:36:00AM +0000, Tigran Aivazian wrote:
> > Are you sure? I thought the fix was to build 2 page tables for 0-8M
> 
> Paging is disabled at that point.
> 

Yes, Andrea, I know that paging is disabled at the point of loading the
image but I was talking about the inability to boot (boot == complete
booting, i.e. at least reach start_kernel()) a kernel with very large
.data or .bss segments because of various reasons -- one of which,
probably,is the inadequacy of those pg0 and pg1 page tables set up in
head.S

So, what is still a bit unclear is -- if the only way to create a huge
bzImage is by having huge .text or .data or .bss, what is the combination
of the limits? I.e. which limit do we hit first -- the one on bzImage
(which Peter says is infinite?) or the ones on .text/.data/.bss (and what
exactly are they?)? See my question now?

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
