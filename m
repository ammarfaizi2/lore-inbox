Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263522AbTEXTFW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 15:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263534AbTEXTFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 15:05:22 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:7808
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S263522AbTEXTFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 15:05:19 -0400
Date: Sat, 24 May 2003 15:08:19 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "" <linux-smp@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [RFC] Fix NMI watchdog documentation
In-Reply-To: <3ECFC2D6.2020007@gmx.net>
Message-ID: <Pine.LNX.4.50.0305241505470.2267-100000@montezuma.mastecende.com>
References: <3ECFC2D6.2020007@gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 May 2003, Carl-Daniel Hailfinger wrote:

> Documentation/nmi_watchdog.txt does not say which CONFIG_XYZ option has
> to be enabled to use the NMI watchdog, but it mentions that IO-APIC is
> somewhat related.
> 
> Documentation/Configure.help is equally unclear. The NMI watchdog is
> mentioned as related to CONFIG_SMP, and the help text for
> CONFIG_X86_UP_APIC says: "The local APIC supports [..] the NMI watchdog"
> That does not necessarily mean that NMI is compiled in once local APIC
> support is selected.
> 
> Can someone please shed some light on this issue? I'm willing to create
> a patch to fix the docs once I know if the NMI watchdog is compiled in
> alsways or on what it depends.

For nmi_watchdog=1 the NMI watchdog uses the programmable interval timer
to trigger interrupt events via the IOAPIC. with nmi_watchdog=2 we use the 
performance counters on the processor to trigger these events. IOAPICs 
are generally found on SMP motherboards (but there are UP boards with 
them, it's chipset dependent). Generally i686+ (save some Athlons and a 
few other processors) will work with nmi_watchdog=2.

	Zwane
-- 
function.linuxpower.ca
