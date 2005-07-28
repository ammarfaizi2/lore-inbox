Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbVG1CoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbVG1CoU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 22:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbVG1CoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 22:44:20 -0400
Received: from fmr19.intel.com ([134.134.136.18]:24795 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261264AbVG1CoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 22:44:18 -0400
Subject: Re: [linux-pm] Re: [PATCH 1/23] Add missing
	device_suspsend(PMSG_FREEZE) calls.
From: Shaohua Li <shaohua.li@intel.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: ncunningham@cyclades.com, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <m1k6jb7myp.fsf@ebiederm.dsl.xmission.com>
References: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com>
	 <m1iryxeb4t.fsf@ebiederm.dsl.xmission.com>
	 <1122400462.4382.13.camel@localhost>
	 <m1k6jb7myp.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Thu, 28 Jul 2005 10:44:17 +0800
Message-Id: <1122518657.2925.4.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-27 at 19:12 -0600, Eric W. Biederman wrote:
> Nigel Cunningham <ncunningham@cyclades.com> writes:
> 
> > Hi.
> >
> > Could you please send PMSG_* related patches to linux-pm at
> > lists.osdl.org as well?
> 
> I'll try.  My goal was not to add or change not functionality but to
> make what the kernel was already doing be consistent.
> 
> It turns out the device_suspend(PMSG_FREEZE) is a major pain
> sitting in the reboot path and I will be submitting a patch to
> remove it from the reboot path in 2.6.13 completely.
> 
> At the very least the ide driver breaks, and the e1000 driver
> is affected.
> 
> And there is of course the puzzle of why there exists simultaneously
> driver shutdown() and suspend(PMSG_FREEZE) methods as I believed they
> are defined to do exactly the same thing.
I would expect more driver breakage and for the shutdown either. In
current stage, suspend(PMSG_FREEZE) might put devices into D3 state. How
can a shutdown() be done again?

Thanks,
Shaohua

