Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267844AbTB1Md4>; Fri, 28 Feb 2003 07:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267847AbTB1Mdz>; Fri, 28 Feb 2003 07:33:55 -0500
Received: from packet.digeo.com ([12.110.80.53]:51608 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267844AbTB1Mdx>;
	Fri, 28 Feb 2003 07:33:53 -0500
Date: Fri, 28 Feb 2003 04:44:07 -0800
From: Andrew Morton <akpm@digeo.com>
To: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: anticipatory scheduling questions
Message-Id: <20030228044407.7836e46e.akpm@digeo.com>
In-Reply-To: <20030228121806.16285.qmail@linuxmail.org>
References: <20030228121806.16285.qmail@linuxmail.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Feb 2003 12:44:07.0463 (UTC) FILETIME=[15586B70:01C2DF27]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org> wrote:
>
> I have done benchmark tests with Evolution under the following conditions:
> (times measured since the reply button is clicked until the message is
> opened) 
>  
> 2.4.20-2.54 -> 9s 
> 2.5.63-mm1 w/Deadline -> 34s 
> 2.5.63-mm1 w/AS -> 33s 

Well something has gone quite wrong there.   It sounds as if something in
the 2.5 kernel has broken evolution.

Does this happen every time you reply to a message or just the first time?

And if you reply to a message, then quit evolution, then restart evolution
then reply to another message, does the same delay happen?

The above tests will eliminate the IO system at least.

If the delay is still there when all the needed datais in pagecache then
please run `vmstat 1' during the operation and send the part of the trace
from the period when the delay happens.

I'd suggest that you launch evolution from the command line in an xterm so
you can watch for any diagnostic messages.

Thanks.
