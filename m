Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270544AbRHNNDj>; Tue, 14 Aug 2001 09:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270612AbRHNND3>; Tue, 14 Aug 2001 09:03:29 -0400
Received: from co3000407-a.belrs1.nsw.optushome.com.au ([203.164.252.88]:31146
	"EHLO bozar") by vger.kernel.org with ESMTP id <S270544AbRHNNDV>;
	Tue, 14 Aug 2001 09:03:21 -0400
Date: Tue, 14 Aug 2001 23:03:01 +1000
From: Andre Pang <ozone@algorithm.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: usb-uhci + SMP -> bad
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010814002131.A26321@bubba.toscano.org> <E15Wdc6-00016N-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15Wdc6-00016N-00@the-village.bc.nu>
User-Agent: Mutt/1.3.20i
Message-Id: <997794181.326309.1471.nullmailer@bozar.algorithm.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2001 at 01:48:06PM +0100, Alan Cox wrote:

> > 	- use the uhci USB driver when I'm using a USB printer.  If I
> > 	  use the usb-uhci driver with my USB printer, the whole system
> > 	  locks.  This has been reported a few times on LKML,
> > 	  linux-usb-users, and linux-usb-developers and nobody helped,
> > 	  but a few people wrote back with "me too"s.  It was broken in
> > 	  the trasnition from 2.4.3 to 2.4.4 and only seems to affect
> > 	  SMP systems.  I just gave up on USB printing and went back to
> > 	  my parallel port.
> 
> usb-uhci seems to not be SMP safe. Ultimately we don't need both uhci
> drivers so that hasnt been one that worried me.  Probably we should drop
> the other uhci driver over time (2.5 maybe)

i'd just thought i'd verify that usb-uchi seems to be causing
some havoc on SMP boxes.

i've had complete crashes (Alt-SysRq-s doesn't respond) when i
try to print stuff to a USB printer using the usb-uchi and
printer modules.  this is on an SMP box.

however -- 2.4.2 works perfectly for that.  it broke from 2.4.4
onward (tried 2.4.[5-7], i'm presuming .8 hasn't fixed the
problem.)

if anybody wants me to help them diagnose the problem, i'd be
more than happy to, but i'm not sure where to start at the
moment.


-- 
#ozone/algorithm <ozone@algorithm.com.au>          - trust.in.love.to.save
