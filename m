Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264251AbUDNOXr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 10:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264252AbUDNOXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 10:23:47 -0400
Received: from rtlab.med.cornell.edu ([140.251.145.175]:54483 "EHLO
	openlab.rtlab.org") by vger.kernel.org with ESMTP id S264251AbUDNOXq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 10:23:46 -0400
Date: Wed, 14 Apr 2004 10:23:45 -0400 (EDT)
From: "Calin A. Culianu" <calin@ajvar.org>
X-X-Sender: <calin@rtlab.med.cornell.edu>
To: <linux-kernel@vger.kernel.org>
Subject: Shielded CPUs
Message-ID: <Pine.LNX.4.33L2.0404141013330.20579-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This might be a bit off-topic (and might belong in the rtlinux mailing
list), but I wanted people's opinion on LKML...

There's an article in the May 2004 Linux Journal about some CPU affinity
features in Redhawk Linux that allow a process and a set of interrupts to
be locked to a particular CPU for the purposes of improving real-time
performance.  This technique is dubbed CPU Shielding
(http://www.ccur.com/isddocs/wp-shielded-cpu.pdf) and the claim is made
that a user program that is thus configured (with the appropriately
patched kernel, of course) can acheive deterministic (hard) real-time
performance.  The author claimed you can get (bounded) interrupt response
time in the 100s of microseconds, and he alluded to the fact that
scheduling jitter also is reduced and bounded with a hard limit.

Does this make any sense to anyone here?

Specifically, what about, among other things, priority inversion?

Presumably your high priority task is always undergoing some small amount
of priority inversion if it touches a spinlock.  Worse yet, if your
process ever has to touch anything in the Linux kernel that needs to sleep
(such as, say, memory being swapped from disk) then your hard realtime
program has just failed to be hard realtime.

Does anyone know anything more about this?  Is this magic?!  The author of
this paper certainly makes it seem like it is...

Perplexedly yours,

-Calin



