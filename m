Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265776AbRF2I0u>; Fri, 29 Jun 2001 04:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265773AbRF2I0l>; Fri, 29 Jun 2001 04:26:41 -0400
Received: from adsl-63-198-73-118.dsl.lsan03.pacbell.net ([63.198.73.118]:19974
	"HELO turing.xman.org") by vger.kernel.org with SMTP
	id <S265776AbRF2I02>; Fri, 29 Jun 2001 04:26:28 -0400
Message-Id: <5.1.0.14.0.20010629012354.02b759d0@imap.xman.org>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 29 Jun 2001 01:26:29 -0700
To: "Dan Maas" <dmaas@dcine.com>, "John Fremlin" <vii@users.sourceforge.net>
From: Christopher Smith <x@xman.org>
Subject: Re: A signal fairy tale
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <00b101c0ffe2$fb77ad30$0701a8c0@morph>
In-Reply-To: <fa.d69j5vv.ej8irj@ifi.uio.no>
 <fa.h2rpibv.87m5bp@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:59 AM 6/28/2001 -0400, Dan Maas wrote:
>life-threatening things like SIGTERM, SIGKILL, and SIGSEGV. The mutation
>into queued, information-carrying siginfo signals just shows how badly we
>need a more robust event model... (what would truly kick butt is a unified
>interface that could deliver everything from fd events to AIO completions to
>semaphore/msgqueue events, etc, with explicit binding between event queues
>and threads).

I guess this is my thinking: it's really not that much of a stretch to make 
signals behave like GetMessage(). Indeed, sigopen() brings them 
sufficiently close. By doing this, you DO provide this unified interface 
for all the different types of events you described which works much like 
GetMessage(). So, but adding a couple of syscalls you avoid having to 
implement a whole new set of API's for doing AIO, semaphores, msgqueues, etc.

--Chris

P.S.: What do you mean by explicit binding between event queues and 
threads? I'm not sure I see what this gains you.

