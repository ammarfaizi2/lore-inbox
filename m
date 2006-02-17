Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751367AbWBQE5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbWBQE5w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 23:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWBQE5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 23:57:52 -0500
Received: from ozlabs.org ([203.10.76.45]:61071 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751367AbWBQE5v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 23:57:51 -0500
Subject: Robust futexes
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ingo Molnar <mingo@elte.hu>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 17 Feb 2006 15:57:51 +1100
Message-Id: <1140152271.25078.42.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo, all,

	Noticed (via LWN, hence the delay) your robust futex work.  Have you
considered the less-perfect, but simpler option of simply having futex
calls which tell the kernel that the u32 value is in fact the holder's
TID?

	In this case, you don't get perfect robustness when TID wrap occurs:
the kernel won't know that the lock holder is dead.  However, it's
simple, and telling the kernel that the lock is the tid allows the
kernel to do prio inheritence etc. in future.

Cheers!
Rusty.
-- 
 ccontrol: http://ozlabs.org/~rusty/ccontrol

