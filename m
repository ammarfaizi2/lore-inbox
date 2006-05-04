Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbWECX7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbWECX7c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 19:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWECX7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 19:59:32 -0400
Received: from xenotime.net ([66.160.160.81]:10158 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750823AbWECX7b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 19:59:31 -0400
Date: Wed, 3 May 2006 17:01:55 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: ak@suse.de, len.brown@intel.com, Natalie.Protasevich@unisys.com,
       sergio@sergiomb.no-ip.org, kimball.murray@gmail.com,
       linux-kernel@vger.kernel.org, akpm@digeo.com, kmurray@redhat.com,
       linux-acpi@vger.kernel.org
Subject: Re: [RFC][PATCH] Document what in IRQ is.
Message-Id: <20060503170155.e8e9a92b.rdunlap@xenotime.net>
In-Reply-To: <m1aca07cvd.fsf_-_@ebiederm.dsl.xmission.com>
References: <CFF307C98FEABE47A452B27C06B85BB652DF16@hdsmsx411.amr.corp.intel.com>
	<200605020946.46050.ak@suse.de>
	<m1aca07cvd.fsf_-_@ebiederm.dsl.xmission.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 May 2006 07:52:22 -0600 Eric W. Biederman wrote:

> Andi Kleen <ak@suse.de> writes:
> 
> > P.S.: There seems to be a lot of confusion about all this.
> > Maybe it would make sense to do a write up defining all the terms
> > and stick it into Documentation/* ? 
> 
> How does this look?
> 
> I am pretty horrible when it comes to Documentation,
> but this seems to be the essence of what I was saying earlier.
> 
> Eric
> 
> 
> diff --git a/Documentation/IRQ.txt b/Documentation/IRQ.txt
> new file mode 100644
> index 0000000..5340369
> --- /dev/null
> +++ b/Documentation/IRQ.txt
> @@ -0,0 +1,22 @@
> +What is an IRQ?
> +
> +An IRQ is an interrupt request from a device.
> +Currently they can come in over a pin, or over a packet.

No comma.  Change packet to message?

> +IRQs at the source can be shared.

Huh?  That simple sentence confuses me.  Should "source" really be
"sink" or "destination"?  Or maybe say "IRQs at an interrupt controller
can be shared."  Or is that too hardware-specific?
Anyway, what source is meant here?  It doesn't mean that IRQs
at the producer device can be shared, right?  It's more at the
consumer device where they can be shared.

> +An IRQ number is a kernel identifier used to talk about a hardware
> +interrupt source.  Typically this is an index into the global irq_desc
> +array, but except for what linux/interrupt.h implements the details
> +are architecture specific.
> +
> +An IRQ number is an enumeration of the possible interrupt sources on a
> +machine.  Typically what is enumerated is the number of input pins on
> +all of the interrupt controller in the system.  In the case of ISA
                        controllers
> +what is enumerated are the 16 input pins to the pair of i8259
                      is
> +interrupt controllers.
> +
> +Architectures can assign additional meaning to the IRQ numbers, and
> +are encouraged to in the case  where there is any manual configuration
> +of the hardware involved.  The ISA IRQ case on x86 where anyone who
> +has been around a while can tell you how the first 16 IRQs map to the
                   awhile
> +input pins on a pair of i8259s is the classic example.


---
~Randy
