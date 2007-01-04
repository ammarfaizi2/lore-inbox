Return-Path: <linux-kernel-owner+w=401wt.eu-S1750754AbXADB2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbXADB2H (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 20:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbXADB2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 20:28:07 -0500
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:32856
	"EHLO gnuppy.monkey.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024AbXADB2G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 20:28:06 -0500
Date: Wed, 3 Jan 2007 17:27:09 -0800
To: "Chen, Tim C" <tim.c.chen@intel.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH] lock stat for -rt 2.6.20-rc2-rt2.2.lock_stat.patch
Message-ID: <20070104012709.GC31943@gnuppy.monkey.org>
References: <20070104010049.GA31943@gnuppy.monkey.org> <9D2C22909C6E774EBFB8B5583AE5291C01A4FBE5@fmsmsx414.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9D2C22909C6E774EBFB8B5583AE5291C01A4FBE5@fmsmsx414.amr.corp.intel.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03, 2007 at 05:11:04PM -0800, Chen, Tim C wrote:
> Bill Huey (hui) wrote:
> > 
> > Thanks, the numbers look a bit weird in that the first column should
> > have a bigger number of events than that second column since it is a
> > special case subset. Looking at the lock_stat_note() code should show
> > that to be the case. Did you make a change to the output ?
> 
> No, I did not change the output.  I did reset to the contention content
> 
> by doing echo "0" > /proc/lock_stat/contention.
> 
> I noticed that the first column get reset but not the second column. So
> the reset code probably need to be checked.

This should have the fix. 

	http://mmlinux.sf.net/public/patch-2.6.20-rc2-rt2.3.lock_stat.patch

If you can rerun it and post the results, it'll hopefully show the behavior 
of that lock acquisition better.

Thanks

bill

