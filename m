Return-Path: <linux-kernel-owner+w=401wt.eu-S1752530AbWLQMcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752530AbWLQMcW (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 07:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752531AbWLQMcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 07:32:22 -0500
Received: from [85.204.20.254] ([85.204.20.254]:55067 "EHLO megainternet.ro"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752530AbWLQMcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 07:32:21 -0500
Subject: Re: 2.6.19 file content corruption on ext3
From: Andrei Popa <andrei.popa@i-neo.ro>
Reply-To: andrei.popa@i-neo.ro
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>
In-Reply-To: <20061217040620.91dac272.akpm@osdl.org>
References: <1166314399.7018.6.camel@localhost>
	 <20061217040620.91dac272.akpm@osdl.org>
Content-Type: text/plain
Organization: I-NEO
Date: Sun, 17 Dec 2006 14:32:09 +0200
Message-Id: <1166358729.7770.0.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ierdnac ~ # uname -a
Linux ierdnac 2.6.20-rc1 #1 SMP PREEMPT Sun Dec 17 01:52:28 EET 2006
i686 Genuine Intel(R) CPU           T2050  @ 1.60GHz GenuineIntel
GNU/Linux


On Sun, 2006-12-17 at 04:06 -0800, Andrew Morton wrote:
> On Sun, 17 Dec 2006 02:13:18 +0200
> Andrei Popa <andrei.popa@i-neo.ro> wrote:
> 
> > Hello,
> > I had filesystem data corruption with rtorrent with 2.6.19.
> > I tried recent git with Peter Zijlstra patch
> > http://lkml.org/lkml/2006/12/16/144 and it seems that the problem is
> > fixed.
> > 
> 
> oh crap, I'd forgotten that test_clear_page_dirty() now fiddles with the
> ptes.
> 
> I'd be really surprised if this was all due to a race though.  Is everyone
> who has observed this problem running SMP and/or premptible kernels?
> 
> Peter, why isn't that proposed patch's cleaning of the pte racy against
> do_wp_page()?

