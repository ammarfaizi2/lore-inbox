Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932439AbWFUBgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbWFUBgY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 21:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbWFUBgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 21:36:24 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:30148 "EHLO
	palinux.external.hp.com") by vger.kernel.org with ESMTP
	id S932439AbWFUBgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 21:36:23 -0400
Date: Tue, 20 Jun 2006 19:36:21 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       discuss@x86-64.org, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@suse.de>,
       Natalie Protasevich <Natalie.Protasevich@UNISYS.com>,
       Len Brown <len.brown@intel.com>,
       Kimball Murray <kimball.murray@gmail.com>,
       Brice Goglin <brice@myri.com>, Greg Lindahl <greg.lindahl@qlogic.com>,
       Dave Olson <olson@unixfolk.com>, Jeff Garzik <jeff@garzik.org>,
       Greg KH <gregkh@suse.de>, Grant Grundler <iod00d@hp.com>,
       "bibo,mao" <bibo.mao@intel.com>, Rajesh Shah <rajesh.shah@intel.com>,
       Mark Maule <maule@sgi.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       Shaohua Li <shaohua.li@intel.com>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Ashok Raj <ashok.raj@intel.com>, Randy Dunlap <rdunlap@xenotime.net>,
       Roland Dreier <rdreier@cisco.com>, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 9/25] irq: Add a dynamic irq creation API
Message-ID: <20060621013621.GQ1630@parisc-linux.org>
References: <11508425191381-git-send-email-ebiederm@xmission.com> <11508425192220-git-send-email-ebiederm@xmission.com> <11508425191063-git-send-email-ebiederm@xmission.com> <1150842520235-git-send-email-ebiederm@xmission.com> <11508425201406-git-send-email-ebiederm@xmission.com> <1150842520775-git-send-email-ebiederm@xmission.com> <11508425213394-git-send-email-ebiederm@xmission.com> <115084252131-git-send-email-ebiederm@xmission.com> <1150847764.1901.64.camel@localhost.localdomain> <m1veqvb9tr.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1veqvb9tr.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2006 at 07:01:52PM -0600, Eric W. Biederman wrote:
> So to be very clear what we mean, because I have gotten bitten in the
> past.  I understand the linux irq number to be:
> a) An index in the irq_desc array.
> b) An enumeration of the hardware interrupts sources.
> c) Human visible so ideally it is neither arbitrary, nor
>    very dynamic if the hardware is not.
> 
> Then there is the destination cookie (vector on x86) that is
> available to the cpu when the interrupt is delivered.
> 
> I think we are on a similar track but I'm not at all certain I like
> the idea of a fully dynamic linux irq number except in cases like MSI
> where your sources are dynamic.   But I may be making the wrong
> assumptions about what you are doing.

Hi Eric.  Unfortunately, I've only received [0/25] so far, depsite both
being on the cc list and on linux-pci.  I'm getting all the replies
though, so I'm hopeful I'll receive the original posts soon.

Did you look at the parisc scheme?  We have a fixed area for CPU
interrupts and then an area for dynamic interrupt assignment.  Since
devices are typically discovered in the same order between boots, the
interrupt number doesn't end up varying between boots.

