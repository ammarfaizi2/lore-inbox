Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263321AbTBXMc0>; Mon, 24 Feb 2003 07:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264706AbTBXMc0>; Mon, 24 Feb 2003 07:32:26 -0500
Received: from mx1.elte.hu ([157.181.1.137]:44726 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S263321AbTBXMcZ>;
	Mon, 24 Feb 2003 07:32:25 -0500
Date: Mon, 24 Feb 2003 13:41:08 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: procps-list@redhat.com
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       <alexl@redhat.com>, Alexander Viro <viro@math.psu.edu>
Subject: Re: [patch] procfs/procps threading performance speedup, 2.5.62
In-Reply-To: <200302241229.h1OCTRF331287@saturn.cs.uml.edu>
Message-ID: <Pine.LNX.4.44.0302241333140.26508-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 24 Feb 2003, Albert D. Cahalan wrote:

> It's fine to mix up thread order, but bad to interleave the threads of
> unrelated processes.

this is very simple to do, and does not necessiate thread-directories.  
There's a PID and TGid field in /proc/PID/status. Just link the task to
the TGid-task, and you have instant access to all threads per TGid. In the
'groupped output' case you have to scan & access all threads anyway. Ok?

(but this is way offtopic. The changes we posted address the normal case
of process-listing. (no -m option.) If there are tons of threads around
then any discussed variant of 'ps -m' will be slow.)

	Ingo

