Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbWCHTg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWCHTg2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 14:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbWCHTg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 14:36:28 -0500
Received: from smtp3.Stanford.EDU ([171.67.16.138]:11705 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S932123AbWCHTg1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 14:36:27 -0500
Subject: 2.6.15-rt20, "bad page state", jackd
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: nando@ccrma.Stanford.EDU
Content-Type: text/plain
Date: Wed, 08 Mar 2006 11:36:04 -0800
Message-Id: <1141846564.5262.20.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, I reported this in mid January (I thought I had sent to the list
but the report went to Ingo and Steven off list)

I'm seeing the same problem in 2.6.15-rt21 in some of my machines. After
a reboot into the kernel I just login as root in a terminal, start the
jackd sound server ("jackd -d alsa -d hw") and when stopping it (just
doing a <ctrl>c) I get a bunch of messages of this form:

> Trying to fix it up, but a reboot is needed
> Bad page state at __free_pages_ok (in process 'jackd', page c10012fc)

Has anyone else seen this?

I'm in the process of building an -rt21 kernel before posting more
detailed error messages (this kernel is patched with some additional
stuff). 

Ingo had suggested at the time I enable DEBUG_PAGEALLOC and DEBUG_SLAB
to get more information (Jan 21 or so), I was never able to get the
machine to boot into that kernel, I kept getting oopses. Weird, I'm
trying to find the post I sent to lkml (I have it in my mailbox) in the
lkml archives to include a link and can't find it...

More details later...
-- Fernando


