Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbVFOGcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbVFOGcb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 02:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbVFOGcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 02:32:31 -0400
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:54495 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S261509AbVFOGcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 02:32:13 -0400
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: Nishanth Aravamudan <nacc@us.ibm.com>
Date: Wed, 15 Jun 2005 08:30:20 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 0/4] new timeofday-based soft-timer subsystem
Cc: lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org, kernel-stuff@comcast.net, frank@tuxrocks.com
Message-ID: <42AFE71B.1181.2422D280@rkdvmks1.ngate.uni-regensburg.de>
In-reply-to: <20050614181109.GG4180@us.ibm.com>
References: <20050614034655.GA4180@us.ibm.com>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.26/Sophos-P=3.92.0+V=3.92+U=2.07.092+R=04 April 2005+T=103902@20050615.062327Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Jun 2005 at 11:11, Nishanth Aravamudan wrote:

[...]
> Would it be beneficial to encapsulate the timer_list structure? That way
> if the units change underneath and we eventually move to timer_fsecs
> (for femtoseconds), we don't need to change all the callers of
> set_timer_nsecs() again?
[...]

I don't think that we'll see a global clock with reliable femtosecond resolution 
(not to talk about accuracy) in the foreseeable computer generations. Even plain 
gigahertz RAM is quite some time away. So how would you distribute such high 
resolution time across CPUs? As long as a syscall takes significantly longer than 
1ns, or has a jitter of more than 1ns, a higher resolution clock would be just a 
source of additional noise bits.

Regards,
Ulrich Windl

