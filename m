Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317291AbSFRDSY>; Mon, 17 Jun 2002 23:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317290AbSFRDSX>; Mon, 17 Jun 2002 23:18:23 -0400
Received: from mail.webmaster.com ([216.152.64.131]:63736 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S317289AbSFRDSX> convert rfc822-to-8bit; Mon, 17 Jun 2002 23:18:23 -0400
From: David Schwartz <davids@webmaster.com>
To: <rml@tech9.net>
CC: <mgix@mgix.com>, <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.61 (1025) - Licensed Version
Date: Mon, 17 Jun 2002 20:18:22 -0700
In-Reply-To: <1024361703.924.176.camel@sinai>
Subject: Re: Question about sched_yield()
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Message-ID: <20020618031823.AAA786@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>    This neither says nor implies anything about CPU usage. It simply says
>>that  the current thread will yield and be put at the end of the list.

>And you seem to have a misconception about sched_yield, too.  If a
>machine has n tasks, half of which are doing CPU-intense work and the
>other half of which are just yielding... why on Earth would the yielding
>tasks get any noticeable amount of CPU use?

	Because they're running infinite loops!

>Quite frankly, even if the supposed standard says nothing of this... I
>do not care: calling sched_yield in a loop should not show up as a CPU
>hog.

	Calling any function that does not block in an endless loop *should* show up 
as a CPU hog. Yielding is not blocking or even lowering your priority.

	DS


