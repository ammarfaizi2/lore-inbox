Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265548AbTFMV5E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 17:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265550AbTFMV5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 17:57:03 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:14036 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S265548AbTFMV4z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 17:56:55 -0400
Subject: Re: uptime wrong in 2.5.70
From: john stultz <johnstul@us.ibm.com>
To: george anzinger <george@mvista.com>
Cc: Clemens Schwaighofer <cs@tequila.co.jp>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3EEA3541.4000909@mvista.com>
References: <3EE9903E.2040101@tequila.co.jp>  <3EEA3541.4000909@mvista.com>
Content-Type: text/plain
Organization: 
Message-Id: <1055541924.18644.176.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 13 Jun 2003 15:05:24 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-06-13 at 13:34, george anzinger wrote:
> Clemens Schwaighofer wrote:
> > I a got a test vmware running with a 2.5.70 and I have sligh "overflow"
> > with my uptime.
> > 
> > gentoo root # uptime
> >  22:29:47 up 14667 days, 19:08,  3 users,  load average: 0.00, 0.00, 0.00
> 
> Uptime currently reports a conversion of jiffies which is currently 
> jacked up to a few seconds short of 32 bits worth of jiffies (for 
> testing purposes).

Any access to jiffies should be subtracting INITIAL_JIFFIES, so uptime
should still work correctly. I've been unable to reproduce this problem,
so if anyone else sees it I'd love to get more info. 

> I have a patch pending with Andrew to convert uptime to use the POSIX 
> monotonic clock which a) will start at 0 at boot time and b) will 
> account for NTP clock adjustments.  Should give an uptime real close 
> to the best of watches (or even better) :)

Sounds interesting.

-john

