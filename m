Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310243AbSCBBco>; Fri, 1 Mar 2002 20:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310246AbSCBBcf>; Fri, 1 Mar 2002 20:32:35 -0500
Received: from mx1.afara.com ([63.113.218.20]:57748 "EHLO afara-gw.afara.com")
	by vger.kernel.org with ESMTP id <S310243AbSCBBcT>;
	Fri, 1 Mar 2002 20:32:19 -0500
Message-ID: <3C802B9B.5FA7058E@cs.columbia.edu>
Date: Fri, 01 Mar 2002 17:32:11 -0800
From: Ethan Solomita <ethan@cs.columbia.edu>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-SGI_XFS_1.0.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: local_bh_disable vs. local_irq_disable: hierarchical?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Mar 2002 01:32:11.0558 (UTC) FILETIME=[133E4460:01C1C18A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	My straightforward question: If code has called local_irq_disable, does
this guarantee that a bottom half handler cannot run?

	I'm looking for a statement on semantics. I've tried to hunt
documentation in many forms. None of them imply that disabling irqs
would also disable bottom halves. It might just be me, but I have a
strong sense that disabling interrupts is a stronger statement than
disabling bottom halves.

	However I don't want to trust my instincts for this. I am looking for a
clear statement on the Linux definitions. And I am not asking this
question just to satisfy some curiosity -- there is an underlying
problem I'm hoping to put to rest.

	Thanks!
	-- Ethan
