Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932572AbVINTLk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932572AbVINTLk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 15:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932578AbVINTLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 15:11:40 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:54247 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932572AbVINTLj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 15:11:39 -0400
Date: Wed, 14 Sep 2005 21:11:16 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, yoshfuji@linux-ipv6.org,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       George Anzinger <george@mvista.com>, joe-lkml@rameria.de
Subject: Re: [RFC][PATCH] NTP shift_right cleanup (v. A1)
In-Reply-To: <1126722303.3455.61.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.61.0509142100410.3728@scrub.home>
References: <1126720091.3455.56.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.61.0509142010030.3728@scrub.home> <1126722303.3455.61.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 14 Sep 2005, john stultz wrote:

> > I checked and this actually generates worse code.
> 
> Well, if I drop the abs() and use:
> 	if ((time_phase >= FINENSEC) || (time_phase <= -FINENSEC))
> 
> It looks pretty close in my test. Is that cool with you?

I think it doesn't hurt to keep it for now, there are other ways to get 
rid of it (e.g. reducing tick_nsec so time_adj is always positive).

bye, Roman
