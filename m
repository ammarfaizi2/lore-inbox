Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262006AbTCHCe2>; Fri, 7 Mar 2003 21:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262009AbTCHCe2>; Fri, 7 Mar 2003 21:34:28 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:549
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262006AbTCHCe1>; Fri, 7 Mar 2003 21:34:27 -0500
Date: Fri, 7 Mar 2003 21:42:30 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Andrew Morton <akpm@digeo.com>
cc: manfred@colorfullife.com, "" <linux-kernel@vger.kernel.org>
Subject: Re: Oops: 2.5.64 check_obj_poison for 'size-64'
In-Reply-To: <20030307182447.59cc83ea.akpm@digeo.com>
Message-ID: <Pine.LNX.4.50.0303072140250.1339-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0303062358130.17080-100000@montezuma.mastecende.com>
 <20030306222328.14b5929c.akpm@digeo.com>
 <Pine.LNX.4.50.0303070221470.18716-100000@montezuma.mastecende.com>
 <20030306233517.68c922f9.akpm@digeo.com>
 <Pine.LNX.4.50.0303070351060.18716-100000@montezuma.mastecende.com>
 <20030307010539.3c0a14a3.akpm@digeo.com> <3E68F552.1010807@colorfullife.com>
 <Pine.LNX.4.50.0303071656160.18716-100000@montezuma.mastecende.com>
 <Pine.LNX.4.50.0303072007190.1339-100000@montezuma.mastecende.com>
 <20030307182447.59cc83ea.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Mar 2003, Andrew Morton wrote:

> Looks to me like you overran the page for seq_printf, which then returned -1
> which then triggered what appears to be some utterly bogus code in
> show_interrupts():
> 
>         for (j = 0; j < NR_CPUS; j++)
>                 if (cpu_online(j))
>                         p += seq_printf(p, "%10u ", irq_stat[j].apic_timer_irqs);
> 
> Why is it modifying `p' there?  That's the pointer to the seq_file which
> we're using.

Probably leftovers from the previous interface.

> Kill.  Two instances.

Ok i'm just testing the seq_file buffer increase.

Thanks,
	Zwane
-- 
function.linuxpower.ca
