Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267065AbTBDAtw>; Mon, 3 Feb 2003 19:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267076AbTBDAtw>; Mon, 3 Feb 2003 19:49:52 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:13074
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S267065AbTBDAtv>; Mon, 3 Feb 2003 19:49:51 -0500
Subject: Re: Kernel Threads question on 2.4
From: Robert Love <rml@tech9.net>
To: Akram.Abou-Emara@nokia.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <F0B628F30F48064289D8CCC1EE21B7A8026B2335@mvebe001.americas.nokia.com>
References: <F0B628F30F48064289D8CCC1EE21B7A8026B2335@mvebe001.americas.nokia.com>
Content-Type: text/plain
Organization: 
Message-Id: <1044320369.783.117.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 03 Feb 2003 19:59:30 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-03 at 19:52, Akram.Abou-Emara@nokia.com wrote:

These questions might be better asked on the kernelnewbies list...

> Do kernel threads get preempted? Or do they have to
> give up the CPU on their own? 

Without the preemptive kernel, they are not preemptive.  With
preempt-kernel, they are.  They tend to run at elevated priorities
anyhow, so this is not so much of an issue.

> Are there any rules for what scheduling policies and
> priority a kernel thread can have?
> reparent_to_init()sets the scheduling policy to
> SCHED_OTHER. Do you see a problem with changing the
> scheduling policy to  SCHED_FIFO?

kernel threads can have any scheduling policy or priority - they really
do not differ much from regular threads (sans the lack of address
space).

Some kernel threads do indeed run with real-time policy.

	Robert Love

