Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261796AbVAYDyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbVAYDyb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 22:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbVAYDyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 22:54:31 -0500
Received: from fmr13.intel.com ([192.55.52.67]:28345 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S261796AbVAYDy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 22:54:27 -0500
Subject: Re: [PATCH 6/29] x86-apic-virtwire-on-shutdown
From: Len Brown <len.brown@intel.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <x86-apic-virtwire-on-shutdown-11061198973730@ebiederm.dsl.xmission.com>
References: <x86-apic-virtwire-on-shutdown-11061198973730@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Organization: 
Message-Id: <1106625259.2395.232.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 24 Jan 2005 22:54:19 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-19 at 02:31, Eric W. Biederman wrote:
> When coming out of apic mode attempt to set the appropriate
> apic back into virtual wire mode.  This improves on previous versions
> of this patch by by never setting bot the local apic and the ioapic
> into veritual wire mode.
> 
> This code looks at data from the mptable to see if an ioapic has
> an ExtInt input to make this decision.  A future improvement
> is to figure out which apic or ioapic was in virtual wire mode
> at boot time and to remember it.  That is potentially a more accurate
> method, of selecting which apic to place in virutal wire mode.
> 

The call to find_isa_irq_pin() will always fail on ACPI-enabled systems,
so this patch is a NO-OP unless the system is booted in MPS mode.

Do we really want to be adding this complexity for obsolete systems? 
Are there systems that fail without this patch?

-Len


