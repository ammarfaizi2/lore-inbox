Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263344AbTIIMYd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 08:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264073AbTIIMYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 08:24:33 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:51410
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263344AbTIIMYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 08:24:31 -0400
Date: Tue, 9 Sep 2003 14:25:47 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: experiences beyond 4 GB RAM with 2.4.22
Message-ID: <20030909122547.GN21086@dualathlon.random>
References: <20030909110112.4d634896.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030909110112.4d634896.skraw@ithnet.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 09, 2003 at 11:01:12AM +0200, Stephan von Krawczynski wrote:
> Hello,
> 
> lately I upgraded my testbox from 2 to 6 GB ram and found out some oddities I
> would like to hear your opinions.
> The box ran flawlessly and performant with 2 GB - was in fact a real joy.
> After upgrading the ram and recompiling kernel 2.4.22 with support for 64 GB I
> noticed:
> 
> 1) nfs clients see timeouts again, like
> 
> Sep  9 03:37:35 clienta kernel: nfs: server 192.168.1.1 not responding, still
> trying
> Sep  9 03:37:35 clienta kernel: nfs: server 192.168.1.1 OK
> Sep  9 03:37:35 clienta kernel: nfs: server 192.168.1.1 not responding, still
> trying
> Sep  9 03:37:35 clienta kernel: nfs: server 192.168.1.1 OK
> Sep  9 03:41:13 clienta kernel: nfs: server 192.168.1.1 not responding, still
> trying
> Sep  9 03:41:13 clienta kernel: nfs: server 192.168.1.1 OK
> 
> Both are 2.4.22. 192.168.1.1 is the testbox. I saw those with 2GB, but could
> fix it through more nfs-daemons and
> 
>         echo 2097152 >/proc/sys/net/core/rmem_max
>         echo 2097152 >/proc/sys/net/core/wmem_max
> 
> Are these values too small for 6 GB?
> 
> 2) Box is very slow, kswapd looks very active during tar of a local harddisk.
> Interactivity is really bad. Seems vm has a high time looking for free or
> usable pages. Compared to 2 GB the behaviour is unbelievably bad.
> 
> 3) Network performance has a remarkable dropdown during above tar. In fact
> doing simple pings every few minutes shows that quite a lot of them are simply
> dropped, never make it over the ethernet.
> 
> I am really astonished about this. Can some kind soul give me hints or maybe
> patches to try?

for the vm issues my suggestion is to try again with 2.4.22aa1.

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
