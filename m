Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbWDCOSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbWDCOSb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 10:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbWDCOSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 10:18:31 -0400
Received: from rune.pobox.com ([208.210.124.79]:50326 "EHLO rune.pobox.com")
	by vger.kernel.org with ESMTP id S1751233AbWDCOSa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 10:18:30 -0400
Date: Mon, 3 Apr 2006 09:18:05 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Andi Kleen <ak@suse.de>
Cc: Paul Jackson <pj@sgi.com>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, ak@suse.com,
       Christoph Lameter <clameter@sgi.com>
Subject: Re: Fw: 2.6.16 crashes when running numastat on p575
Message-ID: <20060403141805.GC25663@localdomain>
References: <20060402213216.2e61b74e.akpm@osdl.org> <Pine.LNX.4.64.0604022149450.15895@schroedinger.engr.sgi.com> <20060402221513.96f05bdc.pj@sgi.com> <200604031349.03036.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604031349.03036.ak@suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Monday 03 April 2006 07:15, Paul Jackson wrote:
> > -		for (cpu = 0; cpu < NR_CPUS; cpu++) {
> > +		for_each_online_cpu(cpu) {
> > 
> > Idle curiosity -- what keeps a cpu from going offline during
> > this scan, and leaving us with the same crash as before?
> 
> 
> CPU hotdown uses RCU like techniques to avoid this. Only potential
> problem could be on a preemptive kernel, but I hope nobody tries
> cpu unplug on such a beast.

I always turn on preempt when testing cpu hotplug (usually on ppc64).
There were several preempt vs cpu hotplug issues until around 2.6.10
or so, iirc, but I think the situation has been stable for a while
now.
