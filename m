Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbUKSCAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbUKSCAm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 21:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbUKSB6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 20:58:10 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:61124 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261232AbUKSB4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 20:56:09 -0500
From: kernel-stuff <kernel-stuff@comcast.net>
To: Andi Kleen <ak@suse.de>
Subject: Re: X86_64: Many Lost ticks
Date: Thu, 18 Nov 2004 20:56:02 -0500
User-Agent: KMail/1.7.1
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>, linux-kernel@vger.kernel.org,
       acurrid@nvidia.com
References: <111820041702.27846.419CD5AD000313A800006CC6220588448400009A9B9CD3040A029D0A05@comcast.net> <20041118184904.GN17532@wotan.suse.de>
In-Reply-To: <20041118184904.GN17532@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411182056.03184.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi / Zwane
Ignore my earlier mail about the DMA timeouts and NMI errors after applying 
the ACPI timer override patch.  My bad.  I forgot to recompile the modules 
after I applied your patch - and I believe thats what caused those errors. 
I recompiled and reinstalled the modules this time and no errors [well, apart 
from those lost ticks, which anyway is a separate issue]  with the ACPI Timer 
override for NVIDIA chipset. 

Alan - Needless to say you should keep Andi's NVIDIA ACPI Timer override patch 
in -ac. It works.

Sorry for the confusion!

Parry

On Thursday 18 November 2004 13:49, Andi Kleen wrote:
> On Thu, Nov 18, 2004 at 05:02:37PM +0000, kernel-stuff@comcast.net wrote:
> > I tried all the newer kernels including -ac. All have the same problem.
> >
> > Andi -  On a side note, your change  "NVidia ACPI timer override" present
> > in 2.6.9-ac8 breaks on my laptop - I get some NMI errors ("Do you have a
> > unusual power management setup?") and DMA timeouts - happens regularly.
>
> Hmm, I was told Timer overrides are always bogus on Nvidia and
> that it was the last remaining known apic bug.
> But perhaps there are other APIC bugs in there.
>
> Can you submit a full boot.msg of the problem?
>
> -Andi
