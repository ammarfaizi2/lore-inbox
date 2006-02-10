Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751296AbWBJQdc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbWBJQdc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 11:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbWBJQdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 11:33:32 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:50386 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751289AbWBJQda
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 11:33:30 -0500
Subject: Re: [Lhms-devel] [RFC/PATCH: 002/010] Memory hotplug for new nodes
	with pgdat allocation. (Wait table and zonelists initalization)
From: Dave Hansen <haveblue@us.ibm.com>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, Andi Kleen <ak@suse.de>,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       linux-ia64@vger.kernel.org,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       x86-64 Discuss <discuss@x86-64.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>
In-Reply-To: <20060210223841.C532.Y-GOTO@jp.fujitsu.com>
References: <20060210223841.C532.Y-GOTO@jp.fujitsu.com>
Content-Type: text/plain
Date: Fri, 10 Feb 2006 08:33:18 -0800
Message-Id: <1139589198.9209.82.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-10 at 23:20 +0900, Yasunori Goto wrote:
> This patch is to initialize wait table and zonelists for new pgdat.
> When new node is added, free_area_init_node() is called to initialize
> pgdat. But, wait table must be allocated by kmalloc (not bootmem) for
> it.
> And, zonelists is accessed from any other process every time,
> So, stop_machine_run() is used for safety update.

I do notice that you're not using init_currently_empty_zone() to
initialize currently empty zones.  Why?

-- Dave

