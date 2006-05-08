Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbWEHGap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbWEHGap (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 02:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbWEHGap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 02:30:45 -0400
Received: from mga06.intel.com ([134.134.136.21]:27254 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S932335AbWEHGao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 02:30:44 -0400
X-IronPort-AV: i="4.05,99,1146466800"; 
   d="scan'208"; a="32963130:sNHT42806190"
Date: Sun, 7 May 2006 23:30:37 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Shaohua Li <shaohua.li@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Zwane Mwaikambo <zwane@linuxpower.ca>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>, Ashok Raj <ashok.raj@intel.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 0/10] bulk cpu removal support
Message-ID: <20060507233037.A20857@unix-os.sc.intel.com>
References: <1147067137.2760.77.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1147067137.2760.77.camel@sli10-desk.sh.intel.com>; from shaohua.li@intel.com on Mon, May 08, 2006 at 01:45:37PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2006 at 01:45:37PM +0800, Shaohua Li wrote:
> CPU hotremove will migrate tasks and redirect interrupts off dead cpu.
> To remove multiple CPUs, we should iteratively do single cpu removal.
> If tasks and interrupts are migrated to a cpu which will be soon
> removed, then we will trash tasks and interrupts again. The following
> patches allow remove several cpus one time. It's fast and avoids
> unnecessary repeated trash tasks and interrupts. This will help NUMA
> style hardware removal and SMP suspend/resume. Comments and suggestions
> are appreciated.
> 

Thanks shaohua, since the initial code has been collecting dust for 
some several months now, and I never got time to finish it.

Think you forgot to cc the ia64 crowd. We tried to do it a little bit more
generic way, but some required arch assist due to some differences.

Andrew: please help stage in -mm since we would need more extensive testing
and help feedback to fix any before becomming prime time.

It would also help to check if other archs have any compile issues etc..

-- 
Cheers,
Ashok Raj
- Open Source Technology Center
