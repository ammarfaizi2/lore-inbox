Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263971AbTKZGHB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 01:07:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263980AbTKZGHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 01:07:01 -0500
Received: from 5.86.35.65.cfl.rr.com ([65.35.86.5]:34433 "EHLO
	drunkencodepoets.com") by vger.kernel.org with ESMTP
	id S263971AbTKZGG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 01:06:59 -0500
Date: Wed, 26 Nov 2003 01:07:01 -0500
From: s0be <s0be@mail.drunkencodepoets.com>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] trivial change in kernel/sched.c in 2.6.0-test9+
Message-Id: <20031126010701.25600adb.s0be@mail.drunkencodepoets.com>
In-Reply-To: <20031126055556.GC3734@actcom.co.il>
References: <20031126002713.1f8707f8.paterley@mail.drunkencodepoets.com>
	<20031126055556.GC3734@actcom.co.il>
Organization: drunkencodepoets.com
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > this ends up saving a few math operations any time a child
> > process exits. ( calling sched_exit(task_t * p) )
> 
> Yes, but does it have any noticeable effect on performance whatsoever?
> premature optimization, root of all evil, etc. 

I'm not on a system that I can take down long enough/crash testing 
right now that I could check this.  And, to be honest, I can't think
of anything other than a fork bomb that would do a good job of testing 
this.  I just remembered helping con with O(3)int schedular hacks and 
he seemed concerned with how many math operations take place in sched.c
due to it being in the core.  

If you can suggest a way to test this, I will test it on my system 
tomorrow.

Pat Erley
