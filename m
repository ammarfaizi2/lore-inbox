Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbTEUQSd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 12:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbTEUQSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 12:18:33 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:8452 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262192AbTEUQSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 12:18:32 -0400
Subject: Re: userspace irq balancer
From: James Bottomley <James.Bottomley@steeleye.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 21 May 2003 11:31:30 -0500
Message-Id: <1053534694.1681.10.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm interested in using this for voyager.  However, I have a problem in
that voyager may have CPUs that can't accept interrupts (this is global
on voyager, but may be per-interrupt on NUMA like systems).  I think
before we move to a userspace solution, some thought about how to cope
with this is needed.

I have several suggestions:

1. Place the masks into /proc/irq/<n>/smp_affinity at start of day and
have the userspace irqbalancer take this as the maximal mask

2. Have a separate file /proc/irq/<n>/mask(?) to expose the mask always

3. Some other method...

Comments would be welcome

James


