Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315471AbSFTUbv>; Thu, 20 Jun 2002 16:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315469AbSFTUbu>; Thu, 20 Jun 2002 16:31:50 -0400
Received: from mail.webmaster.com ([216.152.64.131]:37101 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S315461AbSFTUbu> convert rfc822-to-8bit; Thu, 20 Jun 2002 16:31:50 -0400
From: David Schwartz <davids@webmaster.com>
To: <stevie@qrpff.net>, <rml@tech9.net>,
       Chris Friesen <cfriesen@nortelnetworks.com>
CC: <mgix@mgix.com>, <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.61 (1025) - Licensed Version
Date: Thu, 20 Jun 2002 13:31:47 -0700
In-Reply-To: <5.1.0.14.2.20020618184424.00ab6418@whisper.qrpff.net>
Subject: Re: Question about sched_yield()
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <20020620203148.AAA10409@shell.webmaster.com@whenever>
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
>now, give my time to someone who does".  If a thread is doing useful work,
>why would it call sched_yield() ?!?

	To give other threads a chance to do useful work too, perhaps because it 
just released a mutex that other threads might need that it held for an 
unusually long time.

	DS


