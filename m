Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263858AbTFDTAL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 15:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263859AbTFDTAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 15:00:11 -0400
Received: from pfaff1.Stanford.EDU ([128.12.189.154]:33161 "EHLO
	pfaff.Stanford.EDU") by vger.kernel.org with ESMTP id S263858AbTFDTAK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 15:00:10 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.5] Non-blocking write can block
References: <20030604172026$296c@gated-at.bofh.it>
	<20030604175013$3a4d@gated-at.bofh.it>
Reply-To: blp@cs.stanford.edu
From: Ben Pfaff <blp@cs.stanford.edu>
Date: 04 Jun 2003 12:13:37 -0700
In-Reply-To: <20030604175013$3a4d@gated-at.bofh.it>
Message-ID: <87smqp8xlq.fsf@pfaff.Stanford.EDU>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On Wed, 4 Jun 2003, Hua Zhong wrote:
> >
> > We ran into this problem here in an embedded environment. It causes
> > syslogd to hang and when this happens, everybody who talks to syslogd
> > hangs. Which means you may not even be able to login. In the end we used
> > exactly the same fix which seems to work.
> > 
> > I am curious to know the correct fix.
> 
> [ First off: your embedded syslog problem is fixed by making sure that
>   syslog doesn't try to write to a tty that somebody else might be
>   blocked. In other words, to me it sounds like a "well, don't do that
>   then" schenario, rather than a real kernel problem. ]

One day I managed to keep myself from logging in or su'ing or
doing a number of things that needed the log for a quite a while
by accidentally hitting Scroll Lock on a console that syslog was
set up to log to.  I suppose the answer is "don't do that" but it
was a mysterious problem for several minutes that day.
-- 
"Let others praise ancient times; I am glad I was born in these."
--Ovid (43 BC-18 AD)
