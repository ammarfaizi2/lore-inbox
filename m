Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315370AbSGAGq2>; Mon, 1 Jul 2002 02:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315375AbSGAGq1>; Mon, 1 Jul 2002 02:46:27 -0400
Received: from ns.suse.de ([213.95.15.193]:28676 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S315370AbSGAGq0>;
	Mon, 1 Jul 2002 02:46:26 -0400
To: Nicholas Miell <nmiell@attbi.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [announce] [patch] batch/idle priority scheduling, SCHED_BATCH
References: <Pine.LNX.4.44.0207010122580.11969-300000@e2>
	<1025492120.12685.8.camel@entropy>
From: Andreas Jaeger <aj@suse.de>
Date: Mon, 01 Jul 2002 08:48:51 +0200
In-Reply-To: <1025492120.12685.8.camel@entropy> (Nicholas Miell's message of
 "30 Jun 2002 19:55:18 -0700")
Message-ID: <ho1yaodju4.fsf@gee.suse.de>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) XEmacs/21.4 (Artificial
 Intelligence, i386-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Miell <nmiell@attbi.com> writes:

> On Sun, 2002-06-30 at 17:26, Ingo Molnar wrote:
>
>> -#define SCHED_OTHER		0
>> +#define SCHED_NORMAL		0
>
>>From IEEE 1003.1-2001 / Open Group Base Spec. Issue 6:
> "Conforming implementations shall include one scheduling policy
> identified as SCHED_OTHER (which may execute identically with either the
> FIFO or round robin scheduling policy)."
>
> So, you probably want to add a "#define SCHED_OTHER SCHED_NORMAL" here
> in order to prevent future confusion, especially because the user-space
> headers have SCHED_OTHER, but no SCHED_NORMAL.

This can be done in glibc.  linux/sched.h should not be used by
userspace applications, glibc has the define in <bits/sched.h> which
is included from <sched.h> - and <sched.h> is the file defined by
Posix.

Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
