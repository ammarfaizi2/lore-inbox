Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263149AbUEKShc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263149AbUEKShc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 14:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263163AbUEKShb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 14:37:31 -0400
Received: from smtp014.mail.yahoo.com ([216.136.173.58]:36759 "HELO
	smtp014.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263149AbUEKShY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 14:37:24 -0400
Subject: Re: [patch] really-ptrace-single-step
From: Fabiano Ramos <ramos_fabiano@yahoo.com.br>
To: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405111036320.25232@bigblue.dev.mdolabs.com>
References: <Pine.LNX.4.58.0405111007440.25232@bigblue.dev.mdolabs.com>
	 <1084297014.1729.10.camel@slack.domain.invalid>
	 <Pine.LNX.4.58.0405111036320.25232@bigblue.dev.mdolabs.com>
Content-Type: text/plain
Message-Id: <1084300801.1729.7.camel@slack.domain.invalid>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 11 May 2004 15:40:02 -0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-05-11 at 14:38, Davide Libenzi wrote:
> On Tue, 11 May 2004, Fabiano Ramos wrote:
> 
> > It would not work against 2.6.5, since
> > 
> > do_syscall_trace()
> > 
> > makes the check
> > 
> > if (!test_thread_flag(TIF_SYSCALL_TRACE))
> > 		return;
> > 
> > Simply removing it would do?
> 
> No no. You need to OR it with the single-step. Try:
> 
> if (!test_thread_flag(TIF_SYSCALL_TRACE) && 
>     !test_thread_flag(TIF_SINGLESTEP))
> 	return;
> 
> 
> - Davide

Still not working. :(
Correct me if I am wrong: is TIF_SINGLESTEP asserted whenever a process
is being singlestepped? I do not see where it is done.

> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

