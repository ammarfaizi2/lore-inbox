Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264267AbTEGTbb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 15:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264266AbTEGTba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 15:31:30 -0400
Received: from [66.212.224.118] ([66.212.224.118]:46094 "HELO
	hemi.commfireservices.com") by vger.kernel.org with SMTP
	id S264264AbTEGTbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 15:31:02 -0400
Date: Wed, 7 May 2003 15:34:50 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: James Cleverdon <jamesclv@us.ibm.com>
Cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrew Grover <andrew.grover@intel.com>
Subject: Re: [RFC][PATCH] linux-2.5.69_clear-smi-fix_A0
In-Reply-To: <200305070754.08881.jamesclv@us.ibm.com>
Message-ID: <Pine.LNX.4.50.0305071533230.2157-100000@montezuma.mastecende.com>
References: <1052258319.4503.7.camel@w-jstultz2.beaverton.ibm.com>
 <200305070754.08881.jamesclv@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 May 2003, James Cleverdon wrote:

> John,
> 
> That looks reasonable to me.  The one possible catch would be for systems so 
> old they don't do SMI -- 386s and 486s, I imagine.  If this code doesn't barf 
> on them when CONFIG_IO_APIC is turned on, then it should be fine (minus the 
> printk).
> 
> (I believe there was at least one such system, the Intel Xpress box.  It 
> contained a 486 and seperate APIC chips.)

Referring to this?

Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: INTEL    Product ID: XXPRESS      APIC at: 0xFEE00000
Processor #0 5:2 APIC version 16
Processor #3 5:2 APIC version 16
Processor #4 5:2 APIC version 16
Unknown bustype XPRESS - ignoring
I/O APIC #14 Version 17 at 0xFEC00000.
I/O APIC #13 Version 17 at 0xFFE7F800.
Enabling APIC mode:  Flat.  Using 2 I/O APICs
Processors: 3

John's check should be safe as it doesn't touch hardware anyway.

	Zwane
-- 
function.linuxpower.ca
