Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262679AbTIENhv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 09:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262683AbTIENhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 09:37:51 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:24010
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262679AbTIENht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 09:37:49 -0400
Date: Fri, 5 Sep 2003 15:37:54 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, marcelo@conectiva.com.br,
       mason@suse.com, green@namesys.com, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, tejun@aratech.co.kr, chris@memtest86.com
Subject: Re: 2.4.22-pre lockups (case closed)
Message-ID: <20030905133754.GW1611@dualathlon.random>
References: <20030814084518.GA5454@namesys.com> <Pine.LNX.4.44.0308141425460.3360-100000@localhost.localdomain> <20030814194226.2346dc14.skraw@ithnet.com> <1060913337.1493.29.camel@tiny.suse.com> <20030815122827.067bd429.skraw@ithnet.com> <1060952100.5046.2.camel@tiny.suse.com> <20030905112400.087e3fb6.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030905112400.087e3fb6.skraw@ithnet.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 05, 2003 at 11:24:00AM +0200, Stephan von Krawczynski wrote:
> Hello all,
> 
> I would like to give you the last update on the story:
> 
> short: hardware problem
> 
> long:
> The box had two different types of RAM (both registered ECC) in it. Two were 1
> GByte, four were 256 MByte to a total of 3 GByte. I had to find out that the
> box runs flawlessly when using only the GByte modules _or_ only the 256 MByte
> modules, but not the mix. All modules are from same vendor. The problem in
> mixed setup does not show up in UP mode (memtest works!). It does not even show
> up straight away, it takes days, but it is always there.
> In fact - even though having sunk weeks of work - I am pretty happy that it
> turned out not to be a kernel problem.

thanks for demonstrating this.

> For the other setups that showed SMP-specific weirdness TeJun may have found
> interesting explanations. I updated them all to 2.4.22 and have not seen any
> problem yet.
> For me it was really interesting to see that reiserfs setups obviously have a
> completely different memory footprint than ext3, and altogether there seems a
> remarkable difference between later kernels and former. The problem showed up
> very seldom on 2.4.21 and below but within 2 days with 2.4.22.

normally that indicates the kernel is somehow using the resources more
efficiently, it's usually a good sign from a kernel standpoint, I heard
of things like this happening also during major upgrades like from 2.2
to 2.4.

> Thanks to all who lend me their ears on the topic and sorry for wasting the
> time.

you're very welcome.

> PS: Obviously there are seldom cases where SMP support in memtest _could_ make
> a difference ;-)

;)

Andrea

/*
 * If you refuse to depend on closed software for a critical
 * part of your business, these links may be useful:
 *
 * rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.5/
 * rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.4/
 * http://www.cobite.com/cvsps/
 *
 * svn://svn.kernel.org/linux-2.6/trunk
 * svn://svn.kernel.org/linux-2.4/trunk
 */
