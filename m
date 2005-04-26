Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbVDZNWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbVDZNWP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 09:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbVDZNWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 09:22:14 -0400
Received: from ns2.suse.de ([195.135.220.15]:63651 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261509AbVDZNWA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 09:22:00 -0400
Date: Tue, 26 Apr 2005 15:21:49 +0200
From: Andi Kleen <ak@suse.de>
To: Li Shaohua <shaohua.li@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: [PATCH]broadcast IPI race condition on CPU hotplug
Message-ID: <20050426132149.GF5098@wotan.suse.de>
References: <1114482044.7068.17.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114482044.7068.17.camel@sli10-desk.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2005 at 10:20:44AM +0800, Li Shaohua wrote:
> Hi,
> After a CPU is booted but before it's officially up (set online map, and
> enable interrupt), the CPU possibly will receive a broadcast IPI. After
> it's up, it will handle the stale interrupt soon and maybe cause oops if
> it's a smp-call-function-interrupt. This is quite possible in CPU
> hotplug case, but nearly can't occur at boot time. Below patch replaces
> broadcast IPI with send_ipi_mask just like the cluster mode.

No way we are making this common operation much slower just
to fix an obscure race at boot time. PLease come up with a fix
that only impacts the boot process.

Thanks,
-Andi

