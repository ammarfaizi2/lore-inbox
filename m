Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270531AbTGNFex (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 01:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270532AbTGNFew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 01:34:52 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:13224 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S270531AbTGNFen (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 01:34:43 -0400
Date: Mon, 14 Jul 2003 07:49:18 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Chris Mason <mason@suse.com>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@digeo.com>, Alexander Viro <viro@math.psu.edu>
Subject: Re: RFC on io-stalls patch
Message-ID: <20030714054918.GD843@suse.de>
References: <Pine.LNX.4.55L.0307081651390.21817@freak.distro.conectiva> <20030710135747.GT825@suse.de> <1057932804.13313.58.camel@tiny.suse.com> <20030712073710.GK843@suse.de> <1058034751.13318.95.camel@tiny.suse.com> <20030713090116.GU843@suse.de> <20030713191921.GI16313@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030713191921.GI16313@dualathlon.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 13 2003, Andrea Arcangeli wrote:
> On Sun, Jul 13, 2003 at 11:01:16AM +0200, Jens Axboe wrote:
> > No I don't have anything specific, it just seems like a bad heuristic to
> > get rid of. I can try and do some testing tomorrow. I do feel strongly
> 
> well, it's not an heuristic, it's a simplification and it will certainly
> won't provide any benefit (besides saving some hundred kbytes of ram per
> harddisk that is a minor benefit).

You are missing my point - I don't care about loosing the extra request
list, I never said anything about that in this thread. I care about
loosing the reserved requests for reads. And we can do that just fine
with just holding back a handful of requests.

> > that we should at least make sure to reserve a few requests for reads
> > exclusively, even if you don't agree with the oversized check. Anything
> > else really contradicts all the io testing we have done the past years
> > that shows how important it is to get a read in ASAP. And doing that in
> 
> Important for latency or throughput? Do you know which is the benchmarks
> that returned better results with the two queues, what's the theory
> behind this?

Forget the two queues, noone has said anything about that. The reserved
reads are important for latency reasons, not throughput.

-- 
Jens Axboe

