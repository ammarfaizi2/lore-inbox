Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261805AbUK2VMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261805AbUK2VMT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 16:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbUK2VMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 16:12:18 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:16322 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261805AbUK2VMQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 16:12:16 -0500
Subject: scheduler BUGON lifespan
From: Darren Hart <dvhltc@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <piggin@cyberone.com.au>,
       Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 29 Nov 2004 13:11:34 -0800
Message-Id: <1101762694.29380.23.camel@farah.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I submitted a patch to active_load_balance() that was accepted into mm
and then mainline.  The patch included a fix to prevent the system
entering what should have been an impossible state.  The previous code
tested for it and then continued, rather than crashing or complaining.
My patch added a BUGON(impossible state) just in case by some fluke it
still happened.  How long should this BUGON remain in the kernel?  A
month, a year?  Is there an accepted duration for such safety nets?

Thanks,

-- 
Darren Hart <dvhltc@us.ibm.com>
IBM Linux Technology Center
