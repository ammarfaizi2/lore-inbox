Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262543AbTCRUVb>; Tue, 18 Mar 2003 15:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262567AbTCRUVb>; Tue, 18 Mar 2003 15:21:31 -0500
Received: from air-2.osdl.org ([65.172.181.6]:5514 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262543AbTCRUVa>;
	Tue, 18 Mar 2003 15:21:30 -0500
Subject: Re: seqlock/unlock(&xtime_lock) problems cause keyboard, time skew
	problems
From: Stephen Hemminger <shemminger@osdl.org>
To: Jerry Cooperstein <coop@axian.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030318190557.GA14447@p3.attbi.com>
References: <20030318190557.GA14447@p3.attbi.com>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1048019543.6294.3.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 18 Mar 2003 12:32:24 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-18 at 11:05, Jerry Cooperstein wrote:
> Since 2.5.60 my thinkpad keyboard repeat rate has been erratic when
> started up on battery power; plugging into AC after startup only makes
> it worse.  Starting up on AC is fine.  Compiling without apm in any
> form is fine.
> 
> I posted on this a month ago and noone had solutions although I got
> several emails from folks with similarly afflicted machines.
> 
> Since then I've noticed that I also get a bad time skew, with the
> system clock jumping forward.
> 
> I'm pretty sure the problem arose with the introduction of the
> seqlock/unlock interface to protect xtime_lock instead of a regular rw
> lock.  Short of trying to back the whole thing out, does any one have
> similar observations, suggestions, solutions?

Does this notebook vary the clock rate? If so then using TSC for 
time of day clock is probably a problem.  Try booting with notsc.

