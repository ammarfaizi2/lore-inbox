Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261864AbVCKXyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbVCKXyi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 18:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261811AbVCKXu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 18:50:29 -0500
Received: from gate.crashing.org ([63.228.1.57]:57571 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261808AbVCKXsy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 18:48:54 -0500
Subject: Re: Average power consumption in S3?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Moritz Muehlenhoff <jmm@inutil.org>,
       Martin Josefsson <gandalf@wlug.westbo.se>,
       Volker Braun <volker.braun@physik.hu-berlin.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050311174433.GA6735@thunk.org>
References: <20050309142612.GA6049@informatik.uni-bremen.de>
	 <1110388970.1076.48.camel@tux.rsn.bth.se>
	 <20050310180826.GA6795@informatik.uni-bremen.de>
	 <20050311034615.GA314@thunk.org> <1110516679.32557.350.camel@gaston>
	 <20050311174433.GA6735@thunk.org>
Content-Type: text/plain
Date: Sat, 12 Mar 2005 10:48:21 +1100
Message-Id: <1110584902.5809.116.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> What I would suggest doing is changing the code to use a blacklist
> instead of a whitelist, and make it optional with a CONFIG option that
> is marked experimental, and then get it into the mainline for
> additional testing.  If we can get ATI to give us the right way to do
> it, great, but if they aren't being responsive, maybe we should just
> do it empirically.

I'm hesitant to switch a whitelist because of a couple of settings in
there that are specific to the way the chip is wired on the mobo.
Apparently, thinkpads are similar enough to Macs, but I wouldn't bet on
this beeing "commmon"...

Also, the code in there switches to D2, not D3 and is only for M6,M7 and
M9 for now. I may be able to produce code for the M10 as well based on
some dumps we did from the MacOS driver, paulus wrote something that we
ended up not using because the chip is actually powered down on Macs
with the M10.

Then, there is the problem of machines where the chip is powered down
during sleep... I can re-POST an rv280 (M9+) and an M10 but only in
"graphics" mode, not the VGA side for which I know nothing about, with
the same possible issue about video RAM mode register setting.

Ben.


