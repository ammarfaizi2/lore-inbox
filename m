Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263051AbTJYVrT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 17:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263056AbTJYVrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 17:47:19 -0400
Received: from relay01.uchicago.edu ([128.135.12.136]:30360 "EHLO
	relay01.uchicago.edu") by vger.kernel.org with ESMTP
	id S263051AbTJYVrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 17:47:14 -0400
Date: Sat, 25 Oct 2003 16:47:13 -0500 (CDT)
From: Ryan Reich <ryanr@uchicago.edu>
Reply-To: Ryan Reich <ryanr@uchicago.edu>
To: linux-kernel@vger.kernel.org
Subject: Kernel context 0 and 2.4.22-ck2
Message-ID: <Pine.LNX.4.58.0310251637020.599@ryanr.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting the following error on boot:

Oct 25 16:35:08 (none) kernel: [drm] Initialized radeon 1.7.0 20020828 on minor
0
Oct 25 16:35:08 (none) kernel: [drm:radeon_unlock] *ERROR* Process 373 using
kernel context 0

Process 373 being X.

This prevents me from getting direct rendering in X.  I compiled a vanilla
2.4.22 and found that this error does not occur there, and the only patches I
have on my current kernel are ck2, an i2c patch which has nothing to do with
this because the error appeared before I put it in, and the ck2-fix patch, which
doesn't seem to have corrected the problem.  I do not think it has anything to
do with grsecurity, since I enabled sysctl there and left all the security
measures unconfigured, to no effect.

If it's an error in the code I am manifestly unqualified to fix it myself, but I
could go digging for more information if anyone needs it (and can give a
specific command to execute).

Hardware-wise, I'm using a Radeon 7000 QY card on a Shuttle motherboard with all
NForce2 chipset, and an Athlon 2600+ CPU.

Ryan Reich
