Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbVASInZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbVASInZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 03:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVASIdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 03:33:37 -0500
Received: from waste.org ([216.27.176.166]:20140 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261629AbVASIQz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 03:16:55 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
Message-Id: <1.64403262@selenic.com>
Subject: [PATCH 0/12] random pt3: More core and accounting cleanups
Date: Wed, 19 Jan 2005 00:17:18 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a third series of various cleanups for drivers/char/random.c.
It applies on top of the previous 10.

These bits greatly simplify the setup:
1  More meaningful pool names
2  Static allocation of pools
3  Static sysctl bits

These bits make the accounting safer and the code easier to follow:
4  Catastrophic reseed checks
5  Entropy reservation accounting
6  Reservation flag in pool struct
7  Reseed pointer in pool struct
8  Break up extract_user

These bits clean up the hashing functions:
9  Remove dead MD5 copy
10 Simplify hash folding
11 Clean up hash buffering

This bit drops a bunch of code and reduces lock hold times:
12 Remove entropy batching

The next series focuses on moving and sharing code more appropriately.
