Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbVJ0UvU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbVJ0UvU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 16:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbVJ0UvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 16:51:20 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:9607 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S932228AbVJ0UvU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 16:51:20 -0400
Subject: Re: 4GB memory and Intel Dual-Core system
From: Marcel Holtmann <marcel@holtmann.org>
To: Roland Dreier <rolandd@cisco.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <52mzkuwuzg.fsf@cisco.com>
References: <1130445194.5416.3.camel@blade>  <52mzkuwuzg.fsf@cisco.com>
Content-Type: text/plain
Date: Thu, 27 Oct 2005 22:51:18 +0200
Message-Id: <1130446278.5416.10.camel@blade>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roland,

>     Marcel> The BIOS and dmidecode tells me that I have 4 GB of RAM
>     Marcel> installed and I don't have any idea where to look for
>     Marcel> details. What information do you need to analyze this?
> 
> Look at the e820 dump in your kernel bootlog.  I'll bet you'll see a
> big chunk of reserved address space.  Do you have any PCI devices like
> video cards that use a lot of PCI address space?

BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000edbb0 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000cec11000 (usable)
 BIOS-e820: 00000000cec11000 - 00000000cee12000 (ACPI NVS)
 BIOS-e820: 00000000cee12000 - 00000000cf68f000 (usable)
 BIOS-e820: 00000000cf68f000 - 00000000cf6e9000 (ACPI NVS)
 BIOS-e820: 00000000cf6e9000 - 00000000cf6ed000 (usable)
 BIOS-e820: 00000000cf6ed000 - 00000000cf6ff000 (ACPI data)
 BIOS-e820: 00000000cf6ff000 - 00000000cf700000 (usable)

I see the stuff above, but the system doesn't contain any PCI device. I
didn't install a PCI-Express video card, because I still use the onboard
card.

> I don't know if EM64T systems (or whatever the right term is) have a
> way of remapping some RAM above 4 GB so that you can use all your
> memory in a case like this.

The kernel is compiled for x86_64 and the term EM64T is correct. The
important question is now how do I remap that memory. Loosing almost a
full GB of memory wasn't my plan when upgrading to 4 GB.

Regards

Marcel


