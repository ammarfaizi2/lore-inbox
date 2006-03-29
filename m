Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751220AbWC2XK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbWC2XK3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 18:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbWC2XK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 18:10:29 -0500
Received: from mga07.intel.com ([143.182.124.22]:57240 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751220AbWC2XK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 18:10:29 -0500
TrustExchangeSourcedMail: True
X-ExchangeTrusted: True
X-IronPort-AV: i="4.03,145,1141632000"; 
   d="scan'208"; a="16540038:sNHT2146938073"
Date: Wed, 29 Mar 2006 15:09:51 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       Ashok Raj <ashok.raj@intel.com>
Subject: Re: [rfc] fix Kconfig, hotplug_cpu is needed for swsusp
Message-ID: <20060329150950.A12482@unix-os.sc.intel.com>
References: <20060329220808.GA1716@elf.ucw.cz> <20060329144746.358a6b4e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060329144746.358a6b4e.akpm@osdl.org>; from akpm@osdl.org on Wed, Mar 29, 2006 at 02:47:46PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2006 at 02:47:46PM -0800, Andrew Morton wrote:
> Pavel Machek <pavel@ucw.cz> wrote:
> >
> > HOTPLUG_CPU is needed on normal PCs, too -- it is neccessary for
> > software suspend.
> > 
> 
> OK, this will get ugly.  APICs are involved.

I guess you need only on systems that support >1 cpu right? I doubt you will need
it on a system that cannot run with the config-generic-arch on. although we use bigsmp 
when hotplug is turned on, all we really end up is using flat physical mode instead
of using logical mode.

I still havent understood why this wont work. Choosing CONFIG_X86_GENERICARCH shouldnt
break anything AFAICT.

Pavel, you could use CONFIG_HOTPLUG_CPU, just need to enable X86_GENERICARCH now. 
Is there a reason you think that wont work? I wish we would revert it for a strong 
reason that we know will not make hotplug work on certain systems because of this choise
not that we currently have X86_PC now, and are unwiling to change the config.

(PS: the word bigsmp although sounds like some large NR_CPUS, its just using a mode that
permits the system to work from 1 .. >8 cpus. So there is really nothing determental 
to selecting this.)


-- 
Cheers,
Ashok Raj
- Open Source Technology Center
