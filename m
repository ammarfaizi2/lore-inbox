Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268754AbUHTVYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268754AbUHTVYT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 17:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268756AbUHTVYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 17:24:19 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:7580 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268754AbUHTVYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 17:24:14 -0400
Subject: Re: [RFC] enhanced version of net_random()
From: Lee Revell <rlrevell@joe-job.com>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: Jean-Luc Cooke <jlcooke@certainkey.com>,
       Stephen Hemminger <shemminger@osdl.org>,
       "David S. Miller" <davem@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, "Theodore Ts'o" <tytso@mit.edu>,
       netdev@oss.sgi.com, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040820185956.GV8967@schnapps.adilger.int>
References: <20040812104835.3b179f5a@dell_ss3.pdx.osdl.net>
	 <20040820175952.GI5806@certainkey.com>
	 <20040820185956.GV8967@schnapps.adilger.int>
Content-Type: text/plain
Message-Id: <1093037055.10063.192.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 20 Aug 2004 17:24:15 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-20 at 14:59, Andreas Dilger wrote:
> On Aug 20, 2004  13:59 -0400, Jean-Luc Cooke wrote:
> > Is there a reason why get_random_bytes() is unsuitable?
> > 
> > Keeping the number of PRNGs in the kernel to a minimum should a goal we can
> > all share.
> 
> For some uses a decent PRNG is enough, and the overhead of get_random_bytes()
> is much too high.

Agreed.  I have numbers to support the above.

>   We've needed something like this for a long time (something
> that gives decenly uniform numbers) and hacks to use useconds/cycles/etc do
> not cut it.  I for one welcome a simple in-kernel interface to
> e.g. get_urandom_bytes() (or net_random() as this is maybe inappropriately
> called) that is only pseudo-random but fast and efficient.

One problem is that AIUI, we incur this overhead even if a hardware RNG
is present.  This does not seem right.  Hardware RNGs are increasingly
common, Linux supports hardware RNGs from AMD, Intel, and VIA.

Lee 

