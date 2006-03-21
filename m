Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423177AbWCUSlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423177AbWCUSlD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 13:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423225AbWCUSlB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 13:41:01 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:40668 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1423177AbWCUSlA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 13:41:00 -0500
Date: Tue, 21 Mar 2006 19:40:38 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/14] RTC: Remove RTC UIP synchronization on x86
Message-ID: <20060321184038.GA3929@elf.ucw.cz>
References: <2.132654658@selenic.com> <20060319181335.GA2389@ucw.cz> <20060321163852.GM31656@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060321163852.GM31656@waste.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Út 21-03-06 10:38:52, Matt Mackall wrote:
> On Sun, Mar 19, 2006 at 06:13:36PM +0000, Pavel Machek wrote:
> > Hi!
> > > So this patch series simply removes the synchronization in favor of a
> > > simple seqlock-like approach using the seconds value.
> > 
> > What about polling RTC from timer interrupt or something like that, so
> > that you get error in range of 5 msec instead of 500 msec? You can do
> > the calibration in parallel, then...
> 
> I considered that and decided it wasn't worth the effort. People who
> care (which ought to be the empty set) can run /sbin/hwclock.

Fair enough, hwclock works for me.
								Pavel

-- 
Picture of sleeping (Linux) penguin wanted...
