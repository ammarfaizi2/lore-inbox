Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317653AbSGJWrK>; Wed, 10 Jul 2002 18:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317659AbSGJWrJ>; Wed, 10 Jul 2002 18:47:09 -0400
Received: from zeke.inet.com ([199.171.211.198]:23938 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S317653AbSGJWrH>;
	Wed, 10 Jul 2002 18:47:07 -0400
Message-ID: <3D2CBA08.6000604@inet.com>
Date: Wed, 10 Jul 2002 17:49:44 -0500
From: Eli Carter <eli.carter@inet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thunder from the hill <thunder@ngforever.de>
CC: Andrew Morton <akpm@zip.com.au>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       Linux <linux-kernel@vger.kernel.org>
Subject: Re: HZ, preferably as small as possible
References: <Pine.LNX.4.44.0207101640340.5067-100000@hawkeye.luckynet.adm>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thunder from the hill wrote:
> Hi,
> 
> On Wed, 10 Jul 2002, Thunder from the hill wrote:
> 
>>Want a config option? Either int or bool (CONFIG_LOW_HZ). It's not too 
>>much effort.
> 
> 
> I guess I forgot the half of it...
> 
> What arches do we want?
> 
> Index: arch/i386/Config.help
> ===================================================================
> RCS file: /var/cvs/thunder-2.5/arch/i386/Config.help,v
> retrieving revision 1.4
> diff -p -u -r1.4 Config.help
> --- arch/i386/Config.help	7 Jul 2002 09:59:46 -0000	1.4
> +++ arch/i386/Config.help	10 Jul 2002 22:40:17 -0000
> @@ -991,3 +991,13 @@ CONFIG_X86_EARLY_PRINTK
>    to the console  much earlier in the boot  process than printk.  This
>    is useful when  debugging fatal problems early in  the boot sequence
>    (e.g. within setup_arch).  If unsure, say N.
> +
> +Low kernel scheduler rate
> +CONFIG_SCHED_LOW_HZ
> +  Enable this  if you care about  your CPU sleeping  time. The current
> +  interval for  scheduling processes in  the kernel has  recently been
> +  increased. The advantage is less latency for many things that depend

Perhaps s/increased/shortened/ ?

> +  on the  timer, the disadvantage is  that your cpu  will probably not
> +  go to sleep in time (so  CPU power management will possibly not work
> +  at all)
> +
> Index: include/asm-i386/param.h
[snip]

Eli
--------------------. "If it ain't broke now,
Eli Carter           \                  it will be soon." -- crypto-gram
eli.carter(a)inet.com `-------------------------------------------------

