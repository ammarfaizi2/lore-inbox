Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261937AbVCVU6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbVCVU6A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 15:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbVCVU57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 15:57:59 -0500
Received: from mailhub.hp.com ([192.151.27.10]:57220 "EHLO mailhub.hp.com")
	by vger.kernel.org with ESMTP id S261937AbVCVU5x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 15:57:53 -0500
Message-ID: <41062.15.99.19.46.1111525073.squirrel@mail.atl.hp.com>
In-Reply-To: <Pine.LNX.4.62.0503220022290.7305@alpha.polcom.net>
References: <1110989436.8378.19.camel@eeyore> 
    <1111023217.15278.7.camel@sli10-desk.sh.intel.com> 
    <1111082914.11380.30.camel@eeyore> 
    <1111108150.22239.6.camel@sli10-desk.sh.intel.com> 
    <1111169239.13286.39.camel@eeyore> <1111422838.17576.22.camel@eeyore>
    <Pine.LNX.4.62.0503220022290.7305@alpha.polcom.net>
Date: Tue, 22 Mar 2005 13:57:53 -0700 (MST)
Subject: Re: [ACPI] Re: Fw: Anybody? 2.6.11 (stable and -rc) ACPI breaks USB
From: "Bjorn Helgaas" <bjorn.helgaas@hp.com>
To: "Grzegorz Kulewski" <kangur@polcom.net>
Cc: "Bjorn Helgaas" <bjorn.helgaas@hp.com>,
       "Li Shaohua" <shaohua.li@intel.com>,
       "Zwane Mwaikambo" <zwane@arm.linux.org.uk>,
       "Andrew Morton" <akpm@osdl.org>,
       "ACPI List" <acpi-devel@lists.sourceforge.net>,
       "lkml" <linux-kernel@vger.kernel.org>,
       "Len Brown" <len.brown@intel.com>
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Your patch applied with some problems:
>
> patching file arch/i386/pci/irq.c
> Hunk #2 succeeded at 1081 with fuzz 2 (offset 1 line).
> patching file drivers/acpi/pci_irq.c
> patching file drivers/pci/quirks.c
> Hunk #1 succeeded at 678 (offset -5 lines).

These indicate minor differences in these files between upstream BK
(which is what my patch was against) and the kernel you're building.
You can ignore them.

> Then I tested it and it works (at least my speedtouch still works).

Great.  Shaohua, where should we go from here?  Do you have more
concerns with the current patch, or should we ask Andrew to put it
in -mm?  If you do have concerns, would you like to propose an
alternate patch that fixes the problem for Grzegorz?

> Mar 22 01:32:37 kangur speedtch: Unknown symbol release_firmware
> Mar 22 01:32:37 kangur usb 1-2: modprobe timed out on ep0in

I don't know about the above messages, but I don't think they're
related to the Via quirk we're working on at the moment.  Probably
some mismatch between the kernel you built and the modules.

