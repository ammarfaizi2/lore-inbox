Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315417AbSGACxC>; Sun, 30 Jun 2002 22:53:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315419AbSGACxB>; Sun, 30 Jun 2002 22:53:01 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:59880 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S315417AbSGACw7>; Sun, 30 Jun 2002 22:52:59 -0400
Subject: Re: [announce] [patch] batch/idle priority scheduling, SCHED_BATCH
From: Nicholas Miell <nmiell@attbi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0207010122580.11969-300000@e2>
References: <Pine.LNX.4.44.0207010122580.11969-300000@e2>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 30 Jun 2002 19:55:18 -0700
Message-Id: <1025492120.12685.8.camel@entropy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-06-30 at 17:26, Ingo Molnar wrote:

> -#define SCHED_OTHER		0
> +#define SCHED_NORMAL		0

>From IEEE 1003.1-2001 / Open Group Base Spec. Issue 6:
"Conforming implementations shall include one scheduling policy
identified as SCHED_OTHER (which may execute identically with either the
FIFO or round robin scheduling policy)."

So, you probably want to add a "#define SCHED_OTHER SCHED_NORMAL" here
in order to prevent future confusion, especially because the user-space
headers have SCHED_OTHER, but no SCHED_NORMAL.

- Nicholas

