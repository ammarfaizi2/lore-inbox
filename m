Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288655AbSAIAlc>; Tue, 8 Jan 2002 19:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288656AbSAIAlX>; Tue, 8 Jan 2002 19:41:23 -0500
Received: from zero.tech9.net ([209.61.188.187]:10249 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S288655AbSAIAlO>;
	Tue, 8 Jan 2002 19:41:14 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
From: Robert Love <rml@tech9.net>
To: John Alvord <jalvo@mbay.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1i3n3uct8fbh075ce99611tocgoe60oeqa@4ax.com>
In-Reply-To: <20020108173254.B9318@asooo.flowerfire.com>
	<E16O6KE-00087x-00@the-village.bc.nu> 
	<1i3n3uct8fbh075ce99611tocgoe60oeqa@4ax.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.18.08.57 (Preview Release)
Date: 08 Jan 2002 19:43:25 -0500
Message-Id: <1010537006.5340.206.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-01-08 at 19:29, John Alvord wrote:

> The best part about planned preemption points is that there is minimal
> state to save when an interruption occurs.

Actually, both preempt-kernel and low-latency do about the same amount
of work re saving state.

With preempt-kernel, when a task is preempted in-kernel we AND a flag
value into the preempt count.  That is all we need to keep track of
things.

With low-latency, the task state is set to TASK_RUNNING (which is a
precautionary measure).  So it is about the same, although low-latency
(and lock-break) often also have to do various setup with the locks and
all.

	Robert Love

