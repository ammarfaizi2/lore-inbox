Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423930AbWKADSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423930AbWKADSR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 22:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423929AbWKADSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 22:18:17 -0500
Received: from hera.kernel.org ([140.211.167.34]:50056 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1423853AbWKADSQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 22:18:16 -0500
From: Len Brown <len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.19-rc <-> ThinkPads
Date: Tue, 31 Oct 2006 22:15:43 -0500
User-Agent: KMail/1.8.2
Cc: Hugh Dickins <hugh@veritas.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Pavel Machek <pavel@suse.cz>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org, linux-pm@osdl.org,
       Martin Lorenz <martin@lorenz.eu.org>
References: <20061029231358.GI27968@stusta.de> <20061030135625.GB1601@mellanox.co.il> <20061101030126.GE27968@stusta.de>
In-Reply-To: <20061101030126.GE27968@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610312215.44454.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The BIOS disables the LAPIC for a reason.
A couple of years ago Linux made the mistake of enabling the LAPIC
that the BIOS disabled, and all hell broke loose.
We fixed that bug about a year ago, but left "lapic"
to force it on for those where forcing it to be enabled actually
works (eg. some folks want the NMI profiling on their IOAPIC-less  laptop)

But if you force the lapic to be enabled, you are running the system
in a mode not supported by the manufacturer and you are on your own.

I don't see an indication that this is a bug.
If it used to work and it is important to you,
 then run the old software where it used to work --
because chances are good that it worked by accident.

-Len

On Tuesday 31 October 2006 22:01, Adrian Bunk wrote:
> FYI:
> 
> Subject    : Thinkpad R50p: boot fail with (lapic && on_battery)
> References : http://lkml.org/lkml/2006/10/31/333
> Submitter  : Ernst Herzberg <earny@net4u.de>
> Status     : submitter was asked to bisect
> 
> It seems to be completely unrelated (except that it's also a ThinkPad), 
> but it might be worth a try whether a (non-SMP) kernel without APIC 
> support fixes the issues after resume.
> 
> Hugh, your laptop seems to be a non-SMP laptop.
> Do you have APIC enabled, and if yes does disabling help?
> 
> cu
> Adrian
> 
> 
> VERSION = 2
> PATCHLEVEL = 6
> SUBLEVEL = 19
> EXTRAVERSION = -rc4
> NAME=ThinkPad Killer
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
