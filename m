Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbVFOPCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVFOPCK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 11:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbVFOPCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 11:02:09 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:30085 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261153AbVFOPBo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 11:01:44 -0400
Date: Wed, 15 Jun 2005 08:01:10 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org, kernel-stuff@comcast.net, frank@tuxrocks.com
Subject: Re: [PATCH 0/4] new timeofday-based soft-timer subsystem
Message-ID: <20050615150110.GC19520@us.ibm.com>
References: <20050614034655.GA4180@us.ibm.com> <42AFE71B.1181.2422D280@rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42AFE71B.1181.2422D280@rkdvmks1.ngate.uni-regensburg.de>
X-Operating-System: Linux 2.6.12-rc5 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.06.2005 [08:30:20 +0200], Ulrich Windl wrote:
> On 14 Jun 2005 at 11:11, Nishanth Aravamudan wrote:
> 
> [...]
> > Would it be beneficial to encapsulate the timer_list structure? That way
> > if the units change underneath and we eventually move to timer_fsecs
> > (for femtoseconds), we don't need to change all the callers of
> > set_timer_nsecs() again?
> [...]
> 
> I don't think that we'll see a global clock with reliable femtosecond
> resolution (not to talk about accuracy) in the foreseeable computer
> generations. Even plain gigahertz RAM is quite some time away. So how
> would you distribute such high resolution time across CPUs? As long as
> a syscall takes significantly longer than 1ns, or has a jitter of more
> than 1ns, a higher resolution clock would be just a source of
> additional noise bits.

Thank you for your feedback, Ulrich. You are probably right that such a
hardware timesource probably is not going to be common any time soon. My
thoughts for encapsulation were just a possibility, and certainly not a
requirement for my patch.

I did not consider the problems of distributing that value, either. So,
I guess, I can leave encapsulation out of the current efforts :)

Thanks,
Nish
