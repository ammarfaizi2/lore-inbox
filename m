Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280810AbRKUCh3>; Tue, 20 Nov 2001 21:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280813AbRKUChT>; Tue, 20 Nov 2001 21:37:19 -0500
Received: from davinci.artisan.calpoly.edu ([129.65.60.31]:36365 "EHLO
	davinci.artisan.calpoly.edu") by vger.kernel.org with ESMTP
	id <S280810AbRKUChK>; Tue, 20 Nov 2001 21:37:10 -0500
From: mroth@calpoly.edu
X-OpenMail-Hops: 1
Date: Tue, 20 Nov 2001 18:37:01 -0800
Message-Id: <H000060409379e23.1006310106.davinci.artisan.calpoly.edu@MHS>
Subject: Re: Spawning kernel threads from other kernel threads(?) 
MIME-Version: 1.0
TO: jjs@lexus.com
CC: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
	;Creation-Date="Tue, 20 Nov 2001 18:35:06 -0800"
	;Modification-Date="Tue, 20 Nov 2001 18:37:00 -0800"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>and BTW what is an "?entity?" ?

Oops. Excuse my ambiguity. When I said "entity" I was describing the design in
a very general form. Let me phrase it like this; my software in theory looks
like:

- a manager "entity" is responsible for destroying and creating "worker"
threads.
- the worker threads then perform a specific tasks.

That's theory though. The implementation actually looks like:

A linux kernel thread has the responsibility of creating and killing threads
(thus 
termed "manager").
The worker threads (also kernel threads) perform specific tasks.

>>2.4.3 is awfully stale for starters -

Yup. This is not by choice :-) The hardware/OS is pretty much fixed at this
point.

Would spawning a kernel thread from a kernel thread work with a recent kernel?

>>cu

>>jjs

> Question:
>         Can you spawn a kernel thread from another kernel thread? I want to
> have one manager ?entity? which will dynamically create kernel threads as
> needed. Right now, when I try to spawn another thread from the manager
 ?entity?
> [as of today, still a kernel thread] it will crash. Is this legal? If not,
 what
> is the alternative?
>
> kernel_thread()
> Kernel Version 2.4.3


