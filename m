Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbVAHNVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbVAHNVf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 08:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbVAHNVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 08:21:35 -0500
Received: from gprs215-164.eurotel.cz ([160.218.215.164]:61056 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261160AbVAHNVa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 08:21:30 -0500
Date: Sat, 8 Jan 2005 14:21:17 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       John Stultz <johnstul@us.ibm.com>, David Shaohua <shaohua.li@intel.com>
Subject: Re: Patch 1/3: Reduce number of get_cmos_time_calls.
Message-ID: <20050108132117.GB7363@elf.ucw.cz>
References: <1105176732.5478.20.camel@desktop.cunninghams> <1105177073.5478.33.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105177073.5478.33.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Reduce the number of calls to get_cmos_time. Since get_cmos_time waits
> for the start of a new second, two consecutive calls add one full second
> to the time to suspend/resume.

Ack. (You probably want to send it to akpm...?). I did not realize
that get_cmos_time() is so costly.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
