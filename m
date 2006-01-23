Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751402AbWAWLYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbWAWLYe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 06:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbWAWLYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 06:24:34 -0500
Received: from cantor.suse.de ([195.135.220.2]:56968 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751402AbWAWLYe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 06:24:34 -0500
From: Andi Kleen <ak@suse.de>
To: pravin shelar <pravins@calsoftinc.com>
Subject: Re: [PATCH] garbage values in file /proc/net/sockstat
Date: Mon, 23 Jan 2006 12:24:15 +0100
User-Agent: KMail/1.8.2
Cc: Ravikiran G Thirumalai <kiran@scalex86.org>,
       Shai Fultheim <shai@scalex86.org>, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>
References: <Pine.LNX.4.63.0601231206270.2192@pravin.s>
In-Reply-To: <Pine.LNX.4.63.0601231206270.2192@pravin.s>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601231224.16196.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 January 2006 12:21, pravin shelar wrote:
> 	In 2.6.16-rc1-mm1, (for x86_64 arch) cpu_possible_map is not same 
> as NR_CPUS (prefill_possible_map()). Therefore per cpu areas are allocated 
> for cpu_possible cpus only (setup_per_cpu_areas()). This causes sockstat 
> to return garbage value on x84_64 arch.
> 
> So these per_cpu accesses are geting relocated (RELOC_HIDE) using
> boot_cpu_pda[]->data_offset which is not initialized.
> 
> There are other instances of same bug where per_cpu() macro is used
> without cpu_possible() check. e.g. net/core/utils.c :: 
> net_random_reseed(), net/core/dev.c :: net_dev_init(), etc.
> 
> This patch fixes these bugs.

Thanks. Patches Look good.  Dave, can you push them for 2.6.16 still please?

-Andi
