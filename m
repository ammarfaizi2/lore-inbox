Return-Path: <linux-kernel-owner+w=401wt.eu-S932221AbXAFX0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbXAFX0g (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 18:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbXAFX0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 18:26:36 -0500
Received: from mail.macqel.be ([194.78.208.39]:18415 "EHLO mail.macqel.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932221AbXAFX0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 18:26:35 -0500
Date: Sun, 7 Jan 2007 00:26:33 +0100
From: Philippe De Muyter <phdm@macqel.be>
To: David Brownell <david-b@pacbell.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: RTC subsystem and fractions of seconds
Message-ID: <20070106232633.GA8535@ingate.macqel.be>
References: <200701051949.00662.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701051949.00662.david-b@pacbell.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2007 at 07:49:00PM -0800, David Brownell wrote:
> >  	Those rtc's actually have a 1/100th of second
> > register.  Should the generic rtc interface not support that?
> 
> Are you implying a new userspace API, or just an in-kernel update?

My only concern at the moment is initializing linux's timeofday from the rtc
quickly and with a good precision.  The way it is done currently
in drivers/rtc/hctosys.c is 0.5 sec off.  We could obtain a much better
precision by looping there until the next change (next second for old clocks,
next 0.01 second for m41t81, maybe even better for other ones).

> 
> Either way, that raises the question of what other features should
> be included.  What sub-second precision?  Multiple alarms?  Ways
> to manage output clocks?  Sub-HZ periodic alarms?

I cannot answer that, but others may have other needs.

Philippe
-- 
