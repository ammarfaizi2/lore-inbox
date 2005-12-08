Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161003AbVLHGaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161003AbVLHGaW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 01:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161004AbVLHGaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 01:30:22 -0500
Received: from mx1.suse.de ([195.135.220.2]:62638 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161003AbVLHGaV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 01:30:21 -0500
Date: Thu, 8 Dec 2005 07:30:09 +0100
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>, Nigel Cunningham <ncunningham@cyclades.com>,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: for_each_online_cpu broken ?
Message-ID: <20051208063009.GK11190@wotan.suse.de>
References: <20051208050738.GE24356@redhat.com> <20051208052632.GF11190@wotan.suse.de> <20051208053302.GA28201@redhat.com> <1134022925.7235.28.camel@localhost> <20051208062844.GF28201@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051208062844.GF28201@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2005 at 01:28:44AM -0500, Dave Jones wrote:
> On Thu, Dec 08, 2005 at 04:22:05PM +1000, Nigel Cunningham wrote:
> 
>  > > Yep, I noticed it offers a maximum of 6 cpus on my way.
>  > > As a sidenote, seems kinda funny (and wasteful maybe?), doing this
>  > > on a lot of hardware that isn't hotplug capable. (Whilst I could
>  > > disable cpu hotplug in my local build, this isn't an answer for
>  > > a generic distro kernel).
>  > 
>  > Both suspend to disk (and suspend to ram?) implementations now depend on
>  > hotplug_cpu to enable extra cpus, so there is at least one reason for
>  > them to want hotplug support in a generic kernel.
> 
> You mean suspend -> plug in a new cpu -> resume transitions ?
> That sounds *terrifying*.

No, they unplug all non BP CPUs before suspending. 
It obviously doesn't require additional CPUs though.


-Andi
