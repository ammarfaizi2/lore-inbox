Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263645AbTETIzc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 04:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263646AbTETIzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 04:55:32 -0400
Received: from mx1.elte.hu ([157.181.1.137]:59580 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id S263645AbTETIzb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 04:55:31 -0400
Date: Tue, 20 May 2003 11:03:36 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Christoph Hellwig <hch@infradead.org>, Ulrich Drepper <drepper@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] futex requeueing feature, futex-requeue-2.5.69-D3 
In-Reply-To: <20030520085911.90EE72C232@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0305201100390.6448-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 20 May 2003, Rusty Russell wrote:

> > Actually it should go away before 2.6.0.  sys_futex never was part of a
> > released stable kernel so having the old_ version around is silly.
> 
> Hmm, in that case I'd say "just break it", and I'd be all in favour of
> demuxing the syscall.

have you all gone nuts??? It's not an option to break perfectly working
binaries out there. Hell, we didnt even reorder the new NPTL
syscalls/extensions 1-2 kernel releases after the fact. Please grow up!

the interface should have been gotten right initially. We are all guilty
of it - now lets face the consequences. It's only a couple of lines of
code in a well isolated place of the file so i dont know what the fuss is
about. I havent even added FUTEX_REQUEUE to the old API.

> But I think vendors have backported and released futexes, which is why
> Ingo did this...

of course. And which brought the productization of futexes in the first
place.

	Ingo

