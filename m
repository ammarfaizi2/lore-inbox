Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129057AbQJ3Jo3>; Mon, 30 Oct 2000 04:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129041AbQJ3JoU>; Mon, 30 Oct 2000 04:44:20 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:20998 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129165AbQJ3JoG>; Mon, 30 Oct 2000 04:44:06 -0500
Date: Mon, 30 Oct 2000 02:40:39 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
Message-ID: <20001030024039.C20102@vger.timpanogas.org>
In-Reply-To: <20001030022024.B20023@vger.timpanogas.org> <Pine.LNX.4.21.0010301144430.3186-100000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.21.0010301144430.3186-100000@elte.hu>; from mingo@elte.hu on Mon, Oct 30, 2000 at 11:50:24AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2000 at 11:50:24AM +0100, Ingo Molnar wrote:
> 
> On Mon, 30 Oct 2000, Jeff V. Merkey wrote:
> 
> > ds: and es: are both used in copy-to-user and copy-from-user and they
> > get reloaded.
> 
> And they all share the same segment descriptor. Whats your point? ES is
> the default target segment for string operations. DS is the default data
> segment. Have you ever profiled how many cycles it takes to do a "mov
> __KERNEL_DS, %es" in entry.S, before making your (ridiculous) claim? I
> have.
> 

No.  I used a hardware analyzer to show me how many LOCK# assertions it does
invisible to your software tools underneath.  Try using EMON to profile,
it gives hardware numbers and let's you watch the cache controllers 
issue non-cacheable memory references to fetch the descriptors.   

Jeff


> 	Ingo
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
