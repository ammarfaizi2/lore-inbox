Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266174AbUFPFtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266174AbUFPFtv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 01:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266176AbUFPFtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 01:49:51 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:47823 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S266174AbUFPFtu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 01:49:50 -0400
Date: Wed, 16 Jun 2004 11:16:04 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Matt Mackall <mpm@selenic.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] reduce rcu_head size [0/2]
Message-ID: <20040616054604.GA3658@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This was originally proposed by Rusty. I have it in two patches
for a reason - rcu-no-arg changes the call_rcu() api and if it
is too late in 2.6 to introduce it, we could still do some
shrinking by applying the singly-linked-rcu patch. Other than
the documented changes, there is no subtle semantics change -
rcus are still invoked in the same order.
Andrew, this will probably break manfred's patches, but
512-cpu scalability can probably wait a little until
I get around to analyze those (my next task in hand) :)

I have tested the patches lightly on an x86 box.

Thanks
Dipankar
