Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269725AbUJAHT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269725AbUJAHT7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 03:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269724AbUJAHT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 03:19:59 -0400
Received: from colin2.muc.de ([193.149.48.15]:45322 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S269725AbUJAHTX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 03:19:23 -0400
Date: 1 Oct 2004 09:19:22 +0200
Date: Fri, 1 Oct 2004 09:19:22 +0200
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Suresh Siddha <suresh.b.siddha@intel.com>, linux-kernel@vger.kernel.org,
       tom.l.nguyen@intel.com, James Cleverdon <jamesclv@us.ibm.com>
Subject: Re: [Patch 1/2] Disable SW irqbalance/irqaffinity for E7520/E7320/E7525 - change TARGET_CPUS on x86_64
Message-ID: <20041001071922.GA32950@muc.de>
References: <2HSdY-7dr-3@gated-at.bofh.it> <m3mzzf99vz.fsf@averell.firstfloor.org> <20040930183235.F29549@unix-os.sc.intel.com> <20040930230133.0d4bcc0d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040930230133.0d4bcc0d.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2004 at 11:01:33PM -0700, Andrew Morton wrote:
> Suresh Siddha <suresh.b.siddha@intel.com> wrote:
> >
> > Set TARGET_CPUS on x86_64 to cpu_online_map. This brings the code inline
> >  with x86 mach-default. Fix MSI_TARGET_CPU code which will break with this 
> >  target_cpus change.
> 
> This gets rejects all over the place against the x86_64 clustered APIC mode
> patch.
> 
> Which has priority here?

Definitely the MSI_TARGET_CPUS thingy.

The Clustered APIC patch is far off pie in the sky for some future
unreleased hardware. MSI workaround fixes basic compilation
and the original patch from Suresh fixes shipping Intel chipsets.

-Andi
