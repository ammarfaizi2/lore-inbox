Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932655AbWBYE0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932655AbWBYE0x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 23:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932657AbWBYE0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 23:26:53 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58274 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932655AbWBYE0w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 23:26:52 -0500
Date: Fri, 24 Feb 2006 23:24:56 -0500
From: Dave Jones <davej@redhat.com>
To: Johannes Stezenbach <js@linuxtv.org>, Adrian Bunk <bunk@stusta.de>,
       Dmitry Torokhov <dtor_core@ameritech.net>, davej@codemonkey.org.uk,
       Zwane Mwaikambo <zwane@commfireservices.com>,
       Samuel Masham <samuel.masham@gmail.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, cpufreq@lists.linux.org.uk, ak@suse.de
Subject: Re: Status of X86_P4_CLOCKMOD?
Message-ID: <20060225042456.GA7851@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Johannes Stezenbach <js@linuxtv.org>, Adrian Bunk <bunk@stusta.de>,
	Dmitry Torokhov <dtor_core@ameritech.net>, davej@codemonkey.org.uk,
	Zwane Mwaikambo <zwane@commfireservices.com>,
	Samuel Masham <samuel.masham@gmail.com>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	cpufreq@lists.linux.org.uk, ak@suse.de
References: <20060214152218.GI10701@stusta.de> <20060222024438.GI20204@MAIL.13thfloor.at> <20060222031001.GC4661@stusta.de> <200602212220.05642.dtor_core@ameritech.net> <20060223195937.GA5087@stusta.de> <20060223204110.GE6213@redhat.com> <20060225015722.GC8132@linuxtv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060225015722.GC8132@linuxtv.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2006 at 02:57:22AM +0100, Johannes Stezenbach wrote:
 > On Thu, Feb 23, 2006, Dave Jones wrote:
 > > On Thu, Feb 23, 2006 at 08:59:37PM +0100, Adrian Bunk wrote:
 > >  > And if the option is mostly useless, what is it good for?
 > > 
 > > It's sometimes useful in cases where the target CPU doesn't have any better
 > > option (Speedstep/Powernow).  The big misconception is that it
 > > somehow saves power & increases battery life. Not so.
 > > All it does is 'not do work so often'.  The upside of this is
 > > that in some situations, we generate less heat this way.
 > 
 > Doesn't less heat imply less power consumption?

Not really.  The only energy you're saving is that your CPU fan
will turn slightly slower, which is probably going to be < 1W
of difference.  Generated heat drop in a large room of servers
*may* mean the aircon has less to do, but I'd be surprised if
it made a noticable difference.

 > - after some minutes of idling without user activity
 >   go into lowest power mode (could be triggered
 >   from xscreensaver)
 > - at the slightest hint of user activity or CPU load jump
 >   back to max performance mode
 > (- optionally use intermediate clock mod steps for
 >   non-interactive loads, but I'm not convinced it's
 >   worth it)

You should be able to modify cpuspeed or some other userspace
governor to do this quite easily.

		Dave

