Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131020AbRALUMP>; Fri, 12 Jan 2001 15:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131537AbRALUME>; Fri, 12 Jan 2001 15:12:04 -0500
Received: from colorfullife.com ([216.156.138.34]:49413 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S131059AbRALULx>;
	Fri, 12 Jan 2001 15:11:53 -0500
Message-ID: <3A5F64F1.2C4ADDBA@colorfullife.com>
Date: Fri, 12 Jan 2001 21:11:29 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Frank de Lange <frank@unternet.org>, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, mingo@elte.hu,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardwarerelated?
In-Reply-To: <Pine.LNX.4.10.10101121158050.3010-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> 
> I'd like to know _which_ of the two makes a difference (or does it only
> trigger with both of them enabled)? And even then I'm not sure that it is
> "the" solution - both changes to io-apic handling had some reason for
> them. Ingo, what was the focus-cpu thing?
> 

Frank, please clarify:
you still run without disable_irq_nosync() in 8390.c?

I have a first idea: we send an EOI to an interrupt that is masked on
the IO apic, perhaps that causes the problems.

I'm right now typing a patch.

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
