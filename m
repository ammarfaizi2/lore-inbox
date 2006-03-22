Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751026AbWCVSjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbWCVSjx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 13:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbWCVSjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 13:39:53 -0500
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:704 "EHLO
	mail1.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S1751026AbWCVSjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 13:39:52 -0500
Date: Wed, 22 Mar 2006 13:39:43 -0500
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: Andi Kleen <ak@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Lee Revell <rlrevell@joe-job.com>, Jeff Garzik <jeff@garzik.org>,
       Jason Baron <jbaron@redhat.com>, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>
Subject: Re: libata/sata_nv latency on NVIDIA CK804 [was Re: AMD64 X2 lost ticks on PM timer]
Message-ID: <20060322183943.GA30492@ti64.telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	Andi Kleen <ak@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
	Jeff Garzik <jeff@garzik.org>, Jason Baron <jbaron@redhat.com>,
	linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
References: <200602280022.40769.darkray@ic3man.com> <1142522019.13318.27.camel@localhost.localdomain> <20060316165737.GA23248@ti64.telemetry-investments.com> <200603221709.09846.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603221709.09846.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2006 at 05:09:08PM +0100, Andi Kleen wrote:
> perfctr0 is already programmed. You can just use rdpmc on it
> 
> Also my latest patchkit has a debugging patch for lost tries
> 
> ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt/patches/lost-cli-debug

Excellent.

> Can you test it with this patch? 
 
I'll give it a try this evening; the test box is an
FC5 upgrade guinea pig at the moment, and only half-migrated.

> I'm still not quite convinced you're barking at the right tree
> with these latency traces because it doesn't match the symptoms.

Yes, I agree that that the latency issue is not due to the inb(),
as I get lost ticks almost continuously at 1 KHZ, and the inb()-related
latency occurs with much lower frequency.

However, a 17ms inb() latency is rather dismal, and I need to
address that hardware issue, perhaps by purchasing a 4-port card.

I have not been chasing the other issue because the test box appears to
keep perfect time with the -rt patch (on SMP) and NTP doesn't complain at
all; I haven't yet had the chance to determine whether that is entirely
due to John Stultz's new code, or if the preemption is responsible.

	-Bill

