Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262295AbUCBWvH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 17:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262184AbUCBWsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 17:48:47 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:5256 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262295AbUCBWsf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 17:48:35 -0500
Message-ID: <4045106D.8060902@tmr.com>
Date: Tue, 02 Mar 2004 17:53:33 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roland Dreier <roland@topspin.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: poll() in 2.6 and beyond
References: <1vmPm-4lU-11@gated-at.bofh.it> <1vonq-6dr-37@gated-at.bofh.it> <1voGY-6vC-41@gated-at.bofh.it> <1vpjt-7dl-17@gated-at.bofh.it> <1vpCV-7wY-41@gated-at.bofh.it> <1vpWa-7Py-19@gated-at.bofh.it>
In-Reply-To: <1vpWa-7Py-19@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:

> I don't know why I continue this, but.... can you point out the line
> in the kernel 2.4 source for __pollwait() where it sleeps?
> 
> Or think about it.  Suppose a user called poll() with two fds, each of
> which belonged to a different driver.  Suppose each driver slept in
> its poll method.  If the first driver never became ready (and stayed
> asleep), how would poll() return to user space if the second driver
> became ready?
> 
> What actually happens is that each driver registers with the kernel
> the wait queues that it will wake up when it becomes ready.  But the
> core kernel is responsible for sleeping, outside of the driver code.

Could you maybe go back to the initial report, which is that after 
poll() gets wrong status? It's nice to argue about where the process 
waits, but the issue is if it gets the same status with 2.4 and 2.6, and 
if not which one should be fixed.

Richard: can you show this with a small demo program? I assume you 
didn't find this just by reading code ;-)
