Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263574AbUFKADQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263574AbUFKADQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 20:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263585AbUFKADQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 20:03:16 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:42737 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S263574AbUFKADO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 20:03:14 -0400
Message-ID: <40C8F68F.4030601@mvista.com>
Date: Thu, 10 Jun 2004 17:02:23 -0700
From: George Anzinger <george@mvista.com>
Reply-To: ganzinger@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: arjanv@redhat.com
CC: Geoff Levand <geoffrey.levand@am.sony.com>,
       high-res-timers-discourse@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] high-res-timers patches for 2.6.6
References: <40C7BE29.9010600@am.sony.com> <1086861862.2733.6.camel@laptop.fenrus.com>
In-Reply-To: <1086861862.2733.6.camel@laptop.fenrus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Thu, 2004-06-10 at 03:49, Geoff Levand wrote:
> 
>>Available at 
>>http://tree.celinuxforum.org/pubwiki/moin.cgi/CELinux_5fPatchArchive
>>
>>For those interested, the set of three patches provide POSIX high-res 
>>timer support for linux-2.6.6.  The core and i386 patches are updates of 
>>George Anzinger's hrtimers-2.6.5-1.0.patch available on SourceForge 
>><http://sourceforge.net/projects/high-res-timers/>.  The ppc32 port is 
>>not available on SourceForge yet.
> 
> 
> My first impression is that it has WAAAAAAAAAAAY too many ifdefs. I
> would strongly suggest to not make this a config option and just
> mandatory, it's a core feature that has no point in being optional. If
> you accept that, the code also becomes a *LOT* cleaner.
> 
Yes, but...  The main problem is that this would break all the archs that don't 
have the needed arch dependent code yet.  By making the high-res part depend on 
the arch config turning on a config, we don't break the archs and they can sign 
up as they get their act together.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

