Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317738AbSFSCL7>; Tue, 18 Jun 2002 22:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317737AbSFSCL7>; Tue, 18 Jun 2002 22:11:59 -0400
Received: from mail.webmaster.com ([216.152.64.131]:58011 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S317736AbSFSCLz> convert rfc822-to-8bit; Tue, 18 Jun 2002 22:11:55 -0400
From: David Schwartz <davids@webmaster.com>
To: <stevie@qrpff.net>, <rml@tech9.net>,
       Chris Friesen <cfriesen@nortelnetworks.com>
CC: <mgix@mgix.com>, <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.61 (1025) - Licensed Version
Date: Tue, 18 Jun 2002 19:11:52 -0700
In-Reply-To: <5.1.0.14.2.20020618184424.00ab6418@whisper.qrpff.net>
Subject: Re: Question about sched_yield()
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <20020619021154.AAA2518@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 18 Jun 2002 18:45:55 -0400, Stevie O wrote:

>At 11:00 AM 6/18/2002 -0700, David Schwartz wrote:

>>This is the same error repeated again. Since you realize that an endless
>>loop on sched_yield is *not* equivalent to blocking, why do you then say
>>"in
>>fact doing useful work"? By what form of ESP is the kernel supposed to
>>determine that the sched_yield task is not 'doing useful work' and the
>>other
>>task is?

>By this form of ESP: sched_yield() means "I have nothing better to do right
>now, give my time to someone who does".

	No, this is not what sched_yield means. What 'sched_yield' means is that 
you're at a point where it's convenient for another process to run. For 
example, perhaps you just released a mutex that you held for a long period of 
time, or perhaps you could function more efficiently if you could acquire a 
resource another thread holds.

>If a thread is doing useful work,
>why would it call sched_yield() ?!?

	Perhaps to allow other threads to make forward progress. Perhaps to give 
other threads a chance to use a resource it just released. Perhaps in hopes 
that another thread will release a resource it could benefit from being able 
to acquire.

	DS


