Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263204AbTCLO4e>; Wed, 12 Mar 2003 09:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263205AbTCLO4e>; Wed, 12 Mar 2003 09:56:34 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:43715
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263204AbTCLO4d>; Wed, 12 Mar 2003 09:56:33 -0500
Subject: Re: bio too big device
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Andre Hedrick <andre@linux-ide.org>,
       scott thomason <scott-kernel@thomasons.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030312090943.GA3298@suse.de>
References: <20030312085145.GJ811@suse.de>
	 <Pine.LNX.4.10.10303120100490.391-100000@master.linux-ide.org>
	 <20030312090943.GA3298@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047485697.22696.23.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 12 Mar 2003 16:14:58 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-12 at 09:09, Jens Axboe wrote:
> On Wed, Mar 12 2003, Andre Hedrick wrote:
> > 
> > So lets dirty list the one drive by Paul G. and be done.
> > Can we do that?
> 
> Who cares, really? There's not much point in doing it, we're talking 248
> vs 256 sectors in reality. I think it's a _bad_ idea, lets just keep it
> at 255 and avoid silly drive bugs there.

255 trashes your performance, 128 will perform far better with most
setups. This is especially true with raid setups. I'd much rather we
got the IDE layer using 256 block writes even if we have to limit it
to more modern drives by some handwaving (8Gb+ say)


Alan

