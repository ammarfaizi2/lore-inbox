Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932275AbWCVRzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbWCVRzg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 12:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbWCVRzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 12:55:36 -0500
Received: from fmr20.intel.com ([134.134.136.19]:36299 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S932275AbWCVRzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 12:55:35 -0500
Date: Wed, 22 Mar 2006 09:54:58 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Ashok Raj <ashok.raj@intel.com>, akpm@osdl.org,
       Peter Williams <pwil3058@bigpond.net.au>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>
Subject: Re: Linux v2.6.16
Message-ID: <20060322095457.A12334@unix-os.sc.intel.com>
References: <Pine.LNX.4.64.0603192216450.3622@g5.osdl.org> <20060321223120.A4003@unix-os.sc.intel.com> <20060322050837.A9452@unix-os.sc.intel.com> <200603221839.41867.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200603221839.41867.rjw@sisk.pl>; from rjw@sisk.pl on Wed, Mar 22, 2006 at 06:39:41PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2006 at 06:39:41PM +0100, Rafael J. Wysocki wrote:
> > 
> > Please consider for inclusion... resending with changelog per Andrew.
> 
> Please don't apply this patch.
> 
> CPU hotplug is used by swsusp for disabling the nonboot CPUs.  Software
> suspend won't work on SMP without CPU hotplugging.
> 

Hi Rafael,

what part of this is not suitable for swsusp? All we do is just use flat physical mode
for IPI processing. The only difference is moving from logical flat mode to using
flat physical mode.

Have you tested swsusp with CONFIG_GENERICARCH and CONFIG_HOTPLUG_CPU=y ?

It might help to explain why this would break your swsusp with SMP work?

-- 
Cheers,
Ashok Raj
- Open Source Technology Center
