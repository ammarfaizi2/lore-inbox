Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264558AbTK0Qq3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 11:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264561AbTK0Qq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 11:46:29 -0500
Received: from 5.86.35.65.cfl.rr.com ([65.35.86.5]:14210 "EHLO
	drunkencodepoets.com") by vger.kernel.org with ESMTP
	id S264558AbTK0Qq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 11:46:28 -0500
Date: Thu, 27 Nov 2003 11:46:31 -0500
From: Pat Erley <paterley@mail.drunkencodepoets.com>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] trivial change in kernel/sched.c in 2.6.0-test9+
Message-Id: <20031127114631.06f71eb7.paterley@mail.drunkencodepoets.com>
In-Reply-To: <20031126110250.GB27967@actcom.co.il>
References: <20031126002713.1f8707f8.paterley@mail.drunkencodepoets.com>
	<20031126055556.GC3734@actcom.co.il>
	<20031126010701.25600adb.s0be@mail.drunkencodepoets.com>
	<20031126110250.GB27967@actcom.co.il>
Organization: drunkencodepoets.com
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > If you can suggest a way to test this, I will test it on my system 
> > tomorrow.
> 
> Just off the top of my head, you could try something like a kernel
> compilation with and without it. I doubt you'll see any improvement,
> though.. there are very few places in the kernel where such
> micro-optimizations are worth it, IMVHO. 


Well, I ran about 6 different compiles each on a patched and an unpatched,
and my 'average' savings were about 1 second per 6 minute compile, which is
negligible.  I wonder if doing a make is a good test of this.  Can anyone else
out there come up with another way to check this with a non-cpu hog
application?  I'd like some other cases to test this in.  I mean, when you do 
a 'large' number of compiles that each take a half second, I can see
that saving a division and an addition really wouldn't make a big difference,
but in a situation where you have a large number of short lived threads in
a child process, it may end up saving a bit more.

Pat Erley
