Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264451AbUAJBia (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 20:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264507AbUAJBia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 20:38:30 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:57087 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S264451AbUAJBi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 20:38:29 -0500
Date: Fri, 9 Jan 2004 17:38:24 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 NFS-server low to 0 performance
Message-ID: <20040110013824.GA17845@matchmail.com>
Mail-Followup-To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	linux-kernel@vger.kernel.org
References: <20040109180054.GV1882@matchmail.com> <Pine.LNX.4.44.0401100024210.676-100000@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401100024210.676-100000@poirot.grange>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 10, 2004 at 01:38:00AM +0100, Guennadi Liakhovetski wrote:
> On Fri, 9 Jan 2004, Mike Fedyk wrote:
> > Find out how many packets are being dropped on your two hosts with 2.4 and
> > 2.6.
> 
> So, I've run 2 tcpdumps - on server and on client. Woooo... Looks bad.
> 
> With 2.4 (_on the server_) the client reads about 8K at a time, which is
> sent in 5 fragments 1500 (MTU) bytes each. And that works. Also
> interesting, that fragments are sent in the reverse order.
> 
> With 2.6 (on the server, same client) the client reads about 16K at a
> time, split into 11 fragments, and then packets number 9 and 10 get
> lost... This all with a StrongARM client and a PCMCIA network-card. With a
> PXA-client (400MHz compared to 200MHz SA) and an on-board eth smc91x, it
> gets the first 5 fragments, and then misses every other fragment. Again -
> in both cases I was copying files to RAM. Yes, 2.6 sends fragments in
> direct order.

Is that an x86 server, and an arm client?
