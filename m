Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751474AbWCDLmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbWCDLmM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 06:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbWCDLmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 06:42:12 -0500
Received: from ozlabs.org ([203.10.76.45]:17084 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751474AbWCDLmM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 06:42:12 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17417.32015.6281.253814@cargo.ozlabs.ibm.com>
Date: Sat, 4 Mar 2006 22:42:07 +1100
From: Paul Mackerras <paulus@samba.org>
To: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@osdl.org>, Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
       clameter@engr.sgi.com, linux-kernel@vger.kernel.org,
       ralf@linux-mips.org, johnstul@us.ibm.com,
       Richard Henderson <rth@twiddle.net>
Subject: Re: [PATCH] simplify update_times (avoid jiffies/jiffies_64 aliasing problem)
In-Reply-To: <20060304112010.GA94875@muc.de>
References: <20060303.114406.64806237.nemoto@toshiba-tops.co.jp>
	<20060302190408.1e754f12.akpm@osdl.org>
	<20060303.133125.106438890.nemoto@toshiba-tops.co.jp>
	<20060304.013153.71086081.anemo@mba.ocn.ne.jp>
	<20060304001834.0476e8e9.akpm@osdl.org>
	<20060304112010.GA94875@muc.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen writes:

> Also I assume Atsushi-san did the patch because he saw a real problem?

Yes, one which I also saw on PPC.  The compiler (gcc-4) emits loads
for jiffies, jiffies64 and wall_jiffies before storing the incremented
jiffies64 value back.

Paul.
