Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263074AbVD2Xvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263074AbVD2Xvw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 19:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263075AbVD2Xvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 19:51:52 -0400
Received: from gate.crashing.org ([63.228.1.57]:10122 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263074AbVD2Xvu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 19:51:50 -0400
Subject: Re: [RFC][PATCH (1/4)] new timeofday core subsystem (v A4)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, albert@users.sourceforge.net,
       Paul Mackerras <paulus@samba.org>, schwidefsky@de.ibm.com,
       mahuja@us.ibm.com, donf@us.ibm.com, mpm@selenic.com
In-Reply-To: <1114814747.28231.2.camel@cog.beaverton.ibm.com>
References: <1114814747.28231.2.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Sat, 30 Apr 2005 09:50:05 +1000
Message-Id: <1114818605.7182.299.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-29 at 15:45 -0700, john stultz wrote:
> All,
>         This patch implements the architecture independent portion of
> the time of day subsystem. For a brief description on the rework, see
> here: http://lwn.net/Articles/120850/ (Many thanks to the LWN team for
> that clear writeup!)
> 
> Mostly this version is just a cleanup of the last release. One neat
> feature is the new sysfs interface which allows you to manually override
> the selected timesource while the system is running. 
> 
> Included below is timeofday.c (which includes all the time of day
> management and accessor functions), ntp.c (which includes the ntp
> scaling calculation code, leapsecond processing, and ntp kernel state
> machine code), timesource.c (for timesource specific management
> functions), interface definition .h files, the example jiffies
> timesource (lowest common denominator time source, mainly for use as
> example code) and minimal hooks into arch independent code.
> 
> The patch does not function without minimal architecture specific hooks
> (i386, x86-64, ppc32, ppc64, ia64 and s390 examples to follow), and it
> should be able to be applied to a tree without affecting the code.

My concern at this point is how to deal with the userland gettimofday
implementation in the ppc64 vDSO ...

Ben.


