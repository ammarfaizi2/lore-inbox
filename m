Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbVBZD0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVBZD0M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 22:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbVBZD0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 22:26:12 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:23978 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261192AbVBZDYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 22:24:31 -0500
Subject: Linux RT question - __up_mutex calling pi_setprio
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 25 Feb 2005 22:24:22 -0500
Message-Id: <1109388262.1452.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

I have a couple of questions about __up_mutex in rt.c. I'm still using
RT-V0.7.38-06 and this may have changed. I haven't checked.

1) can old_owner ever not be the same as current. IOW can a process
unlock a lock owned by another process?

2) Is it really necessary to call pi_setprio on the old_owner (I guess
if the previous question is true, then this would be too).  If the
process is unlocking a lock, I don't expect it to be also blocked on a
lock so it would not need to iterate the priority list. Wouldn't just
calling mutex_setprio be sufficient?

Thanks,

-- Steve


