Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262059AbUJYREX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262059AbUJYREX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 13:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbUJYRDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 13:03:30 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:7051 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S262102AbUJYRA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 13:00:26 -0400
Date: Mon, 25 Oct 2004 19:01:28 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: lowmem_reserve (replaces protection)
Message-ID: <20041025170128.GF14325@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a forward port to 2.6 CVS of the lowmem_reserve VM feature in
the 2.4 kernel.

	http://www.kernel.org/pub/linux/kernel/people/andrea/patches/v2.6/2.6.9/lowmem_reserve-1

Lack of this feature might explain out of memory related killing or
deadlocks hit on >2G boxes. so if anybody is having trouble with oom
conditions this is a patch to try.

this is only slightly tested but works for me so far.

This is the first of a series of oom related fix I'm going to do and
test within the next weeks to attempt to cure various oom regressions in
2.6 (deadlocks turned into crazy early oom kills and the like).
