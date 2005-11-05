Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbVKEXnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbVKEXnE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 18:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbVKEXnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 18:43:04 -0500
Received: from fsmlabs.com ([168.103.115.128]:55992 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S1750761AbVKEXnD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 18:43:03 -0500
X-ASG-Debug-ID: 1131234180-8858-13-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Sat, 5 Nov 2005 15:48:39 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: "Jeffrey V. Merkey" <jmerkey@wolfmountaingroup.com>
cc: listmonkey@neo.relay-host.net, linux-kernel@vger.kernel.org
X-ASG-Orig-Subj: Re: SMP CPU affinity questions
Subject: Re: SMP CPU affinity questions
In-Reply-To: <4368EBBF.2000302@wolfmountaingroup.com>
Message-ID: <Pine.LNX.4.61.0511051546310.1526@montezuma.fsmlabs.com>
References: <20051102175022.13637.qmail@neo.relay-host.net>
 <4368EBBF.2000302@wolfmountaingroup.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.5075
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Nov 2005, Jeffrey V. Merkey wrote:

> IOApic's support binding of interrupt delivery in intel based platforms, but I
> am unaware of tools which force this
> setting by default on Linux, but someone else may be able to point you in that
> direction.  Most folks code APIC ICC delivery to
> AV_LOPRI (meaning lowest priority processor gets next interrupt).   This is
> advantageous for cache coherency since the IRQ code
> is probaby still in that processors cache.  You may have to modify the kernel.
> Linux doesn't allow processors to be shutdown and
> reactiviated real time, it just starts them and lets them run, so you don;t
> have to worry about the case of migrating interrupts
> off pinned APICs.  The APIC supports what you are asking for, but I am not
> certain anyone implemented anything other
> than AV_LOPRI settings by default in the IO APIC code.  I would suggest you
> look over the IO APIC Code -- this is a lot
> of work, BTW.

Or you could just put something which writes to 
/proc/irq/$IRQ/smp_affinity in your initscripts.

Cheers,
	Zwane

