Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750891AbWCVS1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbWCVS1w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 13:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbWCVS1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 13:27:52 -0500
Received: from fmr18.intel.com ([134.134.136.17]:33715 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750739AbWCVS1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 13:27:51 -0500
Date: Wed, 22 Mar 2006 10:27:17 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Ashok Raj <ashok.raj@intel.com>, akpm@osdl.org,
       Peter Williams <pwil3058@bigpond.net.au>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>
Subject: Re: Linux v2.6.16
Message-ID: <20060322102717.A12901@unix-os.sc.intel.com>
References: <Pine.LNX.4.64.0603192216450.3622@g5.osdl.org> <200603221839.41867.rjw@sisk.pl> <20060322095457.A12334@unix-os.sc.intel.com> <200603221911.06576.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200603221911.06576.rjw@sisk.pl>; from rjw@sisk.pl on Wed, Mar 22, 2006 at 07:11:05PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2006 at 07:11:05PM +0100, Rafael J. Wysocki wrote:
> > It might help to explain why this would break your swsusp with SMP work?
> 
> On SMP systems swsusp (suspend in general, AFAICT) uses the disable_nonboot_cpus()
> function defined in kernel/power/smp.c, which calls cpu_down() that is only
> defined if CONFIG_HOTPLUG_CPU is set.  We can't suspend and resume SMP systems
> reliably without it.
> 
I understand the needs of swsusp, but no one took away CONFIG_HOTPLUG_CPU away... 
just that you need to also enable CONFIG_GENERICARCH to get it to work reliably, and
not see that printk... nothing else..

Iam still confused why you think swsusp wont work...

with that patch, try

CONFIG_X86_PC=n
CONFIG_GENERICARCH=y
CONFIG_HOTPLUG_CPU=y
...

<whatever swssusp needs>=y

and see if thinks work out for you?

-- 
Cheers,
Ashok Raj
- Open Source Technology Center
