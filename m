Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263580AbUJ2Wix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263580AbUJ2Wix (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 18:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263523AbUJ2Wde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 18:33:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34006 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261446AbUJ2W1U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 18:27:20 -0400
Date: Fri, 29 Oct 2004 18:26:12 -0400
From: Dave Jones <davej@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove duplicate includes (fwd)
Message-ID: <20041029222612.GI23841@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
References: <20041029214717.GW6677@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041029214717.GW6677@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 11:47:17PM +0200, Adrian Bunk wrote:

 > --- linux-2.6.9-mm1-full/drivers/cpufreq/cpufreq_ondemand.c.old	2004-10-22 21:37:33.000000000 +0200
 > +++ linux-2.6.9-mm1-full/drivers/cpufreq/cpufreq_ondemand.c	2004-10-22 21:52:35.000000000 +0200
 > @@ -26,7 +26,6 @@
 >  #include <linux/kmod.h>
 >  #include <linux/workqueue.h>
 >  #include <linux/jiffies.h>
 > -#include <linux/config.h>
 >  #include <linux/kernel_stat.h>
 >  #include <linux/percpu.h>

Not only was this duplicated, but its also unnecessary as
there are no CONFIG_ options in that file.
You may want to add that checking to your script too.

I've killed them both in cpufreq-bk

thanks,

		Dave


