Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284823AbSAGSW2>; Mon, 7 Jan 2002 13:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284755AbSAGSWQ>; Mon, 7 Jan 2002 13:22:16 -0500
Received: from port-213-20-128-16.reverse.qdsl-home.de ([213.20.128.16]:53008
	"EHLO drocklinux.dyndns.org") by vger.kernel.org with ESMTP
	id <S284795AbSAGSVQ>; Mon, 7 Jan 2002 13:21:16 -0500
Date: Mon, 07 Jan 2002 19:20:38 +0100 (CET)
Message-Id: <20020107.192038.884040663.rene.rebe@gmx.net>
To: srwalter@yahoo.com
Cc: VANDROVE@vc.cvut.cz, linux-kernel@vger.kernel.org
Subject: Re: "APIC error on CPUx" - what does this mean?
From: Rene Rebe <rene.rebe@gmx.net>
In-Reply-To: <20020107113227.A31231@hapablap.dyn.dhs.org>
In-Reply-To: <E37DB7922B4@vcnet.vc.cvut.cz>
	<20020107113227.A31231@hapablap.dyn.dhs.org>
X-Mailer: Mew version 2.1 on XEmacs 21.4.6 (Common Lisp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Walter <srwalter@yahoo.com>
Subject: Re: "APIC error on CPUx" - what does this mean?
Date: Mon, 7 Jan 2002 11:32:27 -0600

> On Mon, Jan 07, 2002 at 02:16:28PM +0100, Petr Vandrovec wrote:
> > Nope. Probably when CPU is in local APIC mode, it acknowledges interrupts
> > to chipset with different timming, and from time to time CPU still
> > sees IRQ pending, so it asks for vector, but as chipset has no
> > interrupt pending, it answers with IRQ7. I did no analysis to find
> > whether IRQ7 happens directly when we send confirmation to 8259,
> > or whether it happens due to some noise on IRQ line.
> > 
> > AFAIK it happens only on VIA based boards, and only if (AMD) CPU is using 
> > APIC.
> 
> My system is based on AMD's own 750 Irongate chipset, and it produces
> both the initial spurious IRQ7 message and plentiful "ERR" interrupts:

All my machines (from SiS 735, over Intel-BX to older Aladin-5
(super7) boxes) producing such "spurious IRQ7" with the actual 2.4.16
or 2.4.17 kernels ...

> srwalter@hapablap:~$ uptime
>  11:31am  up 42 days, 18:19,  1 user,  load average: 1.04, 1.02, 1.00
> srwalter@hapablap:~$ cat /proc/interrupts | grep ERR
> ERR:      67169
> -- 
> -Steven
> In a time of universal deceit, telling the truth is a revolutionary act.
> 			-- George Orwell
> He's alive.  He's alive!  Oh, that fellow at RadioShack said I was mad!
> Well, who's mad now?
> 			-- Montgomery C. Burns
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
