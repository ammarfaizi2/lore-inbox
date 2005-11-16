Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030505AbVKPVYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030505AbVKPVYO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 16:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030508AbVKPVYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 16:24:14 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:59118 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1030505AbVKPVYO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 16:24:14 -0500
Date: Wed, 16 Nov 2005 14:24:47 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: avolkov@varma-el.com, "Mark A. Greer" <mgreer@mvista.com>,
       LM Sensors <lm-sensors@lm-sensors.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] Added support of ST m41t85 rtc chip
Message-ID: <20051116212447.GE30014@mag.az.mvista.com>
References: <437B4619.6050805@varma-el.com> <6dEExmJ9.1132154398.1580970.khali@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dEExmJ9.1132154398.1580970.khali@localhost>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2005 at 04:19:58PM +0100, Jean Delvare wrote:

<snip>

> This is why you want to move the decision at the run time level rather
> than the compilation time level whenever possible. The clock output
> option can't be a configuration option. I previously suggested a sysfs
> file, because this gives the greatest flexibility. If you don't like
> the idea for whatever reason, you may go for a module parameter instead.
> 
> Same reasonment holds for the m41t00 vs. m41t85 choice. You can't decide
> at compilation time. If we go for a common driver, it has to support
> both devices at the same time. Mark suggested to use platform-specific
> data. I'm not familiar with this, but it sounds reasonable.

I don't know the entire history behind platform_data but my
understanding is that it was designed to provide a mechanism for
platform-specific code to pass info to drivers.

I *believe* that this would be a proper use of platform_data but I'm
hoping someone out in lkml-land who knows better than I will confirm that.

> I don't know for sure at this point whether having a single driver is
> the right choice, I'll let you and Mark check it out and decide. But
> the right way to determine this is definitely not through the use of
> #if/#endif preprocessing stuff.

I agree.  We can and absolutely should do this at run-time if a merged
driver is feasible.  I'll dig thru the datasheets today and start
prototyping some code if it looks like we can merge the code.

Mark
