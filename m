Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264369AbTLBVSY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 16:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264374AbTLBVSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 16:18:24 -0500
Received: from mxsf08.cluster1.charter.net ([209.225.28.208]:44555 "EHLO
	mxsf08.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S264369AbTLBVSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 16:18:20 -0500
Date: Tue, 2 Dec 2003 16:12:56 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: NForce2 pseudoscience stability testing (2.6.0-test11)
Message-ID: <20031202211256.GB28090@forming>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200311281646.40171.s0348365@sms.ed.ac.uk> <OFF4FC9A17.547F8D5E-ON80256DF0.00356F93-80256DF0.00383157@uk.neceur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFF4FC9A17.547F8D5E-ON80256DF0.00356F93-80256DF0.00383157@uk.neceur.com>
X-Editor: GNU Emacs 21.1
X-Operating-System: Debian GNU/Linux 2.6.0-test11-Jm i686
X-Uptime: 15:17:16 up 1 day,  6:56,  3 users,  load average: 1.25, 1.07, 1.02
User-Agent: Mutt/1.5.4i
From: Josh McKinney <forming@charter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To me the strangest thing is that when I first got this board a month or
so ago it would hang with APIC or LAPIC enabled.  Now it works fine
without disabling APIC.  All I did was update the BIOS and use it for a
while with APIC disabled.  2.6.0-test9-mm through 2.6.0-test11 all work
just fine.  Still at the same time some people are reporting that it
works, some are reporting that it doesn't.  I probably wouldn't think to
much of this except I was one of the ones that said APIC causes crashes
with IDE load, but now it doesn't?

On approximately Tue, Dec 02, 2003 at 10:13:46AM +0000, ross.alexander@uk.neceur.com wrote:
> Alistair,
> 
> I upgraded the BIOS about a week ago to 1007.  I personally found it to be 
> less
> stable than 1006.  I don't believe it is a problem with my hardware 
> combination
> since it has been stable for long periods of time.  I was running the SMP 
> kernel
> simply because I (wrongly) presumed a) you needed it to get the IO-APIC 
> working,
> and b) it didn't do any harm.
> 
> It is clear that the UP kernel is considerable more stable than the SMP 
> kernel.  This
> is a very useful fact since it suggests that it is not a problem with the 
> IDE device
> driver per se.  The whole purpose of my testing is to try to determine 
> which options
> increased the stability and hence highlight where the problem could be.
> 
> One of the reasons I don't like ACPI is the huge amount of additional 
> complexity
> it adds and the amount of stuff it could screw up.  Now I have not heard 
> that any
> of the VIA KTxxx based motherboards have any problems.  If this is true 
> then the
> problem does not lie with the LAPIC, since that is in the processor, not 
> the MB.
> The fact that it seems to only occur with the NForce2 chipset means it 
> could
> well be some interrupt coming into the LAPIC from Interrupt Bus.  However
> I certainly don't claim to be an expert on this so I could well be talking 
> complete
> crap.
> 
> Conclusion: More testing required.
> 
> Cheers,
> 
> Ross
> 
> ---------------------------------------------------------------------------------
> Ross Alexander                           "We demand clearly defined
> MIS - NEC Europe Limited            boundaries of uncertainty and
> Work ph: +44 20 8752 3394         doubt."
> 
> 
> 
> 
> Alistair John Strachan <s0348365@sms.ed.ac.uk>
> 28/11/2003 04:46 p.m.
>  
>         To:     ross.alexander@uk.neceur.com, "Brendan Howes" 
> <brendan@netzentry.com>
>         cc:     linux-kernel@vger.kernel.org
>         Subject:        Re: NForce2 pseudoscience stability testing 
> (2.6.0-test11)
> 
> 
> On Friday 28 November 2003 15:13, ross.alexander@uk.neceur.com wrote:
> [snip]
> > 
> > The conclusion to this is the problem is in Local APIC with SMP.  I'm 
> not 
> > saying this is actually true
> > only that is what the data suggests.  If anybody wants me to try some 
> > other stuff feel free to suggest
> > ideas.
> > 
> > Cheers,
> > 
> > Ross
> > 
> 
> It's evidently a configuration problem, albeit BIOS, mainboard revision, 
> memory quality, etc. because I and many others like me are able to run 
> Linux 
> 2.4/2.6 with all the options you tested and still achieve absolute 
> stability, 
> on the nForce 2 platform.
> 
> My system is an EPOX 8RDA+, with an Athlon 2500+ (Barton) overclocked to 
> 2.2Ghz, and 2x256MB TwinMOS PC3200 dimms. FSB is at 400Mhz, and the ram 
> timings are 4,2,2,2. One might expect such a configuration to be unstable, 
> 
> but it is not.
> 
> I'm currently running 2.6.0-test10-mm1 with full ACPI (+ routing), APIC 
> and 
> local APIC, no preempt, UP, and everything has been rock-solid, despite 
> the 
> machine being under constant 100% CPU load and fairly active IO load.
> 
> Also, many others have found that just disabling local apic (and the MPS 
> setting in the BIOS) as well as ACPI solves their problem, so I'm 
> skeptical 
> that SMP really causes *nForce 2 specific* instability.
> 
> -- 
> Cheers,
> Alistair.
> 
> personal:   alistair()devzero!co!uk
> university: s0348365()sms!ed!ac!uk
> student:    CS/AI Undergraduate
> contact:    7/10 Darroch Court,
>             University of Edinburgh.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Josh McKinney		     |	Webmaster: http://joshandangie.org
--------------------------------------------------------------------------
                             | They that can give up essential liberty
Linux, the choice       -o)  | to obtain a little temporary safety deserve 
of the GNU generation    /\  | neither liberty or safety. 
                        _\_v |                          -Benjamin Franklin
