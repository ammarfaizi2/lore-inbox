Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270412AbRHQTBp>; Fri, 17 Aug 2001 15:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270460AbRHQTBZ>; Fri, 17 Aug 2001 15:01:25 -0400
Received: from hq2.fsmlabs.com ([209.155.42.199]:46348 "HELO hq2.fsmlabs.com")
	by vger.kernel.org with SMTP id <S270412AbRHQTBY>;
	Fri, 17 Aug 2001 15:01:24 -0400
Date: Fri, 17 Aug 2001 12:57:27 -0600
From: Victor Yodaiken <yodaiken@fsmlabs.com>
To: george anzinger <george@mvista.com>
Cc: Russell King <rmk@arm.linux.org.uk>,
        christophe =?iso-8859-1?Q?barb=E9?= <christophe.barbe@lineo.fr>,
        linux-kernel@vger.kernel.org
Subject: Re: How should nano_sleep be fixed (was: ptrace(), fork(), sleep(), exit(), SIGCHLD)
Message-ID: <20010817125727.A16475@hq2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B7D61A6.AF988634@mvista.com>
User-Agent: Mutt/1.3.18i
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2001 at 11:25:42AM -0700, george anzinger wrote:
> > 
> How about something like:
> 
> In ../asm/signal.h  (for i386)
> 
> #define PT_REGS_ENTRY(type,name,p1_type,p1, p2_type,p2) \
> type name(p1_type p1,p2_typ p2)\
> {	struct pt_regs *regs = (struct pt_regs *)&p1;

In RTLinux we define MACHDEPREGS as an arch dependent type. PPC defines
this as a pointer and x87 as the structure etc. The small number of functions
that actually need to manipulate this can be made machine dependent too.
Came in handy during the port to BSD too.


