Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261437AbVAGOk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbVAGOk7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 09:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbVAGOk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 09:40:59 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:24267 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S261437AbVAGOir
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 09:38:47 -0500
Message-Id: <200501071438.j07EccJ0018170@localhost.localdomain>
To: Arjan van de Ven <arjanv@redhat.com>
cc: Christoph Hellwig <hch@infradead.org>, Lee Revell <rlrevell@joe-job.com>,
       Ingo Molnar <mingo@elte.hu>, Chris Wright <chrisw@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, "Jack O'Quin" <joq@io.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM 
In-reply-to: Your message of "Fri, 07 Jan 2005 15:26:37 +0100."
             <20050107142637.GB20398@devserv.devel.redhat.com> 
Date: Fri, 07 Jan 2005 09:38:38 -0500
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [151.197.185.179] at Fri, 7 Jan 2005 08:38:40 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> rlimit_memlock limits the *amount* of memory that mlock() can be used
>> on, not whether mlock can be used. at least, thats my understanding of
>> the POSIX design for this. the man page and the source code for mlock
>> support make that reasonably clear.
>
>eh no. It defaults to zero, but if you increase it for a specific user, that
>user is allowed to mlock more.

from mm/mlock.c:do_mlock() in 2.6.8:

	if (on && !capable(CAP_IPC_LOCK))
		return -EPERM;

i.e. only root or capabilities can make mlock() usable.

>much). If you are unwilling to even discuss fixing the underlying design
>issues then I'm scared that this issue will never come to any workable
>solution.

Lee, Jack and I have been very willing to discuss the issue. Christoph
isn't willing to discuss it, he's just told us "its the wrong design,
and I'm not telling you why or what's better". If there is a better
design that will end up in the mainstream kernel, we'd love to see it
implemented, and will likely be involved in doing it, because its
really important to us.

--p

