Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132153AbRAIV1Y>; Tue, 9 Jan 2001 16:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132129AbRAIV1P>; Tue, 9 Jan 2001 16:27:15 -0500
Received: from ns.sysgo.de ([213.68.67.98]:10231 "EHLO rob.devdep.sysgo.de")
	by vger.kernel.org with ESMTP id <S132104AbRAIV04>;
	Tue, 9 Jan 2001 16:26:56 -0500
From: Robert Kaiser <rob@sysgo.de>
Reply-To: rob@sysgo.de
To: Brian Gerst <bgerst@didntduck.org>
Subject: Re: Anybody got 2.4.0 running on a 386 ?
Date: Tue, 9 Jan 2001 22:17:47 +0100
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <01010922090000.02630@rob> <3A5B7F76.ABDFED7A@didntduck.org>
In-Reply-To: <3A5B7F76.ABDFED7A@didntduck.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01010922264400.02737@rob>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Die, 09 Jan 2001 you wrote:
> Robert Kaiser wrote:
> > I can't seem to get the new 2.4.0 kernel running on a 386 CPU.
> > The kernel was built for a 386 Processor, Math emulation has been enabled.
> > I tried three different 386 boards. Execution seems to get as far as
> > pagetable_init() in arch/i386/mm/init.c, then it falls back into the BIOS as
> > if someone had pressed the reset button. The same kernel boots fine on
> > 486 and Pentium Systems.
> > 
> > Any ideas/suggestions ?
> 
> 
> is "Checking if this processor honours the WP bit even in supervisor
> mode... " the last thing you see before the reset?
> 

No, I don't see _any_ messages from the kernel. The last thing I see is
"Uncompressing Linux... Ok, booting the kernel." I have added some
quick and dirty debug code that writes messages directly to the VGA
screen buffer. According to that, execution seems to get as far as the
statement

        *pte = mk_pte_phys(__pa(vaddr), PAGE_KERNEL);




----------------------------------------------------------------
Robert Kaiser                         email: rkaiser@sysgo.de
SYSGO RTS GmbH
Am Pfaffenstein 14                    phone: (49) 6136 9948-762
D-55270 Klein-Winternheim / Germany   fax:   (49) 6136 9948-10
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
