Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262252AbVHCMIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262252AbVHCMIg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 08:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbVHCMFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 08:05:50 -0400
Received: from mx1.elte.hu ([157.181.1.137]:10956 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262248AbVHCMDg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 08:03:36 -0400
Date: Wed, 3 Aug 2005 14:04:13 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       LKML <linux-kernel@vger.kernel.org>, Daniel Walker <dwalker@mvista.com>
Subject: Re: [Question] arch-independent way to differentiate between user andkernel
Message-ID: <20050803120413.GA12317@elte.hu>
References: <20050802101920.GA25759@elte.hu> <1123011928.1590.43.camel@localhost.localdomain> <1123025895.25712.7.camel@dhcp153.mvista.com> <1123027226.1590.59.camel@localhost.localdomain> <1123035909.11101.1.camel@c-67-188-6-232.hsd1.ca.comcast.net> <1123036936.1590.69.camel@localhost.localdomain> <1123037933.11101.11.camel@c-67-188-6-232.hsd1.ca.comcast.net> <1123065472.1590.84.camel@localhost.localdomain> <Pine.LNX.4.61.0508030647140.9343@chaos.analogic.com> <1123069449.1590.93.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123069449.1590.93.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 2005-08-03 at 06:56 -0400, linux-os (Dick Johnson) wrote:
> > On Wed, 3 Aug 2005, Steven Rostedt wrote:
> > The interrupt handler gets a pointer to a structure called "struct pt_regs".
> > That contains, amongst other things, the registers pushed onto the stack
> > during the interrupt. If the segments were kernel segments, the interrupt
> > occurred while in kernel mode. But..... If you have any code that
> > needs to know, it's horribly and irreparably broken beyond all
> > repair. Interrupts need to be handled NOW, without regard to what
> > got interrupted.
> > 
> 
> By the time you get to __do_IRQ there's already more stuff on the 
> stack. And the pt_regs is arch specific so this doesn't help.

the actual layout of pt_regs is arch-specific, but user_mode(regs) is 
pretty much generic across most arches.

	Ingo
