Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261403AbVBLN64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbVBLN64 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 08:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbVBLN6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 08:58:55 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:15518 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261403AbVBLN6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 08:58:05 -0500
To: Werner Almesberger <wa@almesberger.net>
Cc: Andi Kleen <ak@suse.de>,
       "Catalin(ux aka Dino) BOIE" <util@deuroconsult.ro>,
       Adrian Bunk <bunk@stusta.de>,
       Janos Farkas <jf-ml-k1-1087813225@lk8rp.mail.xeon.eu.org>,
       linux-kernel@vger.kernel.org, Chris Bruner <cryst@golden.net>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Matt Domsch <Matt_Domsch@dell.com>
Subject: Re: COMMAND_LINE_SIZE increasing in 2.6.11-rc1-bk6
References: <20050119231322.GA2287@lk8rp.mail.xeon.eu.org>
	<20050120162807.GA3174@stusta.de> <20050120164829.GG450@wotan.suse.de>
	<Pine.LNX.4.61.0501210857170.17260@webhosting.rdsbv.ro>
	<20050121071144.GB657@wotan.suse.de>
	<20050207035707.C25338@almesberger.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 12 Feb 2005 06:54:00 -0700
In-Reply-To: <20050207035707.C25338@almesberger.net>
Message-ID: <m1hdkhzxxj.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger <wa@almesberger.net> writes:

> Andi Kleen wrote:
> > It's dependent on the architecture already. I would like to enable
> > it on i386/x86-64 because the kernel command line is often used
> > to pass parameters to installers, and having a small limit there
> > can be awkward.
> 
> Something to keep in mind when extending the command line is that
> we'll probably need a mechanism for passing additional (and
> possibly large) data blocks from the boot loader soon.
> 
> The reason for this is that, if booting through kexec, it would be
> attractive to pass device scan results, so that the second kernel
> doesn't have to repeat the work. As an obvious extension, anyone
> who wants to boot *quickly* could also pass such data from
> persistent storage without actually performing the device scan at
> all when the machine is booted.
> 
> The command line may be suitable for this, but to allow for passing
> a lot of data, its place in memory should perhaps just be reserved,
> at least until the system has passed initialization, without trying
> to copy it to a "safe" place early in kernel startup.

Actually this is trivial to do by using a file in initramfs.
If we need something in a well defined format anyway.

Eric
