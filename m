Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131425AbRAJTh7>; Wed, 10 Jan 2001 14:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131958AbRAJTht>; Wed, 10 Jan 2001 14:37:49 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:12293 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131425AbRAJThc>; Wed, 10 Jan 2001 14:37:32 -0500
Subject: Re: Subtle MM bug
To: torvalds@transmeta.com (Linus Torvalds)
Date: Wed, 10 Jan 2001 19:36:43 +0000 (GMT)
Cc: ebiederm@xmission.com (Eric W. Biederman),
        andrea@suse.de (Andrea Arcangeli),
        dwmw2@infradead.org (David Woodhouse),
        zlatko@iskon.hr (Zlatko Calusic), riel@conectiva.com.br (Rik van Riel),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10101101100001.4457-100000@penguin.transmeta.com> from "Linus Torvalds" at Jan 10, 2001 11:03:21 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14GR38-0000nM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I looked at it a year or two ago myself, and came to the conclusion that I
> don't want to blow up our page table size by a factor of three or more, so
> I'm not personally interested any more. Maybe somebody else comes up with
> a better way to do it, or with a really compelling reason to.

There is only one reason I know for reverse page tables. That is ARM2/ARM3 
support - which is still not fully merged because of this issue

The MMU on these systems is a CAM, and the mmu table is thus backwards to
convention. (It also means you can notionally map two physical addresses to
one virtual but thats undefined in the implementation ;))


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
