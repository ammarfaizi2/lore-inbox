Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261506AbVFCTEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbVFCTEL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 15:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbVFCTEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 15:04:10 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:48609 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261506AbVFCTDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 15:03:44 -0400
Date: Fri, 3 Jun 2005 12:02:19 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: john stultz <johnstul@us.ibm.com>
cc: Andi Kleen <ak@suse.de>, Parag Warudkar <kernel-stuff@comcast.net>,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andrew Morton <akpm@osdl.org>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org
Subject: Re: [PATCH 3/4] new timeofday x86-64 arch specific changes (v. B1)
In-Reply-To: <1117823257.17804.60.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.62.0506031201040.28131@schroedinger.engr.sgi.com>
References: <060220051827.15835.429F4FA6000DF9D700003DDB220588617200009A9B9CD3040A029D0A05@comcast.net>
  <200506021905.08274.kernel-stuff@comcast.net>  <1117754453.17804.51.camel@cog.beaverton.ibm.com>
  <200506021950.35014.kernel-stuff@comcast.net>  <20050603163010.GR23831@wotan.suse.de>
 <1117823257.17804.60.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Jun 2005, john stultz wrote:

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
> can demote the TSC's priority to 50 and it will fall back nicely without
> manual intervention.

Oh, we are going to have flags for timesources? Then please also do the 
jitter thing.

