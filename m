Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932389AbWDGJLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbWDGJLz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 05:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbWDGJLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 05:11:55 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:41351
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S932389AbWDGJLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 05:11:54 -0400
Date: Fri, 7 Apr 2006 02:11:40 -0700
To: Ingo Molnar <mingo@elte.hu>
Cc: Darren Hart <darren@dvhart.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       "Stultz, John" <johnstul@us.ibm.com>,
       Peter Williams <pwil3058@bigpond.net.au>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: RT task scheduling
Message-ID: <20060407091140.GA11706@gnuppy.monkey.org>
References: <200604052025.05679.darren@dvhart.com> <20060406073753.GA18349@elte.hu> <20060407030713.GA9623@gnuppy.monkey.org> <20060407071125.GA2563@elte.hu> <20060407083931.GA11393@gnuppy.monkey.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060407083931.GA11393@gnuppy.monkey.org>
User-Agent: Mutt/1.5.11+cvs20060126
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2006 at 01:39:31AM -0700, Bill Huey wrote:
[Me and Ingo's comments about creation of a new run class and thread
binding...]
> The RT rebalancing discussion should be oriented toward manual techniques
> for dealing with this on an app basis and not automatic load balancing
> stuff or anything like that. IMO, going down this direction is basically
> trying to solve a problem with the wrong tool set.

If some kind of automatic load balance is the focus, then extending the
notion of a CPU package for multicore processors sharing the same cache
controller and memory would be a better track to take. I saw this in the
-mm tree over a year ago an I haven't looked at the scheduler code recently
to see if it made into the mainline. If the RT load balancing is to be
extended, it should take into consideration whether the migration of a
thread should go to a core that's closer or farther away in terms of
memory hierarchy instead of just grabbing the first non-RT task running
CPU and hijacking it to run that RT task.

bill

