Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317203AbSFRAqb>; Mon, 17 Jun 2002 20:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317202AbSFRAqa>; Mon, 17 Jun 2002 20:46:30 -0400
Received: from mail.webmaster.com ([216.152.64.131]:38645 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S317201AbSFRAqa> convert rfc822-to-8bit; Mon, 17 Jun 2002 20:46:30 -0400
From: David Schwartz <davids@webmaster.com>
To: <mgix@mgix.com>, <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.61 (1025) - Licensed Version
Date: Mon, 17 Jun 2002 17:46:29 -0700
In-Reply-To: <AMEKICHCJFIFEDIBLGOBGEDPCBAA.mgix@mgix.com>
Subject: Re: Question about sched_yield()
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <20020618004630.AAA28082@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 15 Jun 2002 15:15:32 -0700, mgix@mgix.com wrote:
>
>Hello,
>
>I am seeing some strange linux scheduler behaviours,
>and I thought this'd be the best place to ask.
>
>I have two processes, one that loops forever and
>does nothing but calling sched_yield(), and the other
>is basically benchmarking how fast it can compute
>some long math calculation.
[snip]

	You seem to have a misconception about what sched_yield is for. It is not a 
replacement for blocking or a scheduling priority adjustment. It simply lets 
other ready-to-run tasks be scheduled before returning to the current task.

	Here's a quote from SuS3:

"The sched_yield() function shall force the running thread to relinquish the 
processor until it again becomes the head of its thread list. It takes no 
arguments."

	This neither says nor implies anything about CPU usage. It simply says that 
the current thread will yield and be put at the end of the list.

	DS


