Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbWC3DZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbWC3DZL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 22:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbWC3DZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 22:25:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:35510 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751264AbWC3DZK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 22:25:10 -0500
Date: Wed, 29 Mar 2006 19:24:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ashok Raj <ashok.raj@intel.com>
Cc: pavel@ucw.cz, linux-kernel@vger.kernel.org, ashok.raj@intel.com
Subject: Re: [rfc] fix Kconfig, hotplug_cpu is needed for swsusp
Message-Id: <20060329192453.538a131d.akpm@osdl.org>
In-Reply-To: <20060329150950.A12482@unix-os.sc.intel.com>
References: <20060329220808.GA1716@elf.ucw.cz>
	<20060329144746.358a6b4e.akpm@osdl.org>
	<20060329150950.A12482@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ashok Raj <ashok.raj@intel.com> wrote:
>
> On Wed, Mar 29, 2006 at 02:47:46PM -0800, Andrew Morton wrote:
>  > Pavel Machek <pavel@ucw.cz> wrote:
>  > >
>  > > HOTPLUG_CPU is needed on normal PCs, too -- it is neccessary for
>  > > software suspend.
>  > > 
>  > 
>  > OK, this will get ugly.  APICs are involved.
> 
>  I guess you need only on systems that support >1 cpu right? I doubt you will need
>  it on a system that cannot run with the config-generic-arch on. although we use bigsmp 
>  when hotplug is turned on, all we really end up is using flat physical mode instead
>  of using logical mode.
> 
>  I still havent understood why this wont work. Choosing CONFIG_X86_GENERICARCH shouldnt
>  break anything AFAICT.
> 
>  Pavel, you could use CONFIG_HOTPLUG_CPU, just need to enable X86_GENERICARCH now. 
>  Is there a reason you think that wont work? I wish we would revert it for a strong 
>  reason that we know will not make hotplug work on certain systems because of this choise
>  not that we currently have X86_PC now, and are unwiling to change the config.
> 
>  (PS: the word bigsmp although sounds like some large NR_CPUS, its just using a mode that
>  permits the system to work from 1 .. >8 cpus. So there is really nothing determental 
>  to selecting this.)

Something which remains to be beaten into my head: *why* does HOTPLUG_CPU
require flat pyhsical mode?  What necessitated that change, and cannot we
make it work OK in logical mode as well as flat mode?
