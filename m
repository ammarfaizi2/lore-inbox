Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265320AbTASCI6>; Sat, 18 Jan 2003 21:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265333AbTASCI6>; Sat, 18 Jan 2003 21:08:58 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:5448
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S265320AbTASCI6>; Sat, 18 Jan 2003 21:08:58 -0500
Date: Sat, 18 Jan 2003 21:13:36 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: linux-kernel@vger.kernel.org, <zwane@linuxpower.ca>, <zab@zabbo.net>,
       <manfred@colorfullife.com>, <macro@ds2.pg.gda.pl>,
       <Martin.Bligh@us.ibm.com>, <jamesclv@us.ibm.com>,
       <andrew.grover@intel.com>
Subject: Re: 48GB NUMA-Q boots, with major IO-APIC hassles
In-Reply-To: <20030119015013.GB780@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0301182102420.24250-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jan 2003, William Lee Irwin III wrote:

> Okay, and here is my latest attempt to deal with the issue (which is
> dirty as sin code-wise, but nm that... I'm trying to debug this).
> 
> This doesn't actually work, I end up deadlocking presumably because
> everything's waiting for an interrupt that's been dropped at some point.

> +int vector_to_irq[MAX_NUMNODES][FIRST_SYSTEM_VECTOR - FIRST_DEVICE_VECTOR + 1];

This can never work by looking at the I/O interrupt section of your MP 
table you're overwriting interrupt gates. Therefore this has the 
unfortunate effect of invalidating the rest of the patch.

Consider this; If you have irq 8 on both ioapic0 and ioapic3 who gets the 
vector setup in the IDT?

	Zwane
-- 
function.linuxpower.ca


