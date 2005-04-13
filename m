Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262030AbVDMAqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbVDMAqR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 20:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262132AbVDMApn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 20:45:43 -0400
Received: from agminet03.oracle.com ([141.146.126.230]:49801 "EHLO
	agminet03.oracle.com") by vger.kernel.org with ESMTP
	id S262030AbVDMAnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 20:43:06 -0400
Date: Tue, 12 Apr 2005 17:38:04 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hangcheck-timer: Update to 0.9.0.
Message-ID: <20050413003804.GJ31163@ca-server1.us.oracle.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20050412235033.GI31163@ca-server1.us.oracle.com> <20050412171801.444df4bc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050412171801.444df4bc.akpm@osdl.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2005 at 05:18:01PM -0700, Andrew Morton wrote:
> It's not very important, but it would be a bit more conventional to use
> CONFIG_X86, CONFIG_ARCH_S390, CONFIG_IA64 and CONFIG_PPC64 for those cases
> where such an ifdef is to be used.

	Well, yeah, silly me.

> Joel Becker <Joel.Becker@oracle.com> wrote:
> > +# define TIMER_FREQ 1000000000ULL
> > +# define TIMER_FREQ 0xFA240000ULL
> > +# define TIMER_FREQ ((unsigned long long)local_cpu_data->itc_freq)
> > +# define TIMER_FREQ (HZ*loops_per_jiffy)
> 
> In the above case specifically, no ifdefs should be needed - you can simply
> define CONFIG_HANGCHECK_TIMER_FREQ in arch/*/Kconfig.

	Kbuild foo help, please.  I can't quite figure out how to
represent the non-constant values as code in Kbuild.   I can represent
them as strings, but then they are strings, not code.

Joel

-- 

Life's Little Instruction Book #452

	"Never compromise your integrity."

Joel Becker
Senior Member of Technical Staff
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
