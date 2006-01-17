Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932500AbWAQXsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbWAQXsE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 18:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbWAQXsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 18:48:04 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:34468 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932500AbWAQXsC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 18:48:02 -0500
Subject: Re: [PATCH] Time: Delay clocksource selection until later in boot
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: malattia@linux.it, linux-kernel@vger.kernel.org
In-Reply-To: <20060117154307.07f57bbb.akpm@osdl.org>
References: <1137525365.27699.97.camel@cog.beaverton.ibm.com>
	 <20060117154307.07f57bbb.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 17 Jan 2006 15:47:59 -0800
Message-Id: <1137541680.27699.109.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-17 at 15:43 -0800, Andrew Morton wrote:
> john stultz <johnstul@us.ibm.com> wrote:
> >
> > 	Delay installing new clocksources until later in boot. This avoids some
> > of the clocksource churn that can occur at boot, possibly allowing the
> > system to run for a brief time with a bad clocksource.
> > 
> > This patch resolves the boot time stalls seen by Mattia Dongili.
> > 
> 
> Except he now thinks that it doesn't.  Do you think the patch is good anyway?

I actually do still think its a good idea to avoid the bootup
clocksource churn. I've still got a few ideas for further improving the
TSC registration so I'll probably have another patch or two to try later
this week.

thanks
-john




