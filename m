Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317214AbSFRBli>; Mon, 17 Jun 2002 21:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317230AbSFRBlh>; Mon, 17 Jun 2002 21:41:37 -0400
Received: from dsl092-042-129.lax1.dsl.speakeasy.net ([66.92.42.129]:39685
	"EHLO mgix.com") by vger.kernel.org with ESMTP id <S317214AbSFRBlc>;
	Mon, 17 Jun 2002 21:41:32 -0400
From: <mgix@mgix.com>
To: "David Schwartz" <davids@webmaster.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Question about sched_yield()
Date: Mon, 17 Jun 2002 18:41:33 -0700
Message-ID: <AMEKICHCJFIFEDIBLGOBCEEECBAA.mgix@mgix.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20020618004630.AAA28082@shell.webmaster.com@whenever>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: David Schwartz [mailto:davids@webmaster.com]
> Sent: Monday, June 17, 2002 5:46 PM
> To: mgix@mgix.com; linux-kernel@vger.kernel.org
> Subject: Re: Question about sched_yield()
> 
> 
> 
> On Sat, 15 Jun 2002 15:15:32 -0700, mgix@mgix.com wrote:
> >
> >Hello,
> >
> >I am seeing some strange linux scheduler behaviours,
> >and I thought this'd be the best place to ask.
> >
> >I have two processes, one that loops forever and
> >does nothing but calling sched_yield(), and the other
> >is basically benchmarking how fast it can compute
> >some long math calculation.
> [snip]
> 
> 	You seem to have a misconception about what sched_yield is for. It is not a 
> replacement for blocking or a scheduling priority adjustment. It simply lets 
> other ready-to-run tasks be scheduled before returning to the current task.
> 
> 	Here's a quote from SuS3:
> 
> "The sched_yield() function shall force the running thread to relinquish the 
> processor until it again becomes the head of its thread list. It takes no 
> arguments."
> 
> 	This neither says nor implies anything about CPU usage. It simply says that 
> the current thread will yield and be put at the end of the list.

If so, please enlighten me as to when, why, and what for you would use sched_yield.

If willingly and knowingly relinquinshing a CPU does not make it possible
for other processes to use what would otherwise have been your very own slice
of processing time then what could it be used for, I really wonder.

Second, I have tried to run my misconception on various other OS'es I have
access to:Win2k, Mac OSX and OpenBSD, and suprinsingly enough, all of them
seem to be sharing my twisted views of How Things Should Be (tm).

	- Mgix


