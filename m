Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265333AbTASCSD>; Sat, 18 Jan 2003 21:18:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265339AbTASCSD>; Sat, 18 Jan 2003 21:18:03 -0500
Received: from holomorphy.com ([66.224.33.161]:39813 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265333AbTASCSC>;
	Sat, 18 Jan 2003 21:18:02 -0500
Date: Sat, 18 Jan 2003 18:27:00 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: linux-kernel@vger.kernel.org, zwane@linuxpower.ca, zab@zabbo.net,
       manfred@colorfullife.com, macro@ds2.pg.gda.pl, Martin.Bligh@us.ibm.com,
       jamesclv@us.ibm.com, andrew.grover@intel.com
Subject: Re: 48GB NUMA-Q boots, with major IO-APIC hassles
Message-ID: <20030119022700.GC780@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zwane Mwaikambo <zwane@holomorphy.com>,
	linux-kernel@vger.kernel.org, zwane@linuxpower.ca, zab@zabbo.net,
	manfred@colorfullife.com, macro@ds2.pg.gda.pl,
	Martin.Bligh@us.ibm.com, jamesclv@us.ibm.com,
	andrew.grover@intel.com
References: <20030119015013.GB780@holomorphy.com> <Pine.LNX.4.44.0301182102420.24250-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301182102420.24250-100000@montezuma.mastecende.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jan 2003, William Lee Irwin III wrote:
>> +int vector_to_irq[MAX_NUMNODES][FIRST_SYSTEM_VECTOR - FIRST_DEVICE_VECTOR + 1];

On Sat, Jan 18, 2003 at 09:13:36PM -0500, Zwane Mwaikambo wrote:
> This can never work by looking at the I/O interrupt section of your MP 
> table you're overwriting interrupt gates. Therefore this has the 
> unfortunate effect of invalidating the rest of the patch.
> Consider this; If you have irq 8 on both ioapic0 and ioapic3 who gets the 
> vector setup in the IDT?

Neither. The patch pushes the _real_ vector number and translates it to
a software interrupt number with table lookup, which includes the node ID.


Bill
