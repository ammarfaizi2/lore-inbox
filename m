Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbTKGWSR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbTKGWSB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:18:01 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:18205 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S264102AbTKGMEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 07:04:32 -0500
Date: Fri, 7 Nov 2003 04:04:27 -0800
From: Frank Cusack <fcusack@fcusack.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: preemption when running in the kernel
Message-ID: <20031107040427.A32421@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(2.4 kernel)

When a process is running in the kernel, can it be pre-empted at
any time?  (Unless you explicity disable preemption.)  I think not,
because wouldn't it be unsafe to grab a spinlock?  Or does grabbing a
spinlock disable preemption.  I mean spin_lock(), not spin_lock_irqsave().

Secondly, can multiple processes be in the kernel at the same time?  I
think so, that's the reason for the fine grained locks instead of the BKL.
Or do fine grained locks only serve to allow preemption.

thanks!
/fc

