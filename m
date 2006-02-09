Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbWBIVGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbWBIVGr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 16:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWBIVGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 16:06:47 -0500
Received: from fmr22.intel.com ([143.183.121.14]:33953 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750792AbWBIVGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 16:06:46 -0500
Date: Thu, 9 Feb 2006 13:03:57 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ashok Raj <ashok.raj@intel.com>, ntl@pobox.com, dada1@cosmosbay.com,
       riel@redhat.com, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       mingo@elte.hu, ak@muc.de, 76306.1226@compuserve.com, wli@holomorphy.com,
       heiko.carstens@de.ibm.com, pj@sgi.com
Subject: Re: [PATCH] percpu data: only iterate over possible CPUs
Message-ID: <20060209130356.A11732@unix-os.sc.intel.com>
References: <20060209160808.GL18730@localhost.localdomain> <20060209090321.A9380@unix-os.sc.intel.com> <20060209100429.03f0b1c3.akpm@osdl.org> <20060209105230.A10147@unix-os.sc.intel.com> <20060209123729.5fcd3808.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060209123729.5fcd3808.akpm@osdl.org>; from akpm@osdl.org on Thu, Feb 09, 2006 at 12:37:29PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2006 at 12:37:29PM -0800, Andrew Morton wrote:
> 
> There is no proposal to change cpu_present_map.
> 
> The problem is cpu_possible_map.  That is presently being initialised to
> CPU_MASK_ALL, which adversely affects perfoermance.  An NR_CPUS=16 kernel
> on a 2-way presently has cpu_possible_map=0xffff, which will hurt.

Think i miss typed earlier. What you proposed is the correct solution.

I will followup with similar change on ia64 as well, (currently we do this
in smp_build_cpu_map()). And add something similar to what we did for 
x86_64.
