Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964844AbWBYB6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbWBYB6S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 20:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbWBYB6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 20:58:18 -0500
Received: from allen.werkleitz.de ([80.190.251.108]:4492 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S964844AbWBYB6R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 20:58:17 -0500
Date: Sat, 25 Feb 2006 02:57:22 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Dave Jones <davej@redhat.com>, Adrian Bunk <bunk@stusta.de>,
       Dmitry Torokhov <dtor_core@ameritech.net>, davej@codemonkey.org.uk,
       Zwane Mwaikambo <zwane@commfireservices.com>,
       Samuel Masham <samuel.masham@gmail.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, cpufreq@lists.linux.org.uk, ak@suse.de
Message-ID: <20060225015722.GC8132@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Dave Jones <davej@redhat.com>, Adrian Bunk <bunk@stusta.de>,
	Dmitry Torokhov <dtor_core@ameritech.net>, davej@codemonkey.org.uk,
	Zwane Mwaikambo <zwane@commfireservices.com>,
	Samuel Masham <samuel.masham@gmail.com>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	cpufreq@lists.linux.org.uk, ak@suse.de
References: <20060214152218.GI10701@stusta.de> <20060222024438.GI20204@MAIL.13thfloor.at> <20060222031001.GC4661@stusta.de> <200602212220.05642.dtor_core@ameritech.net> <20060223195937.GA5087@stusta.de> <20060223204110.GE6213@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060223204110.GE6213@redhat.com>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: 84.189.240.195
Subject: Re: Status of X86_P4_CLOCKMOD?
X-SA-Exim-Version: 4.2 (built Thu, 16 Feb 2006 12:49:04 +1100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2006, Dave Jones wrote:
> On Thu, Feb 23, 2006 at 08:59:37PM +0100, Adrian Bunk wrote:
>  > And if the option is mostly useless, what is it good for?
> 
> It's sometimes useful in cases where the target CPU doesn't have any better
> option (Speedstep/Powernow).  The big misconception is that it
> somehow saves power & increases battery life. Not so.
> All it does is 'not do work so often'.  The upside of this is
> that in some situations, we generate less heat this way.

Doesn't less heat imply less power consumption?

Anyway, I have P4 in my desktop machine, and the reason
why I tried to use P4 clock modulation was to reduce fan noise,
and save some energy. And yes, fan noise was reduced.

The reason why I turned it off again was that I couldn't
find any governor or userspace daemon that would work
in a sensible way with the high latency of the P4
clock modulation.
What I think could work:

- after some minutes of idling without user activity
  go into lowest power mode (could be triggered
  from xscreensaver)
- at the slightest hint of user activity or CPU load jump
  back to max performance mode
(- optionally use intermediate clock mod steps for
  non-interactive loads, but I'm not convinced it's
  worth it)

P4 clockmod certainly sucks compared to Speedstep,
but IMHO it is still potentially useful for the average
desktop PC user (at least those many who let their PCs
run 24/7, but 90% idle and unused).


Johannes
