Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbTLBKOT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 05:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbTLBKOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 05:14:19 -0500
Received: from mail2.neceur.com ([193.116.254.4]:26500 "EHLO mail2.neceur.com")
	by vger.kernel.org with ESMTP id S261890AbTLBKON (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 05:14:13 -0500
In-Reply-To: <200311281646.40171.s0348365@sms.ed.ac.uk>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: "Brendan Howes" <brendan@netzentry.com>, linux-kernel@vger.kernel.org
Subject: Re: NForce2 pseudoscience stability testing (2.6.0-test11)
MIME-Version: 1.0
X-Mailer: Lotus Notes Build V65_M1_04032003NP April 03, 2003
Message-ID: <OFF4FC9A17.547F8D5E-ON80256DF0.00356F93-80256DF0.00383157@uk.neceur.com>
From: ross.alexander@uk.neceur.com
Date: Tue, 2 Dec 2003 10:13:46 +0000
X-MIMETrack: Serialize by Router on LDN-THOTH/E/NEC(Release 5.0.10 |March 22, 2002) at
 12/02/2003 10:13:46 AM,
	Serialize complete at 12/02/2003 10:13:46 AM,
	Itemize by SMTP Server on ldn-hermes/E/NEC(Release 5.0.10 |March 22, 2002) at
 12/02/2003 10:13:47 AM,
	Serialize by Router on ldn-hermes/E/NEC(Release 5.0.10 |March 22, 2002) at
 12/02/2003 10:13:49 AM,
	Serialize complete at 12/02/2003 10:13:49 AM
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair,

I upgraded the BIOS about a week ago to 1007.  I personally found it to be 
less
stable than 1006.  I don't believe it is a problem with my hardware 
combination
since it has been stable for long periods of time.  I was running the SMP 
kernel
simply because I (wrongly) presumed a) you needed it to get the IO-APIC 
working,
and b) it didn't do any harm.

It is clear that the UP kernel is considerable more stable than the SMP 
kernel.  This
is a very useful fact since it suggests that it is not a problem with the 
IDE device
driver per se.  The whole purpose of my testing is to try to determine 
which options
increased the stability and hence highlight where the problem could be.

One of the reasons I don't like ACPI is the huge amount of additional 
complexity
it adds and the amount of stuff it could screw up.  Now I have not heard 
that any
of the VIA KTxxx based motherboards have any problems.  If this is true 
then the
problem does not lie with the LAPIC, since that is in the processor, not 
the MB.
The fact that it seems to only occur with the NForce2 chipset means it 
could
well be some interrupt coming into the LAPIC from Interrupt Bus.  However
I certainly don't claim to be an expert on this so I could well be talking 
complete
crap.

Conclusion: More testing required.

Cheers,

Ross

---------------------------------------------------------------------------------
Ross Alexander                           "We demand clearly defined
MIS - NEC Europe Limited            boundaries of uncertainty and
Work ph: +44 20 8752 3394         doubt."




Alistair John Strachan <s0348365@sms.ed.ac.uk>
28/11/2003 04:46 p.m.
 
        To:     ross.alexander@uk.neceur.com, "Brendan Howes" 
<brendan@netzentry.com>
        cc:     linux-kernel@vger.kernel.org
        Subject:        Re: NForce2 pseudoscience stability testing 
(2.6.0-test11)


On Friday 28 November 2003 15:13, ross.alexander@uk.neceur.com wrote:
[snip]
> 
> The conclusion to this is the problem is in Local APIC with SMP.  I'm 
not 
> saying this is actually true
> only that is what the data suggests.  If anybody wants me to try some 
> other stuff feel free to suggest
> ideas.
> 
> Cheers,
> 
> Ross
> 

It's evidently a configuration problem, albeit BIOS, mainboard revision, 
memory quality, etc. because I and many others like me are able to run 
Linux 
2.4/2.6 with all the options you tested and still achieve absolute 
stability, 
on the nForce 2 platform.

My system is an EPOX 8RDA+, with an Athlon 2500+ (Barton) overclocked to 
2.2Ghz, and 2x256MB TwinMOS PC3200 dimms. FSB is at 400Mhz, and the ram 
timings are 4,2,2,2. One might expect such a configuration to be unstable, 

but it is not.

I'm currently running 2.6.0-test10-mm1 with full ACPI (+ routing), APIC 
and 
local APIC, no preempt, UP, and everything has been rock-solid, despite 
the 
machine being under constant 100% CPU load and fairly active IO load.

Also, many others have found that just disabling local apic (and the MPS 
setting in the BIOS) as well as ACPI solves their problem, so I'm 
skeptical 
that SMP really causes *nForce 2 specific* instability.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/AI Undergraduate
contact:    7/10 Darroch Court,
            University of Edinburgh.


