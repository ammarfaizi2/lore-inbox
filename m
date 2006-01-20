Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751026AbWATOmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbWATOmR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 09:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbWATOmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 09:42:17 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:32960 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751023AbWATOmQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 09:42:16 -0500
Date: Fri, 20 Jan 2006 15:42:12 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Darrick J. Wong" <djwong@us.ibm.com>
cc: linux-kernel@vger.kernel.org, Chris McDermott <lcm@us.ibm.com>
Subject: Re: [PATCH] leave APIC code inactive by default on i386
In-Reply-To: <43D03AF0.3040703@us.ibm.com>
Message-ID: <Pine.LNX.4.61.0601201540500.22940@yvahk01.tjqt.qr>
References: <43D03AF0.3040703@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>This patch is particularly useful for anybody booting a distro UP kernel
>on a multi-chassis IBM x440/x445, because that system requires APIC
>support to boot properly.  If booting a UP kernel on a large SMP machine
>seems silly, think of distro installer kernels. :)  Joe Flakybox can run
>his single-proc i386 box without APIC related breakage, and someone with
>a x445 enable APICs in the UP kernel long enough to install a proper SMP
>kernel.
>
>I know, it seems silly to be providing a patch that changes "enabled
>unless explicitly disabled" to "disabled unless explicitly enabled",
>especially since the APIC code can be forced off.  However, I _am_
>curious to hear what people think about the other parts of the patch.
>At the very least, I'm not quite convinced that noapic & nolapic are
>doing their jobs, because it seems to me that get_smp_config pokes the
>LAPIC and init_apic_mappings maps the IOAPICs into memory regardless of
>whatever flags are passed.  But, I'm not an APIC expert so I'll defer to
>anybody who knows more than I.  Most curiously, passing 'noapic nolapic'
>still yields things like this in dmesg:
>
>Questions?  Flames?  The asbestos underpants have been strapped on. :)

Do you think that people can't properly configure their bootloader to 
include "noapic nolapic" in the options?


Jan Engelhardt
-- 
