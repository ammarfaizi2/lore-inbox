Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263921AbTEXTaz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 15:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264119AbTEXTaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 15:30:55 -0400
Received: from imap.gmx.net ([213.165.65.60]:62101 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263921AbTEXTax (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 15:30:53 -0400
Message-ID: <3ECFCB7B.4080107@gmx.net>
Date: Sat, 24 May 2003 21:43:55 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linuxpower.ca>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-smp@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>
Subject: Re: [RFC] Fix NMI watchdog documentation
References: <3ECFC2D6.2020007@gmx.net> <Pine.LNX.4.50.0305241505470.2267-100000@montezuma.mastecende.com> <Pine.LNX.4.50.0305241509380.2267-100000@montezuma.mastecende.com>
In-Reply-To: <Pine.LNX.4.50.0305241509380.2267-100000@montezuma.mastecende.com>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> On Sat, 24 May 2003, Zwane Mwaikambo wrote:
> 
> 
>>For nmi_watchdog=1 the NMI watchdog uses the programmable interval timer
>>to trigger interrupt events via the IOAPIC. with nmi_watchdog=2 we use the 
>>performance counters on the processor to trigger these events. IOAPICs 
>>are generally found on SMP motherboards (but there are UP boards with 
>>them, it's chipset dependent). Generally i686+ (save some Athlons and a 
>>few other processors) will work with nmi_watchdog=2.
> 
> 
> Forgot this bit;
> 
> w/ CONFIG_X86_LOCAL_APIC=y you only have nmi_watchdog=2
> 
> w/ CONFIG_X86_IO_APIC=y you have nmi_watchdog=1 and 2
> 
> w/ CONFIG_SMP you have nmi_watchdog=1 and 2 as it depends on 
> CONFIG_X86_IO_APIC

Marc-Christian Petersen wrote:
> the nmi_watchdog is always compiled in if you select "CONFIG_X86_LOCAL_APIC"
> 
> see "arch/i386/kernel/Makefile"

Thanks to all who responded. I will prepare a patch for
Documentation/nmi_watchdog.txt to clarify it and send the patch to Linus
and Marcelo.


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/

