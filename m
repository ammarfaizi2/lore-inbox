Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965103AbWGKDwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965103AbWGKDwG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 23:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965104AbWGKDwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 23:52:06 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:18618 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965103AbWGKDwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 23:52:03 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, Dave Olson <olson@unixfolk.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Initial generic hypertransport interrupt support.
References: <m1fyh9m7k6.fsf@ebiederm.dsl.xmission.com>
	<m1bqrxm6zm.fsf@ebiederm.dsl.xmission.com>
	<1152571162.1576.122.camel@localhost.localdomain>
Date: Mon, 10 Jul 2006 21:51:03 -0600
In-Reply-To: <1152571162.1576.122.camel@localhost.localdomain> (Benjamin
	Herrenschmidt's message of "Tue, 11 Jul 2006 08:39:22 +1000")
Message-ID: <m14pxolryw.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:


> At this point, the only PPCs with HT interrupts that I know are 970
> based solutions using the Apple U3/U4 bridges (and their IBM
> counterparts). Thus all HT interrupts are routed to the MPIC as sources,
> so things like masking, affinity, etc... are all handled at the MPIC
> level, not at the HT level and they all originate from either an Apple
> home made HT APIC or standard HT APICs in PCI-X/E tunnels. We still need
> to poke around with the HT APICs for configuration and EOI on level
> interrupts (due to a bug in the Apple MPIC, the EOI doesn't get sent
> back to the HT APIC) but we have code locally in the MPIC driver to do
> it and I don't think it would fit well a generic layer.
>
> Things might be different in the future... but for now, I'm afraid I
> have no use of that HT layer.

I didn't really expect you to have an immediate use, but the
confirmation is nice.  The interesting part is how I have factored out
the arch specific details. I believe this is close to the direction
you envisioned for msi.  If you could look at the basic structure
and confirm that the structure looks properly arch neutral that
would be appreciated.  As time permits I want to make the msi code
look more the this hypertransport irq code.

Eric

