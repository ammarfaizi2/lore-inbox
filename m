Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269078AbUINA1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269078AbUINA1I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 20:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269079AbUINA1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 20:27:08 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:1929 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269078AbUINA1D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 20:27:03 -0400
Message-ID: <7798951e04091317273b1bed29@mail.gmail.com>
Date: Mon, 13 Sep 2004 19:27:02 -0500
From: hotdog day <hotdogday@gmail.com>
Reply-To: hotdog day <hotdogday@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-rc2 and Hyperthreading. (SMT)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been testing the 2.6.9-rc1, and 2.6.9-rc2 kernel patches over
the past couple days and have been having some issues with
hyperthreading (SMT) turned on.

This problem first exhibited itself when I was testing 
2.6.9-rc2-mm2-love2. I noticed the following quirks that ONLY show
themselves with hyperthreading enabled on my 3.0C Pentium 4.

Random HARD LOCKS. No messages from the kernel. Just a good swift hard lock.

Hard locks when mounting two cdrom drives in quick succession. 

Turning off hyperthreading solves these issues.  Going back to 2.6.8.1
solves these issues.

I then tried 2.6.9-rc1 with no mm or love patches. I had the exact same issues. 

Today I downloaded the prepatch to 2.6.9-rc2 and applied it to clean
2.6.8 source. The issues are still there.

I hope someone is paying attention to the way scheduler tweaks and
changes are affecting SMT enabled kernels. I don't think anyone wants
to disable features of their hardware in order to run an optimized
scheduler.
