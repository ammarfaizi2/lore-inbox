Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbVFBSmr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVFBSmr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 14:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbVFBSmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 14:42:46 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:6784 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261226AbVFBSky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 14:40:54 -0400
Subject: Re: [PATCH 3/4] new timeofday x86-64 arch specific changes (v. B1)
From: john stultz <johnstul@us.ibm.com>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andrew Morton <akpm@osdl.org>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Nishanth Aravamudan <nacc@us.ibm.com>, Darren Hart <darren@dvhart.com>,
       "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org
In-Reply-To: <060220051827.15835.429F4FA6000DF9D700003DDB220588617200009A9B9CD3040A029D0A05@comcast.net>
References: <060220051827.15835.429F4FA6000DF9D700003DDB220588617200009A9B9CD3040A029D0A05@comcast.net>
Content-Type: text/plain
Date: Thu, 02 Jun 2005 11:40:45 -0700
Message-Id: <1117737645.17804.21.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-06-02 at 18:27 +0000, Parag Warudkar wrote:
> > If you grab Linus' current tree it should apply.
> > 
> > Sorry about the confusion.
> > -john
> 
> I ignored the reject since it was from an #include section - the build
> went fine. I am even able to use it successfully. Couple things -

Good to hear.


> Very happy to report that I no longer get those annoying - "losing
> some ticks ..." "your time source is unreliable or some driver is
> hogging interrupts" messages - Not sure what change in TOD subsystem
> cured it - or was it just the removal of the printk? ;) 

Since we do not interpolate, lost ticks no longer cause time problems
(well, unless you're using the jiffies timesource). 

> Sadly, it somehow feels noticeably slower than vanilla 2.6.12-rc5.
> Especially using X/KDE - It is surely usable but not snappy. I will do
> more research to find out exactly why - but before that is such as
> loss of snappiness possible due to the TOD changes?

Could you send me your dmesg output with and without using my patch? It
could be you're using a different timesource.

thanks
-john

