Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263126AbUDTRvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263126AbUDTRvL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 13:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263688AbUDTRvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 13:51:11 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:31903 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S263126AbUDTRvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 13:51:10 -0400
To: Eli Cohen <mlxk@mellanox.co.il>
Cc: linux-kernel@vger.kernel.org
Subject: stack dumps, CONFIG_FRAME_POINTER and i386 (was Re: sysrq shows impossible call stack)
References: <408545AA.6030807@mellanox.co.il> <52ekqizkd2.fsf@topspin.com>
	<40855F95.7080003@mellanox.co.il>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 20 Apr 2004 10:51:08 -0700
In-Reply-To: <40855F95.7080003@mellanox.co.il>
Message-ID: <5265buzgfn.fsf_-_@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 20 Apr 2004 17:51:09.0246 (UTC) FILETIME=[0FD72DE0:01C42700]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Your question prompted me to look at show_trace() in
arch/i386/kernel/traps.c.  I see that even in kernels as new as 2.6.5,
there is no attempt to use frame pointers for stack dumps even when
CONFIG_FRAME_POINTER is set.  I seem to remember some patches to do
this floating around a while ago.  How did that discussion end up?

(Red Hat seems to have something to do this in the source for the
version of 2.4.21 that they ship in RHEL 3, but none of their shipped
kernels turn on CONFIG_FRAME_POINTER).

Thanks,
  Roland
