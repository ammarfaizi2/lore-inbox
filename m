Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbUCEJZn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 04:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbUCEJZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 04:25:43 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:44295 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262284AbUCEJY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 04:24:26 -0500
Date: Fri, 5 Mar 2004 09:24:22 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Matthias Urlichs <smurf@smurf.noris.de>,
       =?iso-8859-1?Q?Martin-=C9ric_Racine?= <q-funk@pp.fishpool.fi>
Subject: Re: [PATCH] For test only: pmac_zilog fixes (cups lockup at boot):
Message-ID: <20040305092422.C22156@flint.arm.linux.org.uk>
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Matthias Urlichs <smurf@smurf.noris.de>,
	=?iso-8859-1?Q?Martin-=C9ric_Racine?= <q-funk@pp.fishpool.fi>
References: <1078473270.5703.57.camel@gaston> <20040305085838.B22156@flint.arm.linux.org.uk> <1078477504.5700.69.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1078477504.5700.69.camel@gaston>; from benh@kernel.crashing.org on Fri, Mar 05, 2004 at 08:05:05PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2004 at 08:05:05PM +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2004-03-05 at 19:58, Russell King wrote:
> > On Fri, Mar 05, 2004 at 06:54:31PM +1100, Benjamin Herrenschmidt wrote:
> > > Ok, so I finally got a hand on the problems. A mix of bugs in
> > > the driver, bugs in the HW, and bugs in the TTY layer ! pfiew.
> > 
> > I'm not even going to bother reviewing these changes - the gratuitous
> > change of "up" to "uap" makes this task virtually impossible.
> 
> Oh... and the change wasn't gratuitous... "up" do actually conflict
> with up() as soon as you try to use a semaphore :)

Yes, I know - but the point is its impossible to review, and I think
you at least have an extra level of locking which isn't needed.

But I wouldn't know because of the huge number of changes which make
it impossible to read.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
