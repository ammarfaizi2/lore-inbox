Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289037AbSAFVJb>; Sun, 6 Jan 2002 16:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289035AbSAFVJW>; Sun, 6 Jan 2002 16:09:22 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:29197 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289033AbSAFVJI>; Sun, 6 Jan 2002 16:09:08 -0500
Message-ID: <3C38BCE6.3030302@zytor.com>
Date: Sun, 06 Jan 2002 13:08:54 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Matt Dainty <matt@bodgit-n-scarper.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
        Richard Gooch <rgooch@ras.ucalgary.ca>
Subject: Re: [PATCH] DevFS support for /dev/cpu/X/(cpuid|msr)
In-Reply-To: <20020106181749.A714@butterlicious.bodgit-n-scarper.com> <200201061934.g06JYnZ15633@vindaloo.ras.ucalgary.ca> <20020106204311.C2596@butterlicious.bodgit-n-scarper.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Dainty wrote:

> Okey dokey,
> 
> Please find attached a second, better patch to add devfs support to the i386
> cpuid and msr drivers. Now it doesn't nuke the cpu/X directories on
> unloading and only enumerates CPUs based on smp_num_cpus instead of NR_CPUS.
> 


If you don't understand why this is idiotic, then let me enlighten you: 
there is no sensible reason why /dev/cpu/%d should only be populated 
after having run a CPU-dependent device driver.  /dev/cpu/%d should be 
always populated; heck, that's the only way you can sensibly handle 
hotswapping CPUs.

I WILL NOT accept a patch as long as devfs is as fucked in the head as 
it currently is.  Unfortunately, that seems like it will be a long long 
time.

	-hpa


