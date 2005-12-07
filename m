Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750889AbVLGD5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbVLGD5e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 22:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbVLGD5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 22:57:34 -0500
Received: from mx1.redhat.com ([66.187.233.31]:40648 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750889AbVLGD5e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 22:57:34 -0500
Date: Tue, 6 Dec 2005 22:57:25 -0500
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: odd tsc related msg at bootup.
Message-ID: <20051207035725.GB16838@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Whilst diagnosing an unrelated problem by looking through
a users dmesg, I noticed this..

CPU#0 had 0 usecs TSC skew, fixed it up.
CPU#1 had 0 usecs TSC skew, fixed it up.

Which looks very strange.
Taking a look at the code in arch/i386/kernel/smpboot.c:synchronize_tsc_bp()
I'm puzzled at to how this happened, as we should only hit that
printk with a skew of more than 2 usecs.

		Dave
