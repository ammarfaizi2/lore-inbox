Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268047AbUHFBEC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268047AbUHFBEC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 21:04:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268042AbUHFBEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 21:04:00 -0400
Received: from cantor.suse.de ([195.135.220.2]:47286 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268047AbUHFBDT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 21:03:19 -0400
Date: Fri, 6 Aug 2004 03:01:56 +0200
From: Andi Kleen <ak@suse.de>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Automatically enable bigsmp on big HP machines
Message-Id: <20040806030156.3a4e7890.ak@suse.de>
In-Reply-To: <88056F38E9E48644A0F562A38C64FB600289B2DC@scsmsx403.amr.corp.intel.com>
References: <88056F38E9E48644A0F562A38C64FB600289B2DC@scsmsx403.amr.corp.intel.com>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Aug 2004 17:54:25 -0700
"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com> wrote:

> 
> 
> Instead of handling these individually for particular systems, 
> can't we just switch to bigsmp whenever we see more than 8 CPU 
> in the CPU enumeration and no other subarchitecture is selected by 
> any dmi override.

This won't work on big AMD boxes I think. They don't have a XAPIC.

The other subarchitectures (es7000,summit) are usually selected using ACPI 
OEM tablesnow, you would need to make sure that it happens after that.

Can you check that the there is really an XAPIC compatible APIC
somewhere in the system? (e.g. by reading the version number from the APIC?)
Then I guess it would be ok.

-Andi

