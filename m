Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262336AbVAKGg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262336AbVAKGg3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 01:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbVAKGg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 01:36:29 -0500
Received: from lon-del-03.spheriq.net ([195.46.50.99]:51937 "EHLO
	lon-del-03.spheriq.net") by vger.kernel.org with ESMTP
	id S262336AbVAKGgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 01:36:25 -0500
From: Alex LIU <alex.liu@st.com>
To: "'Andries Brouwer'" <aebr@win.tue.nl>, "'Pavel Machek'" <pavel@ucw.cz>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: The purpose of PT_TRACESYSGOOD
Date: Tue, 11 Jan 2005 14:28:33 +0800
Message-ID: <00ac01c4f7a6$c79e03f0$ac655e0a@sha.st.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
In-Reply-To: <20050111023003.GA2760@pclin040.win.tue.nl>
X-O-Virus-Status: No
X-O-URL-Status: Not Scanned
X-O-CSpam-Status: Not Scanned
X-O-Spam-Status: Not scanned
X-O-Image-Status: Not Scanned
X-O-Att-Status: No
X-SpheriQ-Ver: 1.8.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Then I think the tracing thread should call the ptrace_request to set
PTRACE_O_TRACESYSGOOD flag of the traced thread first before
ptrace(PTRACE_SYSCALL...) ,right?
Thanks a lot! 

Alex

Andries Brouwer wrote:

>> What's the effect of PT_TRACESYSGOOD flag? I found it's used only set 
>> in ptrace_setoptions, which is called in the function ptrace_request. 
>> And the PT_TRACESYSGOOD flag will be requested in do_syscall_trace. 
>> What's the purpose of that flag?

>/*
> * A child stopped at a syscall has status as if it received SIGTRAP.
> * In order to distinguish between SIGTRAP and syscall, some kernel
> * versions have the PTRACE_O_TRACESYSGOOD option, that sets an extra
> * bit 0x80 in the syscall case.
> */

