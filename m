Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758869AbWLCXTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758869AbWLCXTj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 18:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758881AbWLCXTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 18:19:39 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:39093 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1758869AbWLCXTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 18:19:38 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>,
       "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] introduce put_pid_rcu() to fix unsafe put_pid(vc->vt_pid)
References: <20061201234826.GA9511@oleg>
	<20061203130237.761bb15d.akpm@osdl.org> <20061203212926.GA428@oleg>
Date: Sun, 03 Dec 2006 16:18:24 -0700
In-Reply-To: <20061203212926.GA428@oleg> (Oleg Nesterov's message of "Mon, 4
	Dec 2006 00:29:26 +0300")
Message-ID: <m1psb0efgf.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> writes:

>> task_struct* or something?
>
> I don't think this is good. It was converted from task_struct* to pid*.
>
> Eric, what do you think?

I think I have a fix that uses the proper locking sitting in my queue that
I haven't pushed because I have been got to look at just about every
irq but present in 2.6.19-rcX.  Then for some reason I had this stupid
usb debug cable sitting on my desk and since I can't stand useful
things going unused I just wrote a driver for that :)

Anyway with a little luck I should be working on the pid namespace and
this stuff later today so I will try and send out the proper patch.

Not that I'm really opposed to this infrastructure but I'd like to
avoid it until we really need it.

Eric

