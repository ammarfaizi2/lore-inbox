Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262023AbVCUW1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbVCUW1m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 17:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261977AbVCUW1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 17:27:42 -0500
Received: from fire.osdl.org ([65.172.181.4]:24516 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262060AbVCUWZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 17:25:52 -0500
Date: Mon, 21 Mar 2005 14:25:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: george@galis.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: problem with linux 2.6.11 and sa
Message-Id: <20050321142555.47b1e5a1.akpm@osdl.org>
In-Reply-To: <20050303173459.GC952@ixeon.local>
References: <20050303173459.GC952@ixeon.local>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"George Georgalis" <george@galis.org> wrote:
>
> I'm very defiantly seeing a problem with the 2.6.11
> kernel and my spamassassin setup. However, it's not
> clear exactly where the problem is, seems like sa
> but it might be 2.6.11 with daemontools + qmail +
> QMAIL_QUEUE.
> 
> A sure sign of it is no logs (with debug) for
> remote sa connections which score "0/0" and correct
> operation with local "cat spam.txt | spamc -R"; fix
> is to use the older kernel.
> 
> SA has stopped stdout logging completely with 2.6.11
> in addition to the all pass score. But the message
> seems to go through my temp queue (for testing) and
> sent on to my local MDA. I'm not sure if it's a sa
> problem with the kernel or the new kernel doing
> something new with pipes from tcp connections.
> Maybe the new kernel is not making files available
> (eg 0 bytes), until the writing pipe is closed?
> That would make my SA test a zero byte file, which
> would pass, close, become full, and the file piped
> to local MDA is full? ...humm then I'd get a score
> of "0/5"... this sounds like a SA problem with the
> new kernel, ideas?

George, did you end up getting to the bottom of this?  I'd be suspecting a
bug in the new pipe code, or an application bug which was triggered by the
new pipe code.
