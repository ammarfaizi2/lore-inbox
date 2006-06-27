Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932520AbWF0SyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520AbWF0SyH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 14:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbWF0SyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 14:54:07 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:12638 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932520AbWF0SyF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 14:54:05 -0400
Date: Tue, 27 Jun 2006 20:55:33 +0200
From: Jens Axboe <axboe@suse.de>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-git broke suspend!
Message-ID: <20060627185532.GD32115@suse.de>
References: <20060627181045.GA32115@suse.de> <20060627182014.GB7914@redhat.com> <20060627182646.GB32115@suse.de> <20060627183935.GC7914@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060627183935.GC7914@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27 2006, Dave Jones wrote:
> On Tue, Jun 27, 2006 at 08:26:46PM +0200, Jens Axboe wrote:
>  > On Tue, Jun 27 2006, Dave Jones wrote:
>  > > On Tue, Jun 27, 2006 at 08:10:45PM +0200, Jens Axboe wrote:
>  > > 
>  > >  > Incidentally, /sys/devices/system/cpu/cpu0/ is also empty on this
>  > >  > kernel. Some new magic option that needs to be enabled? Not suspending
>  > >  > sucks, cpufreq not working sucks as well (I'm stuck on 800MHz).
>  > > 
>  > > dmesg ? Is this powernow-k8 hardware ?
>  > 
>  > Nopes, it's an IBM T43 so centrino.
>  > 
>  > > If so, can you try backing out 6cad647da228486f36a9794137ad459e39b02590
>  > > and e7bdd7a531320eb4a4a8160afbe0c7cc98ac7187 ?
>  > 
>  > I guess that's not relevant then?
> 
> *nod*.
> 
> I don't see any cpufreq stuff in your dmesg at all. 
> Is it definitly on in the config ?

Strangely, now /sys/devices/system/cpu/cpu0 also seems to be empty on
this kernel. Wonder what is going on here...

CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_TABLE=y
# CONFIG_CPU_FREQ_DEBUG is not set
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_STAT_DETAILS is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=m
CONFIG_CPU_FREQ_GOV_USERSPACE=m
CONFIG_CPU_FREQ_GOV_ONDEMAND=m
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m

-- 
Jens Axboe

