Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264432AbTFHDcS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 23:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264454AbTFHDcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 23:32:18 -0400
Received: from almesberger.net ([63.105.73.239]:26381 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S264432AbTFHDcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 23:32:17 -0400
Date: Sun, 8 Jun 2003 00:45:40 -0300
From: Werner Almesberger <wa@almesberger.net>
To: "David S. Miller" <davem@redhat.com>
Cc: chas@cmf.nrl.navy.mil, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations (take 2)
Message-ID: <20030608004540.P3232@almesberger.net>
References: <20030606125416.C3232@almesberger.net> <200306062354.h56NsWsG002919@ginger.cmf.nrl.navy.mil> <20030606212026.I3232@almesberger.net> <20030606.235811.39162108.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030606.235811.39162108.davem@redhat.com>; from davem@redhat.com on Fri, Jun 06, 2003 at 11:58:11PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> For example, crap like this was always busted:
> 
> 	rmmod eth0 </proc/sys/net/ipv4/conf/eth0/whatever
> 
> and now the asynchornous model forces us to fix this.

Well, that's just the good old broken module API problem again.
Under the premise that modules can't be fixed, but the world
around them can, try_module_get is an adequate band-aid for
this API bug, but I wouldn't apply Kant's formula of universal
law quite so literally here :-)

> Werner, don't turn this into another one of those absolutely
> rediculious discussions about module semantic threads you
> guys all pile-drove into Rusty several months ago.  That stuff
> stunk like pure shit and really unfairly drove Rusty up a wall.

Bah, what happened to appreciating the fine art of
single-handedly waging a flame war ? ;-))

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
