Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263897AbTJ1J2E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 04:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263898AbTJ1J2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 04:28:04 -0500
Received: from gprs197-51.eurotel.cz ([160.218.197.51]:63618 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263897AbTJ1J2B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 04:28:01 -0500
Date: Tue, 28 Oct 2003 10:27:20 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk,
       Linus Torvalds <torvalds@osdl.org>, akpm@osdl.org,
       Pavel Machek <pavel@ucw.cz>, Dominik Brodowski <linux@brodo.de>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [PATCH] 3/3 A dynamic cpufreq governor
Message-ID: <20031028092720.GB1167@elf.ucw.cz>
References: <88056F38E9E48644A0F562A38C64FB6007796D@scsmsx403.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88056F38E9E48644A0F562A38C64FB6007796D@scsmsx403.sc.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> ondemand3.patch - Adding sysfs interface for cpufreq_ondemand 
> tunables and making sysfs access by cpufreq governors safe against 
> removal of the underlying module (from Dominik). 
> 
> diffstat ondemand3.patch
>  cpufreq.c          |   24 ++++++++++++
>  cpufreq_ondemand.c |  102
> +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 126 insertions(+)

Is something word-wrapping your mails?

...

> +/* cpufreq_ondemand Governor Tunables */
> +#define show_one(file_name, object)
> \
> +static ssize_t show_##file_name
> \
> +(struct cpufreq_policy *unused, char *buf)
> \
> +{
> \
> +	return sprintf(buf, "%u\n", dbs_tuners_ins.object);
> \
> +}
> +show_one(sampling_rate, sampling_rate);
> +show_one(up_threshold, up_threshold);
> +show_one(down_threshold, down_threshold);

?
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
