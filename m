Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbUL3Ajj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbUL3Ajj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 19:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbUL3Aji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 19:39:38 -0500
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:58824 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S261470AbUL3Afy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 19:35:54 -0500
From: David Brownell <david-b@pacbell.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: lease.openlogging.org is unreachable
Date: Wed, 29 Dec 2004 16:36:18 -0800
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200412291636.19043.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There's something in BK that refuses to work when it can't contact
> lease.openlogging.org, regardless of whether you just renewed the lease
> or not.  

For the record, I've seen this regularly too.  BK 3.2.3
was the last that showed it for me.  I'm glad to know
it wasn't just me ... but would be more glad if none
of us saw the problem!  :)

Last time I looked at the failure mode there was no issue
of network connectivity being missing, or even changing.
Host names on these systems don't change; neither do IP
addresses (though they're behind a NAT gateway).

>From memory (== may not be quite right), what I did was
"bk lease renew", then "bk pull" (or maybe clone; it failed
because it thought openlogging.org was playing hide/seek);
then "bk lease show" showed three (!!) current licences.

I've also had the "...unreachable" messages immediately after
renewing a lease, when cloning from a private tree but with
the network link down.  (That is, same as previous setup,
except the link is down.)  It's actually kind of annoying
to fail at the _end_ of a clone operation, leaving a tree
that doesn't seem recoverable, rather than at the start.

- Dave


