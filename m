Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261173AbSJLM6G>; Sat, 12 Oct 2002 08:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261177AbSJLM6G>; Sat, 12 Oct 2002 08:58:06 -0400
Received: from [192.67.198.71] ([192.67.198.71]:42665 "EHLO
	mout00-12.webmailer.de") by vger.kernel.org with ESMTP
	id <S261173AbSJLM6F>; Sat, 12 Oct 2002 08:58:05 -0400
Content-Type: text/plain; charset=US-ASCII
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
To: Tim Schmielau <tim@physik3.uni-rostock.de>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] tasks.h
Date: Sat, 12 Oct 2002 17:03:11 +0200
User-Agent: KMail/1.4.3
Cc: John Levon <levon@movementarian.org>
References: <Pine.LNX.4.33.0210120842070.25918-100000@gans.physik3.uni-rostock.de>
In-Reply-To: <Pine.LNX.4.33.0210120842070.25918-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210121703.11220.arnd@bergmann-dalldorf.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 12 October 2002 08:59, Tim Schmielau wrote:

> More work will be neccessary to completely disentangle both files, so that
> sched.h doesn't need to include tasks.h. Biggest obstacle is get_task_mm()
> which needs both task_struct and mm_struct. Maybe I'll break out something
> like a <linux/task_mm.h> later.

AFAICS, get_task_mm() is never used in a fast path, only in
ptrace and procfs code where a few cpu cycles don't hurt anyone.
Any reason why you can't just make it an extern function?

	Arnd <><
