Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261423AbSJYOJ2>; Fri, 25 Oct 2002 10:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261430AbSJYOJ1>; Fri, 25 Oct 2002 10:09:27 -0400
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:25496 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S261423AbSJYOJ1>; Fri, 25 Oct 2002 10:09:27 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: Mark Mielke <mark@mark.mielke.cc>
Subject: Re: Use of yield() in the kernel
Date: Fri, 25 Oct 2002 16:15:24 +0200
User-Agent: KMail/1.4.7
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@digeo.com>
References: <200210151536.39029.baldrick@wanadoo.fr> <200210201110.33254.baldrick@wanadoo.fr> <20021022172404.GB1314@mark.mielke.cc>
In-Reply-To: <20021022172404.GB1314@mark.mielke.cc>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200210251615.25620.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is my current understanding of some different ways to schedule:

(1) Yield to a higher priority task (if there is one):
	cond_resched();

(2) Yield to the next task (if there is another one):
	set_current_state(TASK_RUNNING);
	schedule();

(3) Yield to all tasks:
	yield();

Notes:
(1) Also yields if the current task's time quantum has expired.
(3) Only guaranteed to yield to all tasks on the active list.

Corrections?

Duncan.
