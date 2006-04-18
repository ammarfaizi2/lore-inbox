Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751400AbWDRHXD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbWDRHXD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 03:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWDRHXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 03:23:03 -0400
Received: from pproxy.gmail.com ([64.233.166.176]:26581 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751400AbWDRHXC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 03:23:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=onYcyADe98F1+iVGFrsCCDcsJ0vx/RXaUGgMp/FzXW4n5fKiLoeNGiyhNztVV1QHsDWVpgJd7csUu5/uZ4qaAAe80TxysrGVMSOkQwwXQUP0cS2cPMO0cJu4RKLoBK9aODGKEh71449UCaPJRvdL+ceJoUa9CbRmfvVi9cO2a6c=
Message-ID: <bf3792800604180023r2a2111b4ude5ef15f9dd855a@mail.gmail.com>
Date: Tue, 18 Apr 2006 15:23:01 +0800
From: "Liu haixiang" <liu.haixiang@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Question on Schedule and Preemption
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Now I am developing the driver on Linux kernel 2.6.11. And I met the
problem that kernel will dump my stack from time to time. And the
kernel log will give me messages like "scheduling while atomic: ...".

Then I found the code in sched.c:

if (likely(!current->exit_state)) {
	if (unlikely(in_atomic())) {
		printk(KERN_ERR "scheduling while atomic: "
			"%s/0x%08x/%d\n",
			current->comm, preempt_count(), current->pid);
		dump_stack();
	}
}

Anybody can explain above code for me?

Thanks

best regards

Haixiang Liu
