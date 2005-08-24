Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751094AbVHXQCV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbVHXQCV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 12:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbVHXQCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 12:02:20 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:6125 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751094AbVHXQCT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 12:02:19 -0400
Date: Wed, 24 Aug 2005 15:43:31 +0200
From: Pavel Machek <pavel@suse.cz>
To: Shaohua Li <shaohua.li@intel.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [PATCH] Add MCE resume under ia32
Message-ID: <20050824134331.GA2226@elf.ucw.cz>
References: <1124762500.3013.3.camel@linux-hp.sh.intel.com.suse.lists.linux.kernel> <200508240559.16931.ak@suse.de> <1124856986.5310.2.camel@linux-hp.sh.intel.com> <200508240626.13475.ak@suse.de> <1124857915.5310.4.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124857915.5310.4.camel@linux-hp.sh.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > The boot code already initialized MCE for APs, it isn't required to
> > > initialize again. The MCE entries are cpuhotplug friendly, so for
> > > suspend/resume.
> > 
> > Ok so you're saying the only change needed is to remove
> > the on_each_cpu() in the resume method? Fine I can do that.
> Yep, only BP needs it. But I'm not sure if we should do the same (add
> the sysdev class) in ia32, considering only BP needs it.

Adding sysdev class is nicer than #ifdef in the code, I'd say.

								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
