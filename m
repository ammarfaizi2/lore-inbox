Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbUKEW1Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbUKEW1Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 17:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbUKEW1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 17:27:16 -0500
Received: from sweetums.bluetronic.net ([24.199.150.42]:34229 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S261224AbUKEW0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 17:26:21 -0500
Date: Fri, 5 Nov 2004 17:24:08 -0500 (EST)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
cc: <arjanv@redhat.com>, <ak@suse.de>
Subject: breakage: flex mmap patch for x86-64
Message-ID: <Pine.GSO.4.33.0411051716230.9358-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet Key: 4188122b4-5vHFkvfD5Pc0Egjyaz8w

======== ChangeSet 1.2424.7.12 ========
D 1.2424.7.12 04/11/02 15:03:07-08:00 ak@suse.de[torvalds] 53848 53847 3/0/1
P ChangeSet
C [PATCH] x86_64: flex mmap patch for x86-64
C
C From: Arjan van de Ven <arjanv@redhat.com>
C
C Do flex mmap for x86-64.  mmaps will grow down in the address space now
C instead of up.
C
C Patch has 2 parts; the generic strategy selection, and code to make a correct
C TASK_SIZE .  the later may be fixed in your tree already in which case it's
C redundant.
C
C Modified by AK to apply to 64bit processes too.
C
C Signed-off-by: Andrew Morton <akpm@osdl.org>
C Signed-off-by: Linus Torvalds <torvalds@osdl.org>
------------------------------------------------

This prevents 32bit apps from running on x86_64.  Backing out the Makefile
and processor.h changes has everything working again.  Perhaps something
needs to check for a 32bit environment?  I don't know if it's the change
to TASK_SIZE or the "backwards" mmaps that's the real breakage.  And at this
point, I don't have time to test.

(64bit apps work just fine.)

--Ricky


