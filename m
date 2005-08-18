Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932479AbVHRV70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbVHRV70 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 17:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbVHRV70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 17:59:26 -0400
Received: from ns.suse.de ([195.135.220.2]:50340 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932479AbVHRV70 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 17:59:26 -0400
To: Sean Bruno <sean.bruno@dsl-only.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc6-git10 test report [x86_64]
References: <1124401950.14825.13.camel@home-lap.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 18 Aug 2005 23:59:24 +0200
In-Reply-To: <1124401950.14825.13.camel@home-lap.suse.lists.linux.kernel>
Message-ID: <p73u0hmsy83.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Bruno <sean.bruno@dsl-only.net> writes:

> Just finished building the latest git for my dual-opteron box(ASUS
> K8N-DL with 6GB Ram).  No new issues noted, works about as well as
> 2.6.12 for me.  ASUS still has not addressed their ACPI Table and I am
> doubtful that they ever will.

What was the problem with the ACPI table?

I would suggest you file a proper bug report on that on
http://bugzilla.kernel.org (with boot log of the failure) 

> 
> In order to boot any kernel, I am disabling ACPI in the BIOS.  If I
> enable ACPI, I now get a lock-up referencing the fact the machine has
> 6GB of RAM and no IOMMU.

There is nothing pointing to a lockup in your dmesg
(except perhaps the message about the disconnected timer,
but even then it normally works)

But in general you typically need ACPI for modern machines
because the old style mptables are untested or not even available.

-Andi

