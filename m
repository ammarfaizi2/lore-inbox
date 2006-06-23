Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751780AbWFWQwD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780AbWFWQwD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 12:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751781AbWFWQwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 12:52:03 -0400
Received: from dsl-202-45-110-141-static.VIC.netspace.net.au ([202.45.110.141]:38084
	"EHLO firewall.reed.wattle.id.au") by vger.kernel.org with ESMTP
	id S1751780AbWFWQwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 12:52:01 -0400
From: Darren Reed <darrenr@reed.wattle.id.au>
Message-Id: <200606231651.k5NGpbYr008153@firewall.reed.wattle.id.au>
Subject: 2.6.11: spinlock problem
To: linux-kernel@vger.kernel.org
Date: Sat, 24 Jun 2006 02:51:37 +1000 (EST)
X-Mailer: ELM [version 2.4ME+ PL107a (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm seeing a spinlock held panic with a kernel stack like this:

spinlock - panic, lock already held
..
__do_softirq
do_softirq
=========
do_IRQ
common_interrupt
spinlock/spinunlock
..

when I load up the system in testing.
The code protected by the spinlock is quite small - counter increment.

I'm using 2.6.11-1.1369_FC4 #1, installed inside of vmware,
running as a guest on a Windows XP box.

Is this
(a) linux allowing the IRQ too early
(b) vmware not doing something right
(c) enivitable
(d) somehow my fault
(e) something else?

Thanks,
Darren
