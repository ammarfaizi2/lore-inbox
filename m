Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbULHRaS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbULHRaS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 12:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbULHRaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 12:30:18 -0500
Received: from eth0-0.arisu.projectdream.org ([194.158.4.191]:57029 "EHLO
	b.mx.projectdream.org") by vger.kernel.org with ESMTP
	id S261274AbULHRaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 12:30:11 -0500
Date: Wed, 8 Dec 2004 18:30:28 +0100
From: Thomas Graf <tgraf@suug.ch>
To: jamal <hadi@cyberus.ca>
Cc: Patrick McHardy <kaber@trash.net>, Andrew Morton <akpm@osdl.org>,
       Thomas Cataldo <tomc@compaqnet.fr>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, "David S. Miller" <davem@davemloft.net>
Subject: Re: Hard freeze with 2.6.10-rc3 and QoS, worked fine with 2.6.9
Message-ID: <20041208173028.GN1371@postel.suug.ch>
References: <1102422544.1088.98.camel@jzny.localdomain> <41B5E188.5050800@trash.net> <20041207170748.GF1371@postel.suug.ch> <41B5E722.2080600@trash.net> <1102480044.1050.9.camel@jzny.localdomain> <1102480913.1049.24.camel@jzny.localdomain> <41B68E5D.2080009@trash.net> <1102509111.1051.54.camel@jzny.localdomain> <20041208143212.GL1371@postel.suug.ch> <1102518304.1023.6.camel@jzny.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102518304.1023.6.camel@jzny.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* jamal <1102518304.1023.6.camel@jzny.localdomain> 2004-12-08 10:05
> On Wed, 2004-12-08 at 09:32, Thomas Graf wrote:
> 
> > I've put together a small testsuite allowing to easly run tests for
> > multiple versions of iproute2. It can be found at:
> > 	http://people.suug.ch/~tgr/iproute2/tc-testsuite.tar.gz
> > 
> 
> Good stuff. Hopefully we can run these tests everytime we make changes
> going forward. We cant compromise quality by handwaving on instinct.
> Famous last words: "that couldnt have possibly caused a bug down there".
> I will take a look at what you have and integrate my 20-30 testcases if
> they are not covered over time - or may be adpat what you have to follow
> how i do things or maybe i can send them to you and you can integrate
> them.

I've only put a small cbq test case and the policer test in there for
now. I'd be happy to integrate your test cases if you send them to me.
I wil add more tests in the next days given time.

Our sysadmin had some cycles and set up a UML capable of booting
any kernel image by script so we can easly test all changes to iproute2
or the kernel on as many branches as we want. I've put in the latest
2.4/2.6 main releases, the latest bk snapshots of both and earlier releases
of both to ensure we keep some backward compatibility. All 2.6 branches
have 2 configs, one with action code and the other with the old policer.
I'm not quite sure which versions of iproute2 are being used by the
distributions so I've put the latest bk version and the ones of red hat,
suse and debian into it.

That's 36 kernel<->iproute2 combinations per test, given we add a few
dozen tests makes it hard to tell if something went wrong. I'll
probably need to add some more logic to it besides just checking if
the test script has written anything to stderr.

I'll be happy to put patches into the test cycle once they're posted
to netdev or alternatively add dave's bk tree to the list of branches
whichever is more reasonable.
