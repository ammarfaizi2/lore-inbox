Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261361AbVBNHjd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbVBNHjd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 02:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbVBNHjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 02:39:33 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:49826 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261361AbVBNHja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 02:39:30 -0500
To: Werner Almesberger <wa@almesberger.net>
Cc: Andi Kleen <ak@suse.de>,
       "Catalin(ux aka Dino) BOIE" <util@deuroconsult.ro>,
       Adrian Bunk <bunk@stusta.de>,
       Janos Farkas <jf-ml-k1-1087813225@lk8rp.mail.xeon.eu.org>,
       linux-kernel@vger.kernel.org, Chris Bruner <cryst@golden.net>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Matt Domsch <Matt_Domsch@dell.com>, <fastboot@osdl.org>
Subject: Re: COMMAND_LINE_SIZE increasing in 2.6.11-rc1-bk6
References: <20050119231322.GA2287@lk8rp.mail.xeon.eu.org>
	<20050120162807.GA3174@stusta.de> <20050120164829.GG450@wotan.suse.de>
	<Pine.LNX.4.61.0501210857170.17260@webhosting.rdsbv.ro>
	<20050121071144.GB657@wotan.suse.de>
	<20050207035707.C25338@almesberger.net>
	<m1hdkhzxxj.fsf@ebiederm.dsl.xmission.com>
	<20050212115106.A1257@almesberger.net>
	<m1brapzu1s.fsf@ebiederm.dsl.xmission.com>
	<20050214024916.B1257@almesberger.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 14 Feb 2005 00:36:01 -0700
In-Reply-To: <20050214024916.B1257@almesberger.net>
Message-ID: <m1oeeny4ny.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger <wa@almesberger.net> writes:

> Eric W. Biederman wrote:
> > Something like that.    I have yet to see a even a proof of concept
> > of the idea of passing device information, to clean up probes.
> 
> Yes, the kexec-based boot loader first, then this. For a
> kexec-based boot loader, passing device scan results will be
> very useful, plus it's a good environment for experimenting
> with such a feature.

And from another perspective what drives things are practical
requirements.  Boot speed while nice does not yet seem to be a
driver, and that is all I have seen proposed with passing
the list of hardware.  What is currently a driver in
the kexec scenario is booting a kernel without firmware
calls, and in the kexec-on-panic case booting a kernel
without a kernel where the hardware is in a known messed
up state.

So far I have seen nothing that even resembles an architecture
independent solution to avoiding firmware calls.  And right
now I'm not even certain I even expect to see something it become
architecture independent.  At the very least we need some
clean architecture specific support first, so we can have
a clue what needs to be generalized.  ia64 and ppc are coming...

At any rate I see the problem of which hardware devices
are present as a subset of the problem of booting without firmware.
So I suspect we are going to get some pretty weird architecture
specific implementations at least in the first go round.

Eric
