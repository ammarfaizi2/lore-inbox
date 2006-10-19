Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946469AbWJSUbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946469AbWJSUbO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 16:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946465AbWJSUbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 16:31:14 -0400
Received: from cicero1.cybercity.dk ([212.242.40.4]:24054 "EHLO
	cicero1.cybercity.dk") by vger.kernel.org with ESMTP
	id S1946467AbWJSUbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 16:31:13 -0400
Message-ID: <4537E07D.5080402@molgaard.org>
Date: Thu, 19 Oct 2006 22:30:53 +0200
From: =?ISO-8859-1?Q?Sune_M=F8lgaard?= <sune@molgaard.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060717 Debian/1.7.13-0.2ubuntu1
X-Accept-Language: en
MIME-Version: 1.0
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
CC: Jiri Slaby <jirislaby@gmail.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org
Subject: Re: speedstep-centrino: ENODEV
References: <EB12A50964762B4D8111D55B764A8454C1A534@scsmsx413.amr.corp.intel.com>
In-Reply-To: <EB12A50964762B4D8111D55B764A8454C1A534@scsmsx413.amr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pallipadi, Venkatesh wrote:
>  
> 
> OK. Things seem to be fine with the BIOS. 

That sounds promising :-)

> You said it was working with 2.6.15. Do you remember whether kernel was using acpi-cpufreq or speedstep-centrino?

Sorry, I don't know, but I can build it and check.

> One change that has happened in this region is that If your BIOS supports both speedstep-centrino and acpi-cpufreq, with 2.6.15 any one of those drivers would have worked. But now with 2.6.18, acpi-cpufreq will not work in the above case and you have to use speedstep_centrino. This was done because, speedstep-centrino has more features than acpi-cpufreq and also doing this helped to elimiate issues with lot of systems with kernel trying to do multiple ACPI PDC writes when BIOS doesn't expect it to. 
> 
> In short:
> (1) If you were using acpi-cpufreq in 2.6.15, there is a high chance that it wont work with 2.6.18 and you should be able to use speedstep-centrino in its place. Make sure you have properly configured speedstep-centrino (You should select X86_SPEEDSTEP_CENTRINO_ACPI along with X86_SPEEDSTEP_CENTRINO).
> 
> (2) If you were using speedstep-centrino in 2.6.15 and now it doesn't work with 2.6.18, then we have a new regression here and we need to root cause it further by enabling cpufreq.debug and getting more debug messages to see where it is failing....
> 

Seems like 1 then. Will check the speedstep-centrino settings in the 
kernel. Thanks. I'll report back, but probably not until tomorrow.

BR,

Sune
