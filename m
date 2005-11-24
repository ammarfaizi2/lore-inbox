Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbVKXOzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbVKXOzV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 09:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbVKXOzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 09:55:21 -0500
Received: from ns1.suse.de ([195.135.220.2]:26261 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751257AbVKXOzU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 09:55:20 -0500
Date: Thu, 24 Nov 2005 15:55:18 +0100
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@suse.de>, "Eric W. Biederman" <ebiederm@xmission.com>,
       Gerd Knorr <kraxel@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Dave Jones <davej@redhat.com>, Zachary Amsden <zach@vmware.com>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
Message-ID: <20051124145518.GI20775@brahms.suse.de>
References: <20051123163906.GF20775@brahms.suse.de> <1132766489.7268.71.camel@localhost.localdomain> <20051123165923.GJ20775@brahms.suse.de> <1132783243.13095.17.camel@localhost.localdomain> <20051124131310.GE20775@brahms.suse.de> <m1zmnugom7.fsf@ebiederm.dsl.xmission.com> <20051124133907.GG20775@brahms.suse.de> <1132842847.13095.105.camel@localhost.localdomain> <20051124142200.GH20775@brahms.suse.de> <1132845324.13095.112.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132845324.13095.112.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2005 at 03:15:24PM +0000, Alan Cox wrote:
> On Iau, 2005-11-24 at 15:22 +0100, Andi Kleen wrote:
> > What do you need a special driver for if the northbridge just
> > can do the scrubbing by itself?
> 
> You need a driver to collect and report all the ECC single bit errors to
> the user so that they can decide if they have problem hardware.

Assuming the errors are logged to the standard machine check
architecture that's already done by mce.c. K8 does that definitely.

Take a look at mcelog at some point.
Your distro probably already sets it up by default to log to
/var/log/mcelog

> 
> EDAC is more than one thing
> 	- Control response to a fatal error
> 	- Report non-fatal events for analysis/user decision making

x86-64 mce.c does all that There was even a port to i386 around at some point.

-Andi
