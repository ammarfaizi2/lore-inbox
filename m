Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030422AbVKWWXB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030422AbVKWWXB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 17:23:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030334AbVKWWXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 17:23:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:51106 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964782AbVKWWWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 17:22:25 -0500
Date: Wed, 23 Nov 2005 23:22:13 +0100
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "H. Peter Anvin" <hpa@zytor.com>, Gerd Knorr <kraxel@suse.de>,
       Dave Jones <davej@redhat.com>, Zachary Amsden <zach@vmware.com>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
Message-ID: <20051123222212.GV20775@brahms.suse.de>
References: <1132764133.7268.51.camel@localhost.localdomain> <20051123163906.GF20775@brahms.suse.de> <1132766489.7268.71.camel@localhost.localdomain> <Pine.LNX.4.64.0511230858180.13959@g5.osdl.org> <4384AECC.1030403@zytor.com> <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org> <1132782245.13095.4.camel@localhost.localdomain> <Pine.LNX.4.64.0511231331040.13959@g5.osdl.org> <20051123214344.GU20775@brahms.suse.de> <Pine.LNX.4.64.0511231413530.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511231413530.13959@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 02:15:24PM -0800, Linus Torvalds wrote:
> 
> 
> On Wed, 23 Nov 2005, Andi Kleen wrote:
> >
> > > THAT is what I'd like to have CPU support for. Not for UP (it's going 
> > > away), and not for the kernel (it's never single-threaded).
> > 
> > There is one reasonly interesting special case that will probably stay
> > around: single CPU guest in a virtualized environment.
> 
> .. and then the _virtualizer_ should just set the bit. 

That wouldn't work if it's limited limited to ring 3.

Also currently at least the Xen the driver interfaces seem to 
rely on lock, but perhaps that can be changed.


> However, quite frankly, virtualization is overhyped, in my opinion. And if 
> it forces people to run UP because of performance issues, it's simply not 
> acceptable for a lot of loads.

I don't think it'll force them to that, it will just be a common
use case. e.g. you start a separate VM to run your firewall in.
Do you really need it multithreaded? 

-Andi

