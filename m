Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267083AbTCFAUP>; Wed, 5 Mar 2003 19:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267089AbTCFAUP>; Wed, 5 Mar 2003 19:20:15 -0500
Received: from [195.39.17.254] ([195.39.17.254]:9476 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267083AbTCFAUN>;
	Wed, 5 Mar 2003 19:20:13 -0500
Date: Thu, 6 Mar 2003 01:29:46 +0100
From: Pavel Machek <pavel@suse.cz>
To: Dominik Brodowski <linux@brodo.de>
Cc: davej@suse.de, John Clemens <john@deater.net>, cpufreq@www.linux.org.uk,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] Re: cpufreq: allow user to specify voltage
Message-ID: <20030306002945.GA31895@elf.ucw.cz>
References: <20030225190949.GM12028@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.44.0302251419290.12073-100000@pianoman.cluster.toy> <20030225193341.GA19556@atrey.karlin.mff.cuni.cz> <20030228211638.GA888@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030228211638.GA888@brodo.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Here's my suggestion, (partly) based on something Patrick Mochel suggested
> for the passing of attribute files of cpufreq drivers to the cpufreq core:
> a NULL-terminated list of device_attributes *attr is passed to the core. And
> if attr itself is NULL, no attribute is passed, of course. Using this
> approach, this patch against cpufreq-CVS-HEAD adds a file
> 
> /sys/devices/sys/cpu0/scaling_available_freqs (something Carl Thompson
> 						asked for)

Strange, I need 

> @@ -166,8 +166,11 @@
>  	/* optional, for the moment */
>  	int	(*init)		(struct cpufreq_policy *policy);
>  	int	(*exit)		(struct cpufreq_policy *policy);
> +	struct device_attribute *attr[];

to change this to *attr[99] if I want it to compile...
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
