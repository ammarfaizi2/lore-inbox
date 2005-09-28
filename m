Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbVI1DF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbVI1DF4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 23:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbVI1DF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 23:05:56 -0400
Received: from smtp1.Stanford.EDU ([171.67.16.123]:17026 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S1751140AbVI1DFz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 23:05:55 -0400
Subject: Re: 2.6.14-rc2-rt2
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: dwalker@mvista.com
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, emann@mrv.com,
       yang.yi@bmrtech.com
In-Reply-To: <1127862619.4004.48.camel@dhcp153.mvista.com>
References: <20050913100040.GA13103@elte.hu> <20050926070210.GA5157@elte.hu>
	 <1127840377.27319.11.camel@cmn3.stanford.edu>
	 <1127862619.4004.48.camel@dhcp153.mvista.com>
Content-Type: text/plain
Date: Tue, 27 Sep 2005 20:04:33 -0700
Message-Id: <1127876673.9430.2.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-27 at 16:10 -0700, Daniel Walker wrote:
> On Tue, 2005-09-27 at 09:59 -0700, Fernando Lopez-Lezcano wrote:
> >  UPD     include/linux/compile.h
> > {standard input}: Assembler messages:
> > {standard input}:164: Error: can't resolve `.sched.text' {.sched.text
> > section} - `.Ltext0' {.text section}
> > {standard input}:165: Error: can't resolve `.sched.text' {.sched.text
> > section} - `.Ltext0' {.text section}
> > make[1]: *** [arch/i386/kernel/semaphore.o] Error 1
> > make[1]: *** Waiting for unfinished jobs....
> > make: *** [arch/i386/kernel] Error 2
> > make: *** Waiting for unfinished jobs....
> > 
> > Failing .config attached. 
>
> Here's the fix.

Hey thanks! That fixes that, but the compile fails further along:

  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
arch/i386/kernel/built-in.o(.text+0xf086): In function `do_powersaver':
longhaul.c: undefined reference to `safe_halt'
arch/i386/kernel/built-in.o(.text+0xf271): In function
`longhaul_setstate':
longhaul.c: undefined reference to `safe_halt'
make: *** [.tmp_vmlinux1] Error 1

-- Fernando


