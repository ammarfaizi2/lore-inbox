Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261188AbVAGC7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbVAGC7G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 21:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbVAGC7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 21:59:06 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:51647 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261188AbVAGC7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 21:59:03 -0500
Subject: Re: [PATCH] kernel/printk.c  lockless access
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Anton Blanchard <anton@samba.org>, Andrew Morton <akpm@osdl.org>,
       Linas Vepstas <linas@austin.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
In-Reply-To: <41DDD6FA.2050403@osdl.org>
References: <20050106195812.GL22274@austin.ibm.com>
	 <20050106161241.11a8d07c.akpm@osdl.org>
	 <20050107002648.GD14239@krispykreme.ozlabs.ibm.com>
	 <41DDD6FA.2050403@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105062162.24896.311.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 07 Jan 2005 01:54:41 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-01-07 at 00:25, Randy.Dunlap wrote:
> > Actually Id love to do this on ppc64 too. Its always difficult to get a
> > customer to remember to save away an oops report.
> 
> We need /proc/kallsyms, /proc/modules, etc. also....
> can you capture all of that for a complete oops/panic analysis?
> (short of kdump, that is)

Ditto on x86 - several of us raised the ideal of ACPI actually defining
a "log area" in the E820 map types or some other ACPI resource that
would be a chunk of RAM used for logs that wasn't going to get bios
eaten on a soft reboot but could be reclaimed by the OS but we didn't
get it.

