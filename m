Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264894AbTK3Mab (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 07:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264896AbTK3Mab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 07:30:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:38622 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264894AbTK3Ma3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 07:30:29 -0500
Date: Sun, 30 Nov 2003 13:30:28 +0100 (MET)
From: "john smith" <john.smith77@gmx.net>
To: "Linux Kernel Mailinglist" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Subject: Kernel modul licensing issues
X-Priority: 3 (Normal)
X-Authenticated: #21322809
Message-ID: <19703.1070195428@www59.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks

I have some licensing issues with the linux GPL and the implications
on a project which incorporates partial non-GPL code which I want
to release as linux kernel module.

I am well aware that there are many threads concerning binary only
and non-GPL kernel modules but I cannot deduce a clear statement
for my specific case from what I have already read. That's why I
kindly ask you about your interpretation of the GPL in the following
case.

I have implemented a proprietary algorithm in user space which I'm not
allowed to release under the GPL. From a _technical_ point of view I
could compile the code as kernel module which offers a certain API.
Note that the kernel module would have only very limited dependency
on the kernel, i.e. apart from memory allocation functions (kmalloc,
kfree, vmalloc, vfree) and potentially some "locks" (spinlock, big
reader lock or rcu) the code is totally independent from the kernel.
In particular it is not required to apply any patches against the
kernel sources.

 From what I have read I'd conclude that it is ok to release such a
kernel module under a non-GPL license since it can hardly be considered
derived work and of course otherwise proprietary drivers also could
not be released as non-GPL kernel modules.

Well, the story continues. Assuming that having the algorithm
implemented as non-GPL kernel module I want to implement a front-end
which makes use of the algorithm's API and release this code under
GPL. The frontend would have some more dependencies on the kernel
code compared to the algorithm module (though I'd still consider
it "edge" code) and it might involve small additions to existing
kernel files (3 or 4 small functions maybe).

As far as the interaction with the algorithm API is concerned the
frontend submits kernel data structures to the algorithm module _but_ 
since the algorithm has no declaration of kernel structures it does
neither use nor modify the kernel data. It's just stored and returned
to the user via certain API functions.

So, given this scenario is it ok that the GPL frontend uses the non-GPL
algorithm API without the requirement of making the algorithm GPL too?

Thank you very much for your help.

John

-- 
Neu bei GMX: Preissenkung für MMS-Versand und FreeMMS!

Ideal für alle, die gerne MMS verschicken:
25 FreeMMS/Monat mit GMX TopMail.
http://www.gmx.net/de/cgi/produktemail

+++ GMX - die erste Adresse für Mail, Message, More! +++

