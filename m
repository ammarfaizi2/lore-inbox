Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161000AbVLHGZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161000AbVLHGZj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 01:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030473AbVLHGZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 01:25:39 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:47254 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S1030472AbVLHGZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 01:25:38 -0500
Subject: Re: for_each_online_cpu broken ?
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Dave Jones <DaveJ@redhat.com>
Cc: Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20051208053302.GA28201@redhat.com>
References: <20051208050738.GE24356@redhat.com>
	 <20051208052632.GF11190@wotan.suse.de>  <20051208053302.GA28201@redhat.com>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1134022925.7235.28.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 08 Dec 2005 16:22:05 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2005-12-08 at 15:33, Dave Jones wrote:
> On Thu, Dec 08, 2005 at 06:26:32AM +0100, Andi Kleen wrote:
> 
> Hi Andi,
> 
>  > > Whilst debugging a memory leak, I hit sysrq meminfo,
>  > > and got hot/cold info for CONFIG_NR_CPUS rather than 4 cpus
>  > > 
>  > > I've only tried reproducing this on x86-64 so far.
>  > 
>  > If the online map is wrong all kinds of things would go wrong.
>  > 
>  > Most likely your kernel doesn't have the fix.
> 
> This was seen with a .15rc5-git1 kernel.
> Is this something still living in your x86-64 patchset or -mm ?
>  
>  > The possible map is fixed kind of BTW in 2.6.15rc*. It was a side effect
>  > of CPU hotplug, which now uses a better algorithm to guess the 
>  > number of possible CPUs. In 2.6.15 you will just get half the number
>  > of available CPUs in addition by default
> 
> Yep, I noticed it offers a maximum of 6 cpus on my way.
> As a sidenote, seems kinda funny (and wasteful maybe?), doing this
> on a lot of hardware that isn't hotplug capable. (Whilst I could
> disable cpu hotplug in my local build, this isn't an answer for
> a generic distro kernel).

Both suspend to disk (and suspend to ram?) implementations now depend on
hotplug_cpu to enable extra cpus, so there is at least one reason for
them to want hotplug support in a generic kernel.

Regards,

Nigel

