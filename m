Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265943AbUJNS0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265943AbUJNS0L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 14:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266186AbUJNS0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 14:26:10 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:39153 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S266748AbUJNR2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 13:28:07 -0400
Message-ID: <416EB723.10604@nortelnetworks.com>
Date: Thu, 14 Oct 2004 11:28:03 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: odd behaviour with SIGCHLD and CLD_TRAPPED
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been playing around a bit with monitoring a child process.

If I send the child a SIGSTOP, the parent gets sent SIGCHLD with si_code == 5.
If I send SIGCONT, the parent gets si_code == 6.

So far so good.

However, if I attach gdb to the child, or detach gdb from the child, the parent 
gets no notification.  It would seem useful for the parent to know that this has 
happened, so it knows that the child may not be running properly.

Is there any way to get this information?

Thanks,

Chris
