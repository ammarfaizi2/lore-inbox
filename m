Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267584AbUH2G5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267584AbUH2G5Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 02:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267578AbUH2G5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 02:57:25 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:11411 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267364AbUH2G5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 02:57:23 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q4
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Daniel Schmitt <pnambic@unu.nu>, "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mark_H_Johnson@raytheon.com
In-Reply-To: <20040829054339.GA16673@elte.hu>
References: <20040823221816.GA31671@yoda.timesys>
	 <1093715573.8611.38.camel@krustophenia.net>
	 <20040828194449.GA25732@elte.hu> <200408282210.03568.pnambic@unu.nu>
	 <20040828203116.GA29686@elte.hu>
	 <1093727453.8611.71.camel@krustophenia.net>
	 <20040828211334.GA32009@elte.hu> <1093727817.860.1.camel@krustophenia.net>
	 <1093737080.1385.2.camel@krustophenia.net>
	 <1093746912.1312.4.camel@krustophenia.net> <20040829054339.GA16673@elte.hu>
Content-Type: text/plain
Message-Id: <1093762642.1348.3.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 29 Aug 2004 02:57:22 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-29 at 01:43, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > Some more info:
> > 
> > This bug is 100% reproducible.  During boot, as soon as the i8042 driver
> > is loaded:
> > 
> > serio: i8042 AUX port at 0x60,0x64 irq 12
> > serio: i8042 KBD port at 0x60,0x64 irq 1
> > input: AT Translated Set 2 keyboard on isa0060/serio0
> > 
> > the keyboard freezes, with 'Num Lock' stuck on.
> > 
> > The problem only occurs when CONFIG_PREEMPT_HARDIRQS=y.  Works fine
> > otherwise.
> 
> i suspect it's the generic_synchronize_irq() change. Does -Q4 boot?:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk4-Q4
> 
> -Q4 reverts this change. (this doesnt solve the problems Scott noticed
> though.)
> 
> another solution would be to boot Q3 with preempt_hardirqs=0 and then
> turn on threading for all IRQs but the keyboard.
> 

Nope, neither of these fixes the problem.

Lee

