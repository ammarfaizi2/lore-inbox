Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263244AbUCNBKV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 20:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263248AbUCNBId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 20:08:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:17083 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263247AbUCNBIW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 20:08:22 -0500
Date: Sat, 13 Mar 2004 17:15:04 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Andrea Arcangeli <andrea@suse.de>,
       Rajesh Venkatasubramanian <vrajesh@umich.edu>, riel@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: anon_vma RFC2
In-Reply-To: <20040314010108.GF655@holomorphy.com>
Message-ID: <Pine.LNX.4.58.0403131714220.900@ppc970.osdl.org>
References: <Pine.LNX.4.44.0403100759550.7125-100000@chimarrao.boston.redhat.com>
 <20040310135012.GM30940@dualathlon.random> <Pine.GSO.4.58.0403121149400.2624@sapphire.engin.umich.edu>
 <20040312172600.GC30940@dualathlon.random> <Pine.GSO.4.58.0403121548530.2624@sapphire.engin.umich.edu>
 <Pine.LNX.4.58.0403131246580.28574@ruby.engin.umich.edu>
 <20040313181606.GO30940@dualathlon.random> <Pine.GSO.4.58.0403131426590.12823@blue.engin.umich.edu>
 <20040314002348.GQ30940@dualathlon.random> <Pine.LNX.4.58.0403131647000.900@ppc970.osdl.org>
 <20040314010108.GF655@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 13 Mar 2004, William Lee Irwin III wrote:
> 
> find_vma() is often necessary to determine whether the page is mlock()'d.
> In schemes where mm's that may not map the page appear in searches, it
> may also be necessary to determine if there's even a vma covering the
> area at all or otherwise a normal vma, since pagetables outside normal
> vmas may very well not be understood by the core (e.g. hugetlb).

Both excellent points. I guess we'll need the extra few cache misses. 
Dang.

		Linus
