Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284218AbSAGRxi>; Mon, 7 Jan 2002 12:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284220AbSAGRx2>; Mon, 7 Jan 2002 12:53:28 -0500
Received: from [209.250.53.152] ([209.250.53.152]:51726 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S284218AbSAGRxN>; Mon, 7 Jan 2002 12:53:13 -0500
Date: Mon, 7 Jan 2002 11:32:27 -0600
From: Steven Walter <srwalter@yahoo.com>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: "APIC error on CPUx" - what does this mean?
Message-ID: <20020107113227.A31231@hapablap.dyn.dhs.org>
Mail-Followup-To: Steven Walter <srwalter@yahoo.com>,
	Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <E37DB7922B4@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E37DB7922B4@vcnet.vc.cvut.cz>; from VANDROVE@vc.cvut.cz on Mon, Jan 07, 2002 at 02:16:28PM +0100
X-Uptime: 11:13am  up 42 days, 18:00,  1 user,  load average: 1.14, 1.08, 1.02
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2002 at 02:16:28PM +0100, Petr Vandrovec wrote:
> Nope. Probably when CPU is in local APIC mode, it acknowledges interrupts
> to chipset with different timming, and from time to time CPU still
> sees IRQ pending, so it asks for vector, but as chipset has no
> interrupt pending, it answers with IRQ7. I did no analysis to find
> whether IRQ7 happens directly when we send confirmation to 8259,
> or whether it happens due to some noise on IRQ line.
> 
> AFAIK it happens only on VIA based boards, and only if (AMD) CPU is using 
> APIC.

My system is based on AMD's own 750 Irongate chipset, and it produces
both the initial spurious IRQ7 message and plentiful "ERR" interrupts:

srwalter@hapablap:~$ uptime
 11:31am  up 42 days, 18:19,  1 user,  load average: 1.04, 1.02, 1.00
srwalter@hapablap:~$ cat /proc/interrupts | grep ERR
ERR:      67169
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
He's alive.  He's alive!  Oh, that fellow at RadioShack said I was mad!
Well, who's mad now?
			-- Montgomery C. Burns
