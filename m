Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266905AbUIJCZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266905AbUIJCZO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 22:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267184AbUIJCZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 22:25:14 -0400
Received: from gate.crashing.org ([63.228.1.57]:5070 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266905AbUIJCZK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 22:25:10 -0400
Subject: fbdev broken in current bk for PPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1094783022.2667.106.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 10 Sep 2004 12:23:42 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recent changes upstream are breaking fbdev on pmacs.

I haven't had time to go deep into that (but I suspect Linus sees it
too on his own g5 unless he removed offb from his .config).

>From what I see, it seems that offb is kicking in by default, reserves
the mmio regions, and then whatever chip driver loads can't access them.

offb is supposed to be a "fallback" driver in case no fbdev is taking
over, it should also be "forced" in with video=ofonly kernel command
line. This logic has been broken.

Ben.


