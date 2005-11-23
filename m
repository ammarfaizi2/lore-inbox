Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbVKWWPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbVKWWPv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 17:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932576AbVKWWPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 17:15:51 -0500
Received: from smtp.osdl.org ([65.172.181.4]:57501 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932274AbVKWWPu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 17:15:50 -0500
Date: Wed, 23 Nov 2005 14:15:24 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "H. Peter Anvin" <hpa@zytor.com>,
       Gerd Knorr <kraxel@suse.de>, Dave Jones <davej@redhat.com>,
       Zachary Amsden <zach@vmware.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
In-Reply-To: <20051123214344.GU20775@brahms.suse.de>
Message-ID: <Pine.LNX.4.64.0511231413530.13959@g5.osdl.org>
References: <438359D7.7090308@suse.de> <p7364qjjhqx.fsf@verdi.suse.de>
 <1132764133.7268.51.camel@localhost.localdomain> <20051123163906.GF20775@brahms.suse.de>
 <1132766489.7268.71.camel@localhost.localdomain> <Pine.LNX.4.64.0511230858180.13959@g5.osdl.org>
 <4384AECC.1030403@zytor.com> <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org>
 <1132782245.13095.4.camel@localhost.localdomain> <Pine.LNX.4.64.0511231331040.13959@g5.osdl.org>
 <20051123214344.GU20775@brahms.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 23 Nov 2005, Andi Kleen wrote:
>
> > THAT is what I'd like to have CPU support for. Not for UP (it's going 
> > away), and not for the kernel (it's never single-threaded).
> 
> There is one reasonly interesting special case that will probably stay
> around: single CPU guest in a virtualized environment.

.. and then the _virtualizer_ should just set the bit. 

However, quite frankly, virtualization is overhyped, in my opinion. And if 
it forces people to run UP because of performance issues, it's simply not 
acceptable for a lot of loads.

It's cool technology and all, but realistically..

		Linus
