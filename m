Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264353AbRFSP6X>; Tue, 19 Jun 2001 11:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264359AbRFSP6P>; Tue, 19 Jun 2001 11:58:15 -0400
Received: from [204.94.214.10] ([204.94.214.10]:36409 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S264353AbRFSP6D>; Tue, 19 Jun 2001 11:58:03 -0400
Date: Tue, 19 Jun 2001 09:03:23 -0700
From: richard offer <offer@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: Why can't I ptrace init (pid == 1) ?
Message-ID: <102490000.992966603@changeling.engr.sgi.com>
X-Mailer: Mulberry/2.1.0a6 (Linux/x86)
X-HomePage: http://www.whitequeen.com/users/richard/
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



In arch/i386/kernel/ptrace.c there is the following code ...

	ret = -EPERM;
	if (pid == 1)		/* you may not mess with init */
		goto out_tsk;


What is the rationale for this ? Is this a real security decision or
an implementation detail (bad things will happen).

Thoughts ?

richard.

-----------------------------------------------------------------------
Richard Offer                          Technical Lead, Trust Technology
"Specialization is for insects"                                     SGI
_______________________________________________________________________

