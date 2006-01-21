Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030180AbWAUBtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030180AbWAUBtQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 20:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbWAUBtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 20:49:16 -0500
Received: from fmr22.intel.com ([143.183.121.14]:60058 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S932374AbWAUBtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 20:49:15 -0500
Date: Fri, 20 Jan 2006 17:49:04 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>, ak@suse.de,
       shai@scalex86.org
Subject: Re: [bug] __meminit breaks cpu hotplug
Message-ID: <20060120174904.A7259@unix-os.sc.intel.com>
References: <20060121012709.GC3573@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060121012709.GC3573@localhost.localdomain>; from kiran@scalex86.org on Fri, Jan 20, 2006 at 05:27:09PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2006 at 05:27:09PM -0800, Ravikiran G Thirumalai wrote:
> 
> 
>    I hit the bug on pageset_cpuup_callback, which is obviously __cpuinit,
>    but
>    has been marked __meminit.  Yeah .. bad patch duh!
> 
>    For  some  reason  I thought all other functions marked with __meminit
>    looked
>    like  __cpuinit candidates....while just pageset_cpuup_callback should
>    be
>    changed to __cpuinit
> 

Sorry i missed this while posting the other patch. There are other functions 
called by process_zones() from withing pageset_cpuup_callback() that
are also marked __meminit. I sent a patch just now to cover that.

but as i mentioned i still have trouble getting cpuup to work right.
cpu_down() seems to work ok so far.

-- 
Cheers,
Ashok Raj
- Open Source Technology Center
