Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268762AbUILSIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268762AbUILSIY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 14:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268764AbUILSIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 14:08:24 -0400
Received: from the-village.bc.nu ([81.2.110.252]:19381 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268762AbUILSHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 14:07:14 -0400
Subject: RE: Linux 2.4.27 SECURITY BUG - TCP Local and REMOTE(verified)
	Denial of Service Attack
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Wolfpaw - Dale Corse <admin@wolfpaw.net>
Cc: kaukasoi@elektroni.ee.tut.fi,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <002301c498ee$1e81d4c0$0200a8c0@wolf>
References: <002301c498ee$1e81d4c0$0200a8c0@wolf>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095008692.11736.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 12 Sep 2004 18:04:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-09-12 at 18:29, Wolfpaw - Dale Corse wrote:
> A fair comment :) But look at it this way:
> 
> - The TCP RFC was last updated when?

About 2 months ago. The 793 RFC isn't updated instead new ones are added
for the additional features/discoveries.

> - What is the average time for a tcp packet to fly even across
>   the world these days? Maybe 300 ms? 1 second? 5?
> - It is not a secret that the TCP protocol has flaws, take for
>   example the RST bug, which required among other things, BGP4
>   to use MD5 encryption to avoid being potentially attacked.

This is not a TCP flaw, its a combination of poor design by certain
vendors, poor BGP implementation and a lack of understanding of what TCP
does and does not do. See IPSec. TCP gets stuff from A to B in order and
knowing to a resonable degree what arrived. TCP does not proide a
security service.

(The core of this problem arises because certain people treat TCP
connection down on the peering session as link down)

> So this brings me to:
> 
> A) Why are the timeouts so long?

So you don't get random corruption

> C) Socket still re-uses an FD before it is actually completely

Pardon ?

> sending something to the other side is required, but I can't see why having
> the other side send something back is part of the protocol. This could be

Because packet sizes are finite and not doing so requires an infinite
sequence space and thus infinite packet sizes. Reread the TCP
specifications more carefully, also look at RFC1337 which discusses some
of the real world cases of getting this wrong.


