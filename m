Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263178AbUCSXUq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 18:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263184AbUCSXUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 18:20:46 -0500
Received: from fmr06.intel.com ([134.134.136.7]:25286 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S263178AbUCSXUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 18:20:45 -0500
Subject: Re: idle Athlon with IOAPIC is 10C warmer since 2.6.3-bk1
From: Len Brown <len.brown@intel.com>
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Cc: Thomas Schlichter <thomas.schlichter@web.de>, ross@datscreative.com.au,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-kernel@vger.kernel.org
In-Reply-To: <405B4893.70701@gmx.de>
References: <200403181019.02636.ross@datscreative.com.au>
	 <200403191955.38059.thomas.schlichter@web.de>  <405B4893.70701@gmx.de>
Content-Type: text/plain
Organization: 
Message-Id: <1079738422.7279.308.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 19 Mar 2004 18:20:22 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-03-19 at 14:22, Prakash K. Cheemplavam wrote:

> Hmm, I just did a cat /proc/acpi/processor/CPU0/power:
> active state:            C1
> default state:           C1
> bus master activity:     00000000
> states:
>     *C1:                  promotion[--] demotion[--] latency[000] 
> usage[00000000]
>      C2:                  <not supported>
>      C3:                  <not supported>
> 
> I am currently NOT using APIC mode (nforce2, as well) and using vanilla 
> 2.6.4. It seems C1 halt state isn't used, which exlains why I am having 
> trouble to keep my CPU cooler these day. I once started a thread 
> suspecting acpi timer, but it is not the case. It seems to be something 
> else. As I don't use PIC, it cannot be that  8259-timer-ack-fix.patch 
> causin git, or can it? Maybe something broken in ACPI? I might try out 
> older kernels to find out...
> 
> Prakash

Actually I think it is that we don't _count_ C1 usage.

cheers,
-Len


