Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbTFGAHq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 20:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262400AbTFGAHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 20:07:46 -0400
Received: from almesberger.net ([63.105.73.239]:43786 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S262386AbTFGAHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 20:07:45 -0400
Date: Fri, 6 Jun 2003 21:20:26 -0300
From: Werner Almesberger <wa@almesberger.net>
To: chas williams <chas@cmf.nrl.navy.mil>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations (take 2)
Message-ID: <20030606212026.I3232@almesberger.net>
References: <20030606125416.C3232@almesberger.net> <200306062354.h56NsWsG002919@ginger.cmf.nrl.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306062354.h56NsWsG002919@ginger.cmf.nrl.navy.mil>; from chas@cmf.nrl.navy.mil on Fri, Jun 06, 2003 at 07:52:42PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

chas williams wrote:
> converted to a net device.  this keeps me from needing to
> replicate the net device code (particularly the sysfs
> stuff -- or so i hope).   netdevices already have a handy
> register/unregister that works (and will keep working).
> why would i want to duplicate the net device work?

Sure, particularly sysfs as "the next big thing" is a good reason
to align data structures and general semantics with the rest of
the stack.

The only thing that worries me in all this is Dave's request to
make device destruction asynchronous, because of the complexity
this is likely to add, for, IMHO, little or no gain.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
