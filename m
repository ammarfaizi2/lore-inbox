Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264061AbTFPRtX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 13:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264066AbTFPRtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 13:49:18 -0400
Received: from rth.ninka.net ([216.101.162.244]:29569 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S264061AbTFPRtE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 13:49:04 -0400
Subject: Re: force_successful_syscall_return() buggy?
From: "David S. Miller" <davem@redhat.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: davidm@hpl.hp.com, Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030616185549.E13312@flint.arm.linux.org.uk>
References: <20030615193604.L5417@flint.arm.linux.org.uk>
	 <16110.147.422432.486761@napali.hpl.hp.com>
	 <20030616185549.E13312@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055786555.22118.0.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 16 Jun 2003 11:02:35 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-16 at 10:55, Russell King wrote:
> I'm not actually talking about subsequent syscalls issued by the kernel.
> I'm talking about stuff like init, bash, and the module tools.

Wrong, after the go for the first time into user space, the
next trap into the kernel will put the pt_regs at the top at
the stack where we expect it to be.

-- 
David S. Miller <davem@redhat.com>
