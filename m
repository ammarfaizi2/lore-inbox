Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbTLCVF3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 16:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbTLCVF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 16:05:29 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:42406
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261881AbTLCVFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 16:05:20 -0500
Date: Wed, 3 Dec 2003 22:05:22 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ian Soboroff <ian.soboroff@nist.gov>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23 includes Andrea's VM?
Message-ID: <20031203210522.GF24651@dualathlon.random>
References: <9cfptf6vts7.fsf@rogue.ncsl.nist.gov> <20031203183719.GD24651@dualathlon.random> <9cfu14hbqvz.fsf@rogue.ncsl.nist.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cfu14hbqvz.fsf@rogue.ncsl.nist.gov>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 03, 2003 at 03:14:24PM -0500, Ian Soboroff wrote:
> Andrea Arcangeli <andrea@suse.de> writes:
> 
> > It's probably going to work an order of magnitude better thanks
> > especially to the lower_zone_reserve algorithm.
> >
> > However I'd still recommend to use my tree, the last two critical bits
> > you need from my tree are inode-highmem and related_bhs. Those two are
> > still missing, and you probably need them with 12G.
> >
> > I'm going to release a 2.4.23aa1 btw, that will be the last 2.4-aa.
> 
> I found 10_inode-highmem-2 in the 2.4.23pre6aa3 directory, but I
> couldn't find any related_bhs one.  Am I looking in the wrong place?

the latter is not a self contained patch unfortunately (it could be in
theory but it isn't in practice), and there's no way I can invest effort
in 2.4 to extract it now (infact I need to check that 2.6 addresses that
instead). But you can find it in the 05_vm_26-rest-1 patch.  Ideally if
you apply all the 05_vm_* and the inode-highmem (solving possible
rejects, or applying only the patch with dependencies), you should be
fine then.

> I'd wait for -aa1, but I want to try the updated aic7xxx driver in 2.4.23
> sooner rather than later.

Just to try the driver you can go with plain 2.4.23 right now, the inode
and bh troubles showup in a few days normally, not in a few minutes,
however it depends on your workload. For example with 12G you probably
want to avoid updatedb until you apply all the vm fixes.
