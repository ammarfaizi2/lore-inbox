Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316204AbSGQRyx>; Wed, 17 Jul 2002 13:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316210AbSGQRyx>; Wed, 17 Jul 2002 13:54:53 -0400
Received: from mx1.elte.hu ([157.181.1.137]:37558 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S316204AbSGQRyw>;
	Wed, 17 Jul 2002 13:54:52 -0400
Date: Thu, 18 Jul 2002 19:56:48 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: shreenivasa H V <shreenihv@usa.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Re: Gang Scheduling in linux]
In-Reply-To: <20020717172429.16682.qmail@uadvg137.cms.usa.net>
Message-ID: <Pine.LNX.4.44.0207181949480.761-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the most simple form of gang scheduling is in fact possible on Linux: if
the number-crunching job is running on the system (almost) exclusively. In
this case the jobs get distributed amongst CPUs, each CPU runs at most one
task which can 'gang up' as much as they want.

it's not possible at the moment to define a given group of processes to
form a 'gang' and be scheduled on/off simultaneously. This has
significance only if the system is running multiple, unrelated 'gangs'.

if needed then it's possible to implement gang scheduling in userspace:  
groups of processes can be bound to individual CPUs and can be forced
on/off the CPU at a periodic interval. Doing this in the scheduler looks
too complex at first sight - and probably the scheduler would do a poorer
job than userspace-based manual affinities plus forced group-suspension
achieves.

	Ingo

