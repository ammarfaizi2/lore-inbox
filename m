Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261793AbSJQE5h>; Thu, 17 Oct 2002 00:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261792AbSJQE5g>; Thu, 17 Oct 2002 00:57:36 -0400
Received: from modemcable061.219-201-24.mtl.mc.videotron.ca ([24.201.219.61]:392
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261791AbSJQE5f>; Thu, 17 Oct 2002 00:57:35 -0400
Date: Thu, 17 Oct 2002 00:49:56 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Doug Ledford <dledford@redhat.com>
cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
       <linux-scsi@vger.kernel.org>
Subject: Re: 2.5.43 IO-APIC bug and spinlock deadlock
In-Reply-To: <20021017033302.GP8159@redhat.com>
Message-ID: <Pine.LNX.4.44.0210162346470.10922-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2002, Doug Ledford wrote:

> IO-APIC bug: regular kernel, UP, no IO-APIC or APIC on UP enabled, compile
> fails (does *everyone* run SMP or at least UP + APIC now?)
> 
> spinlock deadlock: run an smp kernel on a up machine.  On mine here all I 
> have to do is try to boot to multiuser mode, it won't make it through the 
> startup scripts before it locks up by trying to reenter common_interrupt 
> on the only CPU.  Seems like an SMP kernel on UP hardware doesn't disable 
> interrupts properly maybe?  I get task lists via alt-sysreq when the 
> machine should be hardlocked I think.  Anyway, this is what has been 
> tricking me into thinking I had an IDE problem.  IDE is innocent, it's the 
> core interrupt handling code.

Hmm i'm running an SMP kernel on a UP (only Local-APIC present) and the 
machine is currently running X. I've gotten an SMP kernel on a UP box 
without any APICs to also go multiuser too (currently 30 minutes uptime).

	Zwane
-- 
function.linuxpower.ca


