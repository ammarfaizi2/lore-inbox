Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267817AbUHPRkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267817AbUHPRkW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 13:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267820AbUHPRkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 13:40:21 -0400
Received: from 64.89.71.154.nw.nuvox.net ([64.89.71.154]:26757 "EHLO
	gate.apago.com") by vger.kernel.org with ESMTP id S267817AbUHPRkL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 13:40:11 -0400
SMTP-Relay: dogwood.freil.com
Message-Id: <200408161740.i7GHe4Aa022031@dogwood.freil.com>
X-Mailer: exmh version 2.0.2 2/24/98
To: linux-kernel@vger.kernel.org
Subject: Re: Serious Kernel slowdown with HIMEM (4Gig) in 2.6.7
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 16 Aug 2004 13:40:03 -0400
From: "Lawrence E. Freil" <lef@freil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem solved.

I found a reference to a very similar (turns out same) problem with the
2.4 series kernels.  The problem is because the mtrr maps do not quite
cover all the memory the system was reporting.   Memory that does not
show up in the mtrr must be being mapped as non-cacheable.  Is there
a reason the system defaults to this as oppose to cacheable?  It obviously
sees the holes?  I can work around the problem by adding "mem=1008" instead
of letting it default (or I suppose I could patch the mtrr after boot).

Thanks for all those with suggestions and what to look for.

-- 
        Lawrence Freil                      Email:lef@freil.com
        1768 Old Country Place              Phone:(770) 667-9274
        Woodstock, GA 30188


