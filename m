Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264059AbTE3XUf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 19:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264060AbTE3XUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 19:20:35 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:45185
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S264059AbTE3XUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 19:20:33 -0400
Date: Fri, 30 May 2003 19:23:33 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: "Brian J. Murrell" <brian@interlinx.bc.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: local apic timer ints not working with vmware: nolocalapic
In-Reply-To: <pan.2003.05.30.22.14.35.511205@interlinx.bc.ca>
Message-ID: <Pine.LNX.4.50.0305301907230.29718-100000@montezuma.mastecende.com>
References: <2C8EEAE5E5C@vcnet.vc.cvut.cz> <20030528173432.GA21379@linux.interlinx.bc.ca>
 <Pine.LNX.4.50.0305281341160.1982-100000@montezuma.mastecende.com>
 <pan.2003.05.30.22.14.35.511205@interlinx.bc.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 May 2003, Brian J. Murrell wrote:

> On Wed, 28 May 2003 13:42:13 -0400, Zwane Mwaikambo wrote:
> > 
> > I submitted a patch for nolapic before...
> 
> Did you get any response as to whether it was going to be accepted into
> the kernel or not?

Considering the dalay, i'll resend and give it another go, but generally 
it means it's not going anywhere.

> The unfortunate thing is that even this sort of fix will not help my
> situation.  The reason being (which I only discovered by accident when I
> set "dont_enable_local_apic = 1" rather than "dont_use_local_apic_timer"
> and it didn't correct the booting problem) is that it seems that even if
> the local apic is set disabled by setting dont_enable_local_apic = 1 in
> arch/i386/kernel/apic.c, setup_APIC_clocks() is still called.

How did you determine that? printks? Was this with my patch applied? I 
originally did this patch for the exact same problem (buggy local APIC 
implimentation).

(much snipped)
Linux version 2.5.70-mm1 (zwane@montezuma.mastecende.com) (gcc version 
Kernel command line: nolapic nmi_watchdog=2 ro root=/dev/hda1 profile=2 
debug console=tty0 cons0
kernel profiling enabled
Initializing CPU#0
CPU0: Intel Celeron (Mendocino) stepping 05
per-CPU timeslice cutoff: 365.65 usecs.
task migration cache decay timeout: 1 msecs.
SMP motherboard not detected.
Local APIC not detected. Using dummy APIC emulation.
Starting migration thread for cpu 0

> So the jist is that using the local apic timer feature is not dependent on
> using the local apic, as per the dont_enable_local_apic and
> dont_use_local_apic_timer flags in arch/i386/kernel/apic.c.  Maybe this is
> wrong, I dunno unfortunately.
> 
> I don't know anything about this APIC stuff so I don't know if that is
> correct or not, but it is what happens.
> 
> Thanx for the input though, much appreciated,

You're welcome,
	Zwane
-- 
function.linuxpower.ca
