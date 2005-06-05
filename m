Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbVFEL17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbVFEL17 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 07:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbVFEL17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 07:27:59 -0400
Received: from ns1.suse.de ([195.135.220.2]:37315 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261330AbVFEL1p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 07:27:45 -0400
Date: Sun, 5 Jun 2005 13:27:32 +0200
From: Andi Kleen <ak@suse.de>
To: john stultz <johnstul@us.ibm.com>
Cc: Andi Kleen <ak@suse.de>, Parag Warudkar <kernel-stuff@comcast.net>,
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
Subject: Re: [PATCH 3/4] new timeofday x86-64 arch specific changes (v. B1)
Message-ID: <20050605112732.GW23831@wotan.suse.de>
References: <060220051827.15835.429F4FA6000DF9D700003DDB220588617200009A9B9CD3040A029D0A05@comcast.net> <200506021905.08274.kernel-stuff@comcast.net> <1117754453.17804.51.camel@cog.beaverton.ibm.com> <200506021950.35014.kernel-stuff@comcast.net> <20050603163010.GR23831@wotan.suse.de> <1117823257.17804.60.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117823257.17804.60.camel@cog.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How about something like this?
> 
> 300 TSC 
> 200 HPET
> 200 CYCLONE
> 100 ACPI
> 050 PIT
> 010 JIFFIES
> 
> Then if the system has TSC issues (unsynced, cpufreq problems, etc), we

The priority is fine, the problem is getting the decisions for when
to fallback right.

It is quite complicated to decide this, see the x86-64 time.c code 
for this.

> can demote the TSC's priority to 50 and it will fall back nicely without
> manual intervention.

-Andi
