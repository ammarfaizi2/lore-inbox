Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbRAIVrg>; Tue, 9 Jan 2001 16:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129436AbRAIVr0>; Tue, 9 Jan 2001 16:47:26 -0500
Received: from [64.64.109.142] ([64.64.109.142]:16402 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S129383AbRAIVrO>; Tue, 9 Jan 2001 16:47:14 -0500
Message-ID: <3A5B86C1.41DDB11B@didntduck.org>
Date: Tue, 09 Jan 2001 16:46:41 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.73 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: rob@sysgo.de
CC: linux-kernel@vger.kernel.org
Subject: Re: Anybody got 2.4.0 running on a 386 ?
In-Reply-To: <01010922090000.02630@rob> <3A5B7F76.ABDFED7A@didntduck.org> <01010922264400.02737@rob>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Kaiser wrote:
> 
> On Die, 09 Jan 2001 you wrote:
> > Robert Kaiser wrote:
> > > I can't seem to get the new 2.4.0 kernel running on a 386 CPU.
> > > The kernel was built for a 386 Processor, Math emulation has been enabled.
> > > I tried three different 386 boards. Execution seems to get as far as
> > > pagetable_init() in arch/i386/mm/init.c, then it falls back into the BIOS as
> > > if someone had pressed the reset button. The same kernel boots fine on
> > > 486 and Pentium Systems.
> > >
> > > Any ideas/suggestions ?
> >
> >
> > is "Checking if this processor honours the WP bit even in supervisor
> > mode... " the last thing you see before the reset?
> >
> 
> No, I don't see _any_ messages from the kernel. The last thing I see is
> "Uncompressing Linux... Ok, booting the kernel." I have added some
> quick and dirty debug code that writes messages directly to the VGA
> screen buffer. According to that, execution seems to get as far as the
> statement
> 
>         *pte = mk_pte_phys(__pa(vaddr), PAGE_KERNEL);
> 

Could it be possible that memory size is being misdetected?  Try mem=8M
(or less) on the command line.  Try to catch the value of pte when it
crashes.

--

				Brian Gerst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
