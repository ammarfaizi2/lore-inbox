Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262663AbUCESDS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 13:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262664AbUCESDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 13:03:18 -0500
Received: from disk.smurf.noris.de ([192.109.102.53]:4010 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S262663AbUCESDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 13:03:15 -0500
From: "Matthias Urlichs" <smurf@smurf.noris.de>
Date: Fri, 5 Mar 2004 18:52:40 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       =?iso-8859-1?Q?Martin-=C9ric?= Racine <q-funk@pp.fishpool.fi>
Subject: Re: [PATCH] For test only: pmac_zilog fixes (cups lockup at boot):
Message-ID: <20040305175239.GC16646@kiste>
References: <1078473270.5703.57.camel@gaston> <20040305085838.B22156@flint.arm.linux.org.uk> <1078477504.5700.69.camel@gaston> <20040305092422.C22156@flint.arm.linux.org.uk> <1078478951.5698.82.camel@gaston> <20040305094807.E22156@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040305094807.E22156@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Russell King:
> Like I said, I can't see the twigs for the forest due to the shear
> noise caused by the up -> uap change.
> 
That's quite easy to filter out.

$ sed -e s/uap/up/g < uart.patch | patch -p1 -g1
$ bk -r diffs -ub | less
$ bk -r unedit # ;-)

Anyway, as for the lock, remember that there are two serial ports on one
interrupt, so you can't use a tty-specific lock for them.

-- 
Matthias Urlichs
