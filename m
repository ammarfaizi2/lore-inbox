Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266010AbUFOXZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266010AbUFOXZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 19:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266011AbUFOXZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 19:25:55 -0400
Received: from bhhdoa.org.au ([216.17.101.199]:5903 "EHLO bhhdoa.org.au")
	by vger.kernel.org with ESMTP id S266010AbUFOXZy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 19:25:54 -0400
Message-ID: <1087333441.40cf6441277b5@vds.kolivas.org>
Date: Wed, 16 Jun 2004 07:04:01 +1000
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Stairacse scheduler v6.E for 2.6.7-rc3
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is an updated version of the staircase scheduler. I've been trying to hold
off for 2.6.7 final but this has not been announced yet. Here is a brief update
summary.

http://ck.kolivas.org/patches/2.6/2.6.7-rc3/patch-2.6.7-rc3-s6.E


Changes:

A lot more code from the original scheduler not required by staircase has been
removed (610 deletions, 223 additions).

The "compute" mode now also includes cache trash minimisation by introducing
delayed preemption. A task of higher priority will force a reschedule after a
task has run a minimum of cache_decay_ticks. This increases the latency
slightly but optimises cpu cache utilisation.

The yield() implementation was fixed to ensure it yielded to all other tasks.

Tiny cleanups elsewhere.


Stability of this version has been confirmed in a number of different settings
for days.

Testing, comments welcome.
Con

