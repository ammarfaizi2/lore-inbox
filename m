Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262898AbTCQGIt>; Mon, 17 Mar 2003 01:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262900AbTCQGIt>; Mon, 17 Mar 2003 01:08:49 -0500
Received: from mx2.elte.hu ([157.181.151.9]:62123 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S262898AbTCQGIs>;
	Mon, 17 Mar 2003 01:08:48 -0500
Date: Mon, 17 Mar 2003 07:19:21 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] O(1) proc_pid_readdir
In-Reply-To: <3E74EB92.7010801@colorfullife.com>
Message-ID: <Pine.LNX.4.44.0303170716350.15476-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 16 Mar 2003, Manfred Spraul wrote:

> > have you seen my "procfs/procps threading performance speedup" patch? 
> > It does something like this.

> Interesting patch. Do seekdir and telldir still work? I think you must
> detect lseek calls and invalidate the cookie - either by hooking lseek
> or by looking at f_version.

it's trivial to do this, and nothing /proc based uses seekdir/telldir
anyway.

	Ingo


