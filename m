Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263388AbTIWWez (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 18:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263434AbTIWWez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 18:34:55 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:56976
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S263388AbTIWWey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 18:34:54 -0400
Date: Wed, 24 Sep 2003 00:34:57 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: log-buf-len dynamic
Message-ID: <20030923223457.GA16314@velociraptor.random>
References: <20030922194833.GA2732@velociraptor.random> <20030923042855.GF589@alpha.home.local> <20030923124951.GB23111@velociraptor.random> <20030923140647.GB3113@alpha.home.local> <20030923144435.GC23111@velociraptor.random> <3F706046.1000306@euronext.nl> <20030923160600.GA4161@alpha.home.local> <20030923162319.GA1269@velociraptor.random> <20030923190219.GA5997@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030923190219.GA5997@alpha.home.local>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 09:02:19PM +0200, Willy Tarreau wrote:
> > My API is good for everyone, yours is not
> 
> I'm impressed that you know so many people. I know that mine at least
> satisfies a few collegues, customers, and I. So I deduced that it might be
> useful to others too. Even Marcelo thought the same a time ago.

I know your patch was just very good for many people, but not for
everyone. I really didn't want to say your patch didn't make any good,
I acknowledge it was just very good.

Here I need an argument from you that explains me why should I work
further on the current code to make the config option still usable. I
see no reason to spend time in that effort because the config option
will provide no benefit compared to the kernel parameter.

If you can explain me _why_ you don't want to pass the kernel parameter
than you will convince me, if it's just that "you don't want it" then I
can't buy that. Give me a valid argument and I will have a reason to
retain the config option.

I definitely agree my patch (btw, I posted the last one that had a few
bugs too) needs fixing to release the 64k of ram, and to allow a smaller
bufsize too (the latter will happen automatically while addressing the
former)

The fact you don't want to touch the lilo.conf doesn't sound to me.
Especially with lilo (not grub) you've to run lilo anyways every time
you replace the kernel, so a simple script adding the parameter in every
lilo.conf sounds very easy to provide (you can add it in all kernels,
the old ones will ignore it).

Andrea - If you prefer relying on open source software, check these links:
	    rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	    http://www.cobite.com/cvsps/
	    svn://svn.kernel.org/linux-2.[46]/trunk
