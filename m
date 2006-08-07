Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbWHGFkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbWHGFkb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 01:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbWHGFka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 01:40:30 -0400
Received: from ns.suse.de ([195.135.220.2]:41385 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751085AbWHGFk3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 01:40:29 -0400
From: Andi Kleen <ak@muc.de>
To: virtualization@lists.osdl.org
Subject: Re: [PATCH 2/4] x86 paravirt_ops: paravirt_desc.h for native descriptor ops.
Date: Mon, 7 Aug 2006 07:40:23 +0200
User-Agent: KMail/1.9.3
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1154925835.21647.29.camel@localhost.localdomain> <1154925943.21647.32.camel@localhost.localdomain>
In-Reply-To: <1154925943.21647.32.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608070740.23840.ak@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 August 2006 06:45, Rusty Russell wrote:
> Unfortunately, due to include cycles, we can't put these in
> paravirt.h: we use a separate header for these.
> 
> The implementation comes from Zach's [RFC, PATCH 10/24] i386 Vmi descriptor changes:
> 
>   Descriptor and trap table cleanups.  Add cleanly written accessors for
>   IDT and GDT gates so the subarch may override them.  Note that this
>   allows the hypervisor to transparently tweak the DPL of the descriptors
>   as well as the RPL of segments in those descriptors, with no unnecessary
>   kernel code modification.  It also allows the hypervisor implementation
>   of the VMI to tweak the gates, allowing for custom exception frames or
>   extra layers of indirection above the guest fault / IRQ handlers.

Nice cleanup. The old assembly mess was ripe to be killed for a long time.

-Andi

