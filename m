Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266024AbUA1PjG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 10:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266031AbUA1PjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 10:39:06 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:63754 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S266024AbUA1PjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 10:39:03 -0500
Date: Wed, 28 Jan 2004 23:37:51 +0800 (WST)
From: raven@themaw.net
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Jeremy Fitzhardinge <jeremy@goop.org>,
       Maneesh Soni <maneesh@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Mike Waychison <Michael.Waychison@Sun.COM>
Subject: [PATCH 0/8] autofs4-2.6 - to support autofs 4.1.x
Message-ID: <Pine.LNX.4.58.0401282252520.17471@raven.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=0.8, required 8,
	NO_REAL_NAME, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In a thread between Mike Waychison, Maneesh Soni and Al Viro the question 
of why the autofs4 expire patch I wrote had not been posted to LKML.

This patch is part of a patch set to support functionality in autofs 
4.1.x user space daemon. They have been in operation in 2.4 for some time 
and I have ported them to 2.6.

Locking requirements are different in 2.6 and so I'm seeking comments and 
suggestions. I have taken a rather heavy handed approach to this in the 
port. For example, the VFS operations that directly change the filesystem, 
such as autofs4_mkdir etc,  hold the inode semaphore on entry so the BKL 
has been removed. I can't see why two locking mechanisms are needed. 
Rather than add locking all over the place, I'm looking for justification 
it's needed, as I don't see it myself.

The patches that follow are also available at:

http://www.kernel.org/pub/linux/kernel/people/raven/autofs4-2.6

Regards
Ian

