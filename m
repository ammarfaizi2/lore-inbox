Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263952AbTEWItt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 04:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263957AbTEWItt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 04:49:49 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:60088 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263952AbTEWIts (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 04:49:48 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16077.58300.246307.48856@gargle.gargle.HOWL>
Date: Fri, 23 May 2003 11:02:52 +0200
From: mikpe@csd.uu.se
To: brouard@ined.fr
Cc: linux-kernel@vger.kernel.org
Subject: Re: "Latitude with broken BIOS" ?
In-Reply-To: <200305231055.14872.brouard@ined.fr>
References: <200305231055.14872.brouard@ined.fr>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brouard Nicolas writes:
 > I am not well aware of what APIC is but I was running Mandrake 8.2 on my Linux 
 > partition of a Dell Pentium III latitude 550 MHz and I don't remember such a 
 > dmesg message. But when I upgraded to Mandrake 9.1 here it is. The problem I 
 > have is that I can't have any suspend mode any more neither battery 
 > indicators and /etc/rc.d/init.d/apm start claims that apm is no more in the 
 > kernel. Is it linked to that APIC problem and this BIOS problem, why did it 
 > work earlier? Do you think that if I found a new bios from Dell it will help?

The "$machine with broken BIOS detected, refusing to enable the local APIC"
message only affects the local APIC and the few services using it like the
NMI watchdog and some performance measurement/profiling tools.
It has no impact on whether APM works or not.

Possibly Mandrake 9.1 detects ACPI (not APIC) which would disable APM.
Try booting with "noacpi" or "acpi=off" or whatever the option is called.
