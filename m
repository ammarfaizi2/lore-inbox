Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbTK1Qna (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 11:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262674AbTK1Qna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 11:43:30 -0500
Received: from grassmarket.ucs.ed.ac.uk ([129.215.166.64]:33186 "EHLO
	grassmarket.ucs.ed.ac.uk") by vger.kernel.org with ESMTP
	id S262192AbTK1Qn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 11:43:28 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: ross.alexander@uk.neceur.com, "Brendan Howes" <brendan@netzentry.com>
Subject: Re: NForce2 pseudoscience stability testing (2.6.0-test11)
Date: Fri, 28 Nov 2003 16:46:40 +0000
User-Agent: KMail/1.5.93
References: <OF6617181D.A93B9D63-ON80256DEC.004D7534-80256DEC.0053A823@uk.neceur.com>
In-Reply-To: <OF6617181D.A93B9D63-ON80256DEC.004D7534-80256DEC.0053A823@uk.neceur.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200311281646.40171.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 November 2003 15:13, ross.alexander@uk.neceur.com wrote:
[snip]
> 
> The conclusion to this is the problem is in Local APIC with SMP.  I'm not 
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
memory quality, etc. because I and many others like me are able to run Linux 
2.4/2.6 with all the options you tested and still achieve absolute stability, 
on the nForce 2 platform.

My system is an EPOX 8RDA+, with an Athlon 2500+ (Barton) overclocked to 
2.2Ghz, and 2x256MB TwinMOS PC3200 dimms. FSB is at 400Mhz, and the ram 
timings are 4,2,2,2. One might expect such a configuration to be unstable, 
but it is not.

I'm currently running 2.6.0-test10-mm1 with full ACPI (+ routing), APIC and 
local APIC, no preempt, UP, and everything has been rock-solid, despite the 
machine being under constant 100% CPU load and fairly active IO load.

Also, many others have found that just disabling local apic (and the MPS 
setting in the BIOS) as well as ACPI solves their problem, so I'm skeptical 
that SMP really causes *nForce 2 specific* instability.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/AI Undergraduate
contact:    7/10 Darroch Court,
            University of Edinburgh.
