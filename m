Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263410AbTC2MSE>; Sat, 29 Mar 2003 07:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263411AbTC2MSE>; Sat, 29 Mar 2003 07:18:04 -0500
Received: from ns.suse.de ([213.95.15.193]:21775 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S263410AbTC2MSD>;
	Sat, 29 Mar 2003 07:18:03 -0500
Subject: Re: NIC renaming does not rename /proc/sys/net/ipv4 Was: Re: NICs
	trading places ?
From: Andi Kleen <ak@suse.de>
To: bert hubert <ahu@ds9a.nl>
Cc: netdev@oss.sgi.com, Dave Jones <davej@codemonkey.org.uk>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030329121755.GA17169@outpost.ds9a.nl>
References: <20030328221037.GB25846@suse.de.suse.lists.linux.kernel>
	<p73isu2zsmi.fsf@oldwotan.suse.de>  <20030329121755.GA17169@outpost.ds9a.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 29 Mar 2003 13:29:19 +0100
Message-Id: <1048940960.2176.86.camel@averell>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-29 at 13:17, bert hubert wrote:
> On Sat, Mar 29, 2003 at 05:47:17AM +0100, Andi Kleen wrote:
> > Dave Jones <davej@codemonkey.org.uk> writes:
> > 
> > > I just upgraded a box with 2 NICs in it to 2.5.66, and found
> > > that what was eth0 in 2.4 is now eth1, and vice versa.
> > > Is this phenomenon intentional ? documented ?
> > 
> > Just assign mac addresses to names and run nameif early in boot.
> 
> A slight problem with that is that not all parts of /proc/sys get renamed
> this way:

Just rename at early boot before IP is set up.  That is what i usually
do - set up /etc/mactab and run it very early at boot.

Running it later is usually flakey. e.g. it can also give confusing
effects with old style named ip aliases.

-Andi


