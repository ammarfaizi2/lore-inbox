Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264782AbUGZBjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264782AbUGZBjF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 21:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264808AbUGZBjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 21:39:05 -0400
Received: from dsl-203-113-212-228.QLD.netspace.net.au ([203.113.212.228]:50950
	"EHLO mx.jeeves.gotdns.org") by vger.kernel.org with ESMTP
	id S264782AbUGZBi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 21:38:59 -0400
From: Ben Hoskings <ben@jeeves.gotdns.org>
To: linux-kernel@vger.kernel.org
Subject: Re: New dev model (was [PATCH] delete devfs)
Date: Mon, 26 Jul 2004 11:38:55 +1000
User-Agent: KMail/1.6.2
Cc: Adrian Bunk <bunk@fs.tum.de>, corbet@lwn.net
References: <40FEEEBC.7080104@quark.didntduck.org> <20040722193337.GE19329@fs.tum.de> <20040722160112.177fc07f.akpm@osdl.org>
In-Reply-To: <20040722160112.177fc07f.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407261138.55020.ben@jeeves.gotdns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jul 2004 09:01, Andrew Morton wrote:
> Well.  We'll see.  2.6 is becoming stabler, despite the fact that we're
> adding features.
>
> I wouldn't be averse to releasing a 2.6.20.1 which is purely stability
> fixes against 2.6.20 if there is demand for it.  Anyone who really cares
> about stability of kernel.org kernels won't be deploying 2.6.20 within a
> few weeks of its release anyway, so by the time they doodle over to
> kernel.org they'll find 2.6.20.2 or whatever.

I'd like to throw my opinion into the discussion at this point too, for what 
it's worth.

I think the idea of forking off certain releases in the 2.6.x.0 form, to only 
recieve bugfixes and security updates, is a very good idea. A couple of 
points against it were raised above, but I think if it were approached the 
right way, they wouldn't be issues.

There wouldn't be a huge maintenance overhead, as

  -- The forks would only need to happen occasionally. When 2.6.y has advanced 
past 2.6.x (y > x) sufficiently (i.e. it has significant new functionality) 
and it has been released for sufficient time to iron out obvious bugs, then 
if it comes to be considered a particularly stable release, it would be a 
good candidate for freezing at 2.6.y.0. I would think this sort of thing 
would probably only need to happen once or maybe twice per every ten or so 
traditional releases.

  -- The only maintenance that would be needed on these frozen versions would 
be a backport of any critical bugfixes / security issues, when they occur.


The table on the front page at kernel.org could be augmented with an extra 
row, showing the most recent frozen release from the stable tree. Users who 
want a recent _vanilla_ kernel that is unchanging and hopfully highly stable, 
could choose it.

On Sat, 24 Jul 2004 06:57, Timothy Miller wrote:
> Does that mean that 2.6.21 and 2.6.20.1 are two separate forks of
> 2.6.20, one for development, and the other for stability?
>
> How is this fundamentally different from how it was done before with
> odd/even minor numbers?

IMO the process wouldn't mirror the old 2.x / 2.y model because it is much 
more fine-grained. With the old model, changes have to be backported to a 
kernel that is significantly older, and which potentially has seen 
fundamental changes in the releases between (i mean between 2.x -> 2.y). With 
the new model, a release 'freeze' could be made whenever deemed necessary, 
and since it will be a lot closer on the timeline to where the main 
development is happening, backporting the critical stuff should be a lot less 
of a headache.

The important part would be to not go overboard with release freezing, so 
there wouldn't be 10 frozen kernels to backport to. _That_ would be a 
headache.


There's my $0.02. :)

-- 
	Ben
