Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263364AbVCKPRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263364AbVCKPRT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 10:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263350AbVCKPRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 10:17:19 -0500
Received: from nessie.weebeastie.net ([220.233.7.36]:54429 "EHLO
	theirongiant.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S263364AbVCKPRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 10:17:02 -0500
Date: Sat, 12 Mar 2005 02:11:17 +1100
From: CaT <cat@zip.com.au>
To: "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, pekkas@netcore.fi
Subject: Re: ipv6 and ipv4 interaction weirdness
Message-ID: <20050311151116.GF14146@zip.com.au>
References: <20050311121655.GE14146@zip.com.au> <20050311.085815.100748583.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050311.085815.100748583.yoshfuji@linux-ipv6.org>
Organisation: Furball Inc.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2005 at 08:58:15AM -0600, YOSHIFUJI Hideaki / ?$B5HF#1QL@ wrote:
> > If it bound to :: port 22 then 0.0.0.0:22 would fail.
> > 
> > On the other hand if I got it to bind to each address individually then
> > both ipv4 (2 addresses) and ipv6 (1 address) binds would succeed.
> > 
> > Maybe I'm just looking at it wrong but shouldn't ipv4 and ipv6 interfere
> > with each other?
> 
> It is 100% intended, even it is not similar to BSD variants do.
> 
> IPv4 and IPv6 share address/port space.
> :: and 0.0.0.0 is special "any" address, thus they confict.
> ::ffff:a.b.c.d and a.b.c.d also conflict.

Argh! Ofcourse. That makes sense. In the IPv6 ip space, IPv4 was made a
subset so anything that decides to bind 0.0.0.0:22 (for eg) would
prevent another bind to :: much like binding to 10.1.1.1:22 would
prevent a 0.0.0.0:22 bind. Having changed ListenAddress to :: it works
as it should and I get responses in the IPv4 ip space.

Joy. Thanks for the clue. I've so rarely come across the ::ffff: ip
space that I completely forgot about it.

-- 
    "It goes against the grain of modern education to teach children to
    program. What fun is there in making plans, acquiring discipline in
    organising thoughts, devoting attention to detail and learning to be
    self-critical?" -- Alan Perlis
