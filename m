Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263638AbTGAXzl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 19:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263765AbTGAXzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 19:55:41 -0400
Received: from web40607.mail.yahoo.com ([66.218.78.144]:7245 "HELO
	web40607.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263638AbTGAXzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 19:55:40 -0400
Message-ID: <20030702001001.28996.qmail@web40607.mail.yahoo.com>
Date: Tue, 1 Jul 2003 17:10:01 -0700 (PDT)
From: Muthian Sivathanu <muthian_s@yahoo.com>
Subject: scheduling with spinlocks held ?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is it safe to assume that the kernel will not preempt
a process when its holding a spinlock ?  I know most
parts of the code make sure they dont yield the cpu
when they are holding spinlocks, but I was just
curious if there is any place that does that.

Basically, the context is, I need to change the
scheduler a bit to implement "perfect nice -19"
semantics, i.e. give cpu to nice 19 process only if no
other normal process is ready to run.  I am wondering
if there is a possibility of priority inversion if the
nice-d process happens to yield the cpu and then never
get scheduled because a normal process is spinning on
the lock.

thanks for any input,
Muthian.

__________________________________
Do you Yahoo!?
SBC Yahoo! DSL - Now only $29.95 per month!
http://sbc.yahoo.com
