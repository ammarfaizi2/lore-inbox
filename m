Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270360AbTGMTVZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 15:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270361AbTGMTVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 15:21:25 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:18095
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S270360AbTGMTVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 15:21:20 -0400
Date: Sun, 13 Jul 2003 21:35:48 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: Chris Mason <mason@suse.com>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@digeo.com>, Alexander Viro <viro@math.psu.edu>
Subject: Re: RFC on io-stalls patch
Message-ID: <20030713193548.GL16313@dualathlon.random>
References: <Pine.LNX.4.55L.0307081651390.21817@freak.distro.conectiva> <20030710135747.GT825@suse.de> <1057932804.13313.58.camel@tiny.suse.com> <20030712073710.GK843@suse.de> <1058034751.13318.95.camel@tiny.suse.com> <20030713090116.GU843@suse.de> <1058113238.13313.127.camel@tiny.suse.com> <20030713174709.GA843@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030713174709.GA843@suse.de>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 13, 2003 at 07:47:09PM +0200, Jens Axboe wrote:
> Just catering to the sync reads is probably good enough, and I think
> that passing in that extra bit of information is done the best through
> just a b_state bit.

not sure if we should pass this bit of info, I guess if we add it we can
just threats all reads equally and give them the spare reserved
requests unconditionally, so the highlevel isn't complicated (of course
it would be optional, so nothing would break but it would be annoying
for benchmarking new fs having to patch stuff first to see the effect of
the spare reserved requests).

> I'll try and bench a bit tomorrow with that patched in.

Cool thanks.

Andrea
