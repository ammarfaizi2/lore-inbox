Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261836AbVDESGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbVDESGF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 14:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbVDESGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 14:06:04 -0400
Received: from hammer.engin.umich.edu ([141.213.40.79]:22748 "EHLO
	hammer.engin.umich.edu") by vger.kernel.org with ESMTP
	id S261871AbVDESC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 14:02:29 -0400
Date: Tue, 5 Apr 2005 14:02:20 -0400 (EDT)
From: Christopher Allen Wing <wingc@engin.umich.edu>
To: Andi Kleen <ak@muc.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: clock runs at double speed on x86_64 system w/ATI RS200 chipset
In-Reply-To: <m18y3x16rj.fsf@muc.de>
Message-ID: <Pine.LNX.4.58.0504051351200.13242@hammer.engin.umich.edu>
References: <200504031231.j33CVtHp021214@harpo.it.uu.se>
 <Pine.LNX.4.58.0504041050250.32159@hammer.engin.umich.edu> <m18y3x16rj.fsf@muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Apr 2005, Andi Kleen wrote:

> Alternatively you can try to boot with noapic. Does that help?


Yes, with 'noapic' the system boots normally and the clock runs at normal
speed.

dmesg of 2.6.11.6 without any command line options. (default: ACPI
enabled, APIC enabled):

	http://www-personal.engin.umich.edu/~wingc/apictimer/dmesg/dmesg-2.6.11.6-acpi-apic

/proc/interrupts on 2.6.11.6 with ACPI enabled, APIC enabled:

	http://www-personal.engin.umich.edu/~wingc/apictimer/dmesg/interrupts-2.6.11-6-acpi-apic
	(clock runs at double speed)


dmesg of 2.6.11.6 with 'noapic' command line option:

	http://www-personal.engin.umich.edu/~wingc/apictimer/dmesg/dmesg-2.6.11.6-acpi-noapic

/proc/interrupts on 2.6.11.6 with 'noapic':

	http://www-personal.engin.umich.edu/~wingc/apictimer/dmesg/interrupts-2.6.11-6-acpi-noapic
	(clock runs normally)



Are you thinking of blacklisting the APIC on this system until we figure
out what's going on?

-Chris
