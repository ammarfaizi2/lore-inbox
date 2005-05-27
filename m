Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261782AbVE0O5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbVE0O5W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 10:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbVE0O5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 10:57:22 -0400
Received: from brick.kernel.dk ([62.242.22.158]:44689 "EHLO
	nelson.home.kernel.dk") by vger.kernel.org with ESMTP
	id S261782AbVE0O5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 10:57:17 -0400
Date: Fri, 27 May 2005 16:58:21 +0200
From: Jens Axboe <axboe@suse.de>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [PATCH] SATA NCQ support
Message-ID: <20050527145821.GX1435@suse.de>
References: <20050527070353.GL1435@suse.de> <20050527131842.GC19161@merlin.emma.line.org> <20050527135258.GW1435@suse.de> <429732CE.5010708@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429732CE.5010708@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27 2005, Matthias Andree wrote:
> Jens Axboe wrote:
> 
> > NCQ requires hardware support from both the controller and hard drive,
> > you can view Jeff's libata status page for which controllers support
> > NCQ.
> 
> So that means controllers that do not support either NCQ or HBQ just

Forget host based queueing, it's worthless. The device needs knowledge
of the pending commands to eliminate rotational delay, which is
basically the real win of command queueing.

> suck and should not be cared about, and if I were to go into SATA, I
> should just get a new controller and forget about my onboard VIA crap.
> (I read newer VIA are supposed to support AHCI which is good.)

SATA is still pretty fast without NCQ, it just makes some operations a
lot faster. But of course if you want the best, you would opt for some
setup that allows NCQ. To my knowledge, ahci compliance doesn't
guarantee NCQ support (the adapter flags it in its host capability
flags), so I don't know if the newer VIA will get you NCQ support.

People have lived happily without NCQ support in SATA for years, I'm
sure you could too :-)

-- 
Jens Axboe

