Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261871AbVAYIRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbVAYIRc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 03:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbVAYIRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 03:17:32 -0500
Received: from news.suse.de ([195.135.220.2]:42175 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261872AbVAYIRW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 03:17:22 -0500
Date: Tue, 25 Jan 2005 09:17:04 +0100
From: Andi Kleen <ak@suse.de>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       george anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich.Windl@rz.uni-regensburg.de, Christoph Lameter <clameter@sgi.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>, Max <amax@us.ibm.com>,
       mahuja@us.ibm.com, Nishanth Aravamudan <nacc@us.ibm.com>,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v. A2)
Message-ID: <20050125081704.GC27013@wotan.suse.de>
References: <1106607089.30884.10.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106607089.30884.10.camel@cog.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 02:51:29PM -0800, john stultz wrote:
> All,
> 	Here is a new release of my time of day proposal, which include ppc64
> support as well as suspend/resume and cpufreq hooks. For basic summary
> of my ideas, you can follow this link: http://lwn.net/Articles/100665/

[...]
How do vsyscalls (running gettimeofday in user space) fit into your 
architecture? I don't see any provision for this.

Also on x86-64 we plan to keep the cycle time base per CPU, that 
will likely require some more changes to your architecture too.

-Andi
