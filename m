Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964842AbWDHNwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbWDHNwb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 09:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbWDHNwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 09:52:31 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:48823 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964842AbWDHNwb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 09:52:31 -0400
Date: Sat, 8 Apr 2006 15:50:13 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Walter L. Wimer III" <walt.wimer@timesys.com>
Cc: linux-kernel@vger.kernel.org,
       "Gleixner, Thomas" <thomas.gleixner@timesys.com>
Subject: Re: [PATCH] Fix compilation of 2.6.16-rt13 real-time preemption patch on PowerPC
Message-ID: <20060408135013.GA30488@elte.hu>
References: <1144436297.10765.52.camel@excalibur.timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1144436297.10765.52.camel@excalibur.timesys.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Walter L. Wimer III <walt.wimer@timesys.com> wrote:

> The following patch corrects errors encountered when compiling the 
> 2.6.16-rt13 real-time preemption patch on the PowerPC architecture:
> 
>       * The INIT_FS and INIT_FILES macro definitions changed, but
>         corresponding changes to the calls were missed on PowerPC.
> 
>       * The new TIF_NEED_RESCHED_DELAYED definition caused an overflow
>         of a 16-bit immediate load field in several PowerPC
>         assembly-language instructions (e.g. in entry.S).  This patch
>         changes the definition of TIF_NEED_RESCHED_DELAYED from the
>         value 16 to the value 13 (which appears to have been previously
>         unused).  (All bits from 0 to 15 are now in use on PPC, so if
>         any new thread_info flags are needed, we'll have to actually fix
>         the PPC assembly code to deal with the resulting 32-bit
>         quantity.)
> 
>       * The file include/asm-powerpc/irqflags.h was missing completely
>         on PowerPC.  For now, I've supplied a stub file.  There is
>         currently no support for CONFIG_DEBUG_TRACE_IRQFLAGS.
> 
> Thanks go to Thomas Gleixner for his comments/suggestions on this 
> patch.
> 
> I've successfully built and test-booted this on an AMCC440EP "Bamboo" 
> board.

thanks, applied.

	Ingo
