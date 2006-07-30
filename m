Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932400AbWG3SH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbWG3SH1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 14:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbWG3SH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 14:07:27 -0400
Received: from mga08.intel.com ([134.134.136.24]:42170 "EHLO
	orsmga102-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932400AbWG3SH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 14:07:26 -0400
X-IronPort-AV: i="4.07,196,1151910000"; 
   d="scan'208"; a="98691972:sNHT16386685"
Message-ID: <44CCF556.2060505@linux.intel.com>
Date: Sun, 30 Jul 2006 22:07:18 +0400
From: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: bert hubert <bert.hubert@netherlabs.nl>, linux-kernel@vger.kernel.org,
       zwane@arm.linux.org.uk, davej@redhat.com, venkatesh.pallipadi@intel.com,
       tony@atomide.com, akpm@osdl.org, cpufreq@lists.linux.org.uk
Subject: Re: 2.6.17 -> 2.6.18 regression: cpufreq broken since 2.6.18-rc1
 on	pentium4
References: <20060730120844.GA18293@outpost.ds9a.nl>	<20060730160738.GB13377@irc.pl> <20060730165137.GA26511@outpost.ds9a.nl>
In-Reply-To: <20060730165137.GA26511@outpost.ds9a.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do I understand your logs right and acpi-cpufreq is already loaded and works on your processor?
Do you have any info in /sys/devices/system/cpu/cpu0/cpufreq ?
Why do you want to load p4-clockmod over it? It does not save you any power, just limits performance.

Regards,
	Alex.

bert hubert wrote:
>>   I have similar problem with cpufreq-nforce2 -- http://lkml.org/lkml/2006/7/7/234
>>   I haven't do a git-bisect yet.
> 
> To recap, cpufreq died for at least two people (Tomasz Torcz and me) between
> 2.6.17 and 2.6.18-rc1. I've cc'd everybody who touched cpufreq according to
> the shortlog.
> 
> Abundant details are in:
> 
> http://lkml.org/lkml/2006/7/30/87
> 
> New information is that I've narrowed it down from between 2.6.16.9 and
> 2.6.18-rc1 to between 2.6.17.7 (which works) and 2.6.18-rc1 (which doesn't).
> 
> The problem exists both with cpufreq as modules and staticly, and both with
> P4 and nforce2.
> 
> Please let me know how I can help you solve this problem. I'll try a git
> bisect but a lot of the cpufreq changes appear to be interrelated, so I'm
> unsure if it will work.
> 
> Thanks!
> 
