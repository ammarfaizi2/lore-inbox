Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964822AbWHQLnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbWHQLnM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 07:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964821AbWHQLnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 07:43:12 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:9160 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964822AbWHQLnL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 07:43:11 -0400
Date: Thu, 17 Aug 2006 13:43:00 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       linux-kernel@vger.kernel.org, Udo van den Heuvel <udovdh@xs4all.nl>
Subject: Re: Linux time code
In-Reply-To: <1155758034.5513.69.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0608171334030.6761@scrub.home>
References: <44E32B23.16949.BBB1EC4@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
 <1155758034.5513.69.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 16 Aug 2006, john stultz wrote:

> > For example there is a POSIX-like sys_clock_gettime() intended to 
> > server the end-user directly, but there's no counterpart do_clock_gettime() to 
> > server any in-kernel needs. 
> 
> Hmmm.. ktime_get(), ktime_get_ts() and ktime_get_real(), provide this
> info. Is there something missing here?

What is missing is the abiltity to map a clock to a posix clock, so that 
you would have CLOCK_REALTIME/CLOCK_MONOTONIC as NTP controlled clocks and 
other CLOCK_* as the raw clock.
At some point I tried to discuss such possibilities, but it probably 
wasn't relevant for the rt kernel, so it was utterly ignored. :(

bye, Roman
