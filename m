Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946040AbWJ0Cmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946040AbWJ0Cmk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 22:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161446AbWJ0Cmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 22:42:40 -0400
Received: from colin.muc.de ([193.149.48.1]:9225 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1161441AbWJ0Cmj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 22:42:39 -0400
Date: 27 Oct 2006 04:42:38 +0200
Date: Fri, 27 Oct 2006 04:42:38 +0200
From: Andi Kleen <ak@muc.de>
To: Om Narasimhan <om.turyx@gmail.com>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       linux-kernel@vger.kernel.org, randy.dunlap@oracle.com,
       clemens@ladisch.de, vojtech@suse.cz, bob.picco@hp.com
Subject: Re: HPET : Legacy Routing Replacement Enable - 3rd try.
Message-ID: <20061027024238.GC58088@muc.de>
References: <EB12A50964762B4D8111D55B764A8454C9608C@scsmsx413.amr.corp.intel.com> <6b4e42d10610251420x4365b840sa3232010e7bd7f73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b4e42d10610251420x4365b840sa3232010e7bd7f73@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2006 at 02:20:22PM -0700, Om Narasimhan wrote:
> I tested against five different bioses (some with 8132, some with
> CK-804 ..etc) and I observed three different patterns.
> 
> 1. HW is LRR capable, HPET ACPI it is 1, timer interrupt is on INT2.
> Before the fix: Linux cannot get timer interrupts on INT0, goes for ACPI 
> timer.

What ACPI timer?  I don't think we have any fallback for int 0.

Not sure what you mean with INT2. Pin2 on ioapic 0 perhaps?

> After the fix : Works fine. This is according to hpet spec.

On what exact motherboard was that?

> 
> To handle case 3, I removed all references to acpi_hpet_lrr, explained
> this case in the code and decided to solely rely on the command line
> parameter for LRR capability. Rational for this approach is ,

This means the systems which you said fixes this would need the command
line parameter to work? 

> 1. At present, there are not many BIOSes which implement LRR (correctly)
> 2. People would see the bootup message (MP-BIOS bug...) if LRR is
> enabled and no timer interrupt on INT0. They can pass the hpet_lrr=1
> to make everything work fine.
> Is it the right approach?

Generally we try to work everywhere without command line parameter
unless something is terminally broken. 
-Andi
