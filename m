Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbUDDGsx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 01:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbUDDGsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 01:48:53 -0500
Received: from web40514.mail.yahoo.com ([66.218.78.131]:50549 "HELO
	web40514.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262215AbUDDGsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 01:48:51 -0500
Message-ID: <20040404064850.63920.qmail@web40514.mail.yahoo.com>
Date: Sat, 3 Apr 2004 22:48:50 -0800 (PST)
From: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
Subject: kernel stack challenge
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a stack hungry code in the kernel. It hits the
end of stack from time to time. I wrote function to
which I pass pointers to function and memory area
which should be used as stack for function execution.
(I just load pointer to new stack area into esp
register). This function works just fine in user space
and memory area provided by me is used as stack.

This function doesn't work in the kernel (system hungs
instantly when my function is called). Does antbody
have any idea what the reason can be? Some special
alignment? Special memory segment? In what direction
should I look?

(sure I tried some magic with alignment like -
__attribute__ ((aligned (8192))) - no any effect)

(there was some patch to increase stack size
kernelwide, but I don't want to affect all the
system).

Thanks,

Serge.

__________________________________
Do you Yahoo!?
Yahoo! Small Business $15K Web Design Giveaway 
http://promotions.yahoo.com/design_giveaway/
