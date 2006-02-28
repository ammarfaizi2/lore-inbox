Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751899AbWB1Bro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899AbWB1Bro (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 20:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751747AbWB1Bro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 20:47:44 -0500
Received: from smtp.osdl.org ([65.172.181.4]:59034 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750724AbWB1Brn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 20:47:43 -0500
Date: Mon, 27 Feb 2006 17:46:58 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Tejun Heo <htejun@gmail.com>
cc: Mark Lord <lkml@rtr.ca>, Jeff Garzik <jgarzik@pobox.com>,
       David Greaves <david@dgreaves.com>,
       Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       albertcc@tw.ibm.com, axboe@suse.de
Subject: Re: LibPATA code issues / 2.6.15.4
In-Reply-To: <4403A84C.6010804@gmail.com>
Message-ID: <Pine.LNX.4.64.0602271744470.22647@g5.osdl.org>
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F2050B.8020006@dgreaves.com>
 <Pine.LNX.4.64.0602141211350.10793@p34> <200602141300.37118.lkml@rtr.ca>
 <440040B4.8030808@dgreaves.com> <440083B4.3030307@rtr.ca>
 <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca>
 <4400B439.8050202@dgreaves.com> <4401122A.3010908@rtr.ca> <44017B4B.3030900@dgreaves.com>
 <4401B560.40702@rtr.ca> <4403704E.4090109@rtr.ca> <4403A84C.6010804@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 28 Feb 2006, Tejun Heo wrote:

> Hello, Mark.
> 
> Mark Lord wrote:
> > 
> > .. hold off on 2.6.16 because of this or not?
> > 
> 
> It certainly is dangerous. I guess we should turn off FUA for the time being.
> Barrier auto-fallback was once implemented but it didn't seem like a good idea
> as it was too complex and hides low level bug from higher level. The concensus
> seems to be developing blacklist of drives which lie about FUA support
> (currently only one drive). Official kernel doesn't seem to be the correct
> place to grow the blacklist, Maybe we should do it from -mm?

For 2.6.16, the only sane solution for now is to just turn it off.

Somebody want to send me a patch that does that, along with an ack from 
Mark (and whoever else sees this) that it fixes his/their problems?

		Linus
