Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263900AbTEXTIE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 15:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263534AbTEXTID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 15:08:03 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:19841
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S263529AbTEXTIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 15:08:01 -0400
Date: Sat, 24 May 2003 15:11:06 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "" <linux-smp@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [RFC] Fix NMI watchdog documentation
In-Reply-To: <Pine.LNX.4.50.0305241505470.2267-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.50.0305241509380.2267-100000@montezuma.mastecende.com>
References: <3ECFC2D6.2020007@gmx.net> <Pine.LNX.4.50.0305241505470.2267-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 May 2003, Zwane Mwaikambo wrote:

> For nmi_watchdog=1 the NMI watchdog uses the programmable interval timer
> to trigger interrupt events via the IOAPIC. with nmi_watchdog=2 we use the 
> performance counters on the processor to trigger these events. IOAPICs 
> are generally found on SMP motherboards (but there are UP boards with 
> them, it's chipset dependent). Generally i686+ (save some Athlons and a 
> few other processors) will work with nmi_watchdog=2.

Forgot this bit;

w/ CONFIG_X86_LOCAL_APIC=y you only have nmi_watchdog=2

w/ CONFIG_X86_IO_APIC=y you have nmi_watchdog=1 and 2

w/ CONFIG_SMP you have nmi_watchdog=1 and 2 as it depends on 
CONFIG_X86_IO_APIC

	Zwane

-- 
function.linuxpower.ca
