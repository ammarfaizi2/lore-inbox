Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266953AbTBXMfs>; Mon, 24 Feb 2003 07:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266978AbTBXMfr>; Mon, 24 Feb 2003 07:35:47 -0500
Received: from mx2.elte.hu ([157.181.151.9]:49336 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S266953AbTBXMfr>;
	Mon, 24 Feb 2003 07:35:47 -0500
Date: Mon, 24 Feb 2003 13:45:48 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: procps-list@redhat.com, Linus Torvalds <torvalds@transmeta.com>,
       <linux-kernel@vger.kernel.org>, <alexl@redhat.com>, <viro@math.psu.edu>
Subject: Re: [patch] procfs/procps threading performance speedup, 2.5.62
In-Reply-To: <200302241229.h1OCTRF331287@saturn.cs.uml.edu>
Message-ID: <Pine.LNX.4.44.0302241341240.26626-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 24 Feb 2003, Albert D. Cahalan wrote:

> Sorting is not default because of the memory requirements and because
> there have been many kernel bugs that cause ps to hang when it hits a
> particular process. Sorting may mean that ps hangs or is killed before
> producing anything.

in fact there was an unconditional qsort() done after scanning all tasks,
until i pointed it out to Alex. It never caused any problems, and sorting
never showed up as a source of overhead in the profiler, so i'm not sure
why you insist on sorting so much.

if procps hangs then that's a bug in procps. I'm not quite sure what you
mean by 'it hits a particular process'.

	Ingo

