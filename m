Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262529AbVAUVxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262529AbVAUVxI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 16:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262526AbVAUVwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 16:52:03 -0500
Received: from waste.org ([216.27.176.166]:27865 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262530AbVAUVlT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 16:41:19 -0500
Date: Fri, 21 Jan 2005 15:41:05 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
Message-Id: <1.314297600@selenic.com>
Subject: [PATCH 0/12] random pt4: Moving and sharing code
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This series focuses on moving and sharing code in
/drivers/char/random.c. It applies on top of -mm2 which contains my
earlier patches.

New bitop:
1  Create new rol32/ror32 bitops
2  Use them throughout the tree

Share SHA code in lib:
3  Kill the SHA1 variants
4  Cleanup SHA1 interface
5  Move SHA1 code to lib/
6  Replace SHA1 with faster version
7  Update cryptolib to use SHA1 from lib

Share halfmd4 hash:
8  Move halfMD4 to lib
9  Kill duplicate halfMD4 in ext3 htree

Move network random bits:
10 Simplify and shrink syncookie code
11 Move syncookies to net/
12 Move other tcp/ip bits to net/
