Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261767AbVFFXRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbVFFXRz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 19:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbVFFXRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 19:17:21 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:48812 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261709AbVFFWvc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 18:51:32 -0400
Subject: Re: [PATCH 3/4] new timeofday x86-64 arch specific changes (v. B1)
From: john stultz <johnstul@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Parag Warudkar <kernel-stuff@comcast.net>,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andrew Morton <akpm@osdl.org>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org
In-Reply-To: <20050605112732.GW23831@wotan.suse.de>
References: <060220051827.15835.429F4FA6000DF9D700003DDB220588617200009A9B9CD3040A029D0A05@comcast.net>
	 <200506021905.08274.kernel-stuff@comcast.net>
	 <1117754453.17804.51.camel@cog.beaverton.ibm.com>
	 <200506021950.35014.kernel-stuff@comcast.net>
	 <20050603163010.GR23831@wotan.suse.de>
	 <1117823257.17804.60.camel@cog.beaverton.ibm.com>
	 <20050605112732.GW23831@wotan.suse.de>
Content-Type: text/plain
Date: Mon, 06 Jun 2005 15:51:18 -0700
Message-Id: <1118098278.25706.23.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-06-05 at 13:27 +0200, Andi Kleen wrote:
> > How about something like this?
> > 
> > 300 TSC 
> > 200 HPET
> > 200 CYCLONE
> > 100 ACPI
> > 050 PIT
> > 010 JIFFIES
> > 
> > Then if the system has TSC issues (unsynced, cpufreq problems, etc), we
> 
> The priority is fine, the problem is getting the decisions for when
> to fallback right.
> 
> It is quite complicated to decide this, see the x86-64 time.c code 
> for this.

Hmmm. I'm not sure I see the level of complication that you allude to.
Let me re-spin my patches again with the tsc timesource auto-demotion
and let me know if I'm missing anything.

thanks
-john


