Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbTIGTaa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 15:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbTIGTaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 15:30:30 -0400
Received: from natsmtp00.webmailer.de ([192.67.198.74]:21175 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S261396AbTIGTaZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 15:30:25 -0400
Date: Sun, 7 Sep 2003 20:57:55 +0200
From: Dominik Brodowski <linux@brodo.de>
To: john stultz <johnstul@us.ibm.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: Question: monolitic_clock, timer_{tsc,hpet} and CPUFREQ
Message-ID: <20030907185755.GA19923@brodo.de>
References: <200309042214.28179.dtor_core@ameritech.net> <1062749594.5809.7.camel@laptop.cornchips.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062749594.5809.7.camel@laptop.cornchips.homelinux.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 05, 2003 at 01:13:14AM -0700, john stultz wrote:
> On Thu, 2003-09-04 at 20:14, Dmitry Torokhov wrote:
> > I noticed that although timer_tsc registers cpufreq notifier to detect
> > frequency changes and adjust cpu_khz it does not set cyc2ns_scale. Is
> > monotonic clocks supposed to be also accurate?
> 
> You are correct, without adjusting the cyc2ns_scale value
> monotonic_clock() will not be accurate on freq changing hardware.  

Seems to be a necessary update. Thanks for noting this.


> Looks fine to me. Although I don't have any cpufreq enabled hardware, so
> I'm unable to test this (main cause I never added it myself). 

/me has cpufreq enabled hardware -- but how can I accurately debug
monotonic_ticks()?

	Dominik
