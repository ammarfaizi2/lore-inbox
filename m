Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267278AbUHSTEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267278AbUHSTEy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 15:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267293AbUHSTEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 15:04:54 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:56290 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S267285AbUHSTDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 15:03:51 -0400
Date: Thu, 19 Aug 2004 21:03:50 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: linux-kernel@vger.kernel.org
Subject: i_blocks overflow
Message-ID: <Pine.LNX.4.58.0408192056490.23100@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Maximum file size on Linux is 2^41-2049.
What happens when you create file so large and overflow i_blocks
variable? (because that file will use more than 2^32 blocks, there are
indirect blocks too) There seems to be no check for that in
inode_add_bytes.

This bug applies to both 2.4 and 2.6.

Does anybody have so large raid to try it?

Mikulas
