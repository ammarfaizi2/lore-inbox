Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbTJHDAN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 23:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbTJHDAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 23:00:13 -0400
Received: from mail.inter-page.com ([12.5.23.93]:2826 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S261346AbTJHDAI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 23:00:08 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "'David Lang'" <david.lang@digitalinsight.com>
Cc: "'Linus Torvalds'" <torvalds@osdl.org>,
       "'Albert Cahalan'" <albert@users.sourceforge.net>,
       "'Ulrich Drepper'" <drepper@redhat.com>,
       "'Mikael Pettersson'" <mikpe@csd.uu.se>,
       "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: Who changed /proc/<pid>/ in 2.6.0-test5-bk9?
Date: Tue, 7 Oct 2003 19:59:18 -0700
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAG15dxRiudEualTNpHNYqMgEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
In-Reply-To: <Pine.LNX.4.58.0310071931570.19619@dlang.diginsite.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, the point I am trying to _make_ is that Linux allows you to share
or not share each item (already) but making a coherent "thread" implies a
unity of interface over the entities.  We already have VM and Signals in
that unity, but not file descriptors.  I think that's bad.  Since the old
way lets me have this 2/3-of-a-thread already.  When I ask for a thread I
should get a thread, not just a composite of otherwise identical shareable
options.

After all, if I deliver SIGPIPE to a "process" and it gets serviced by one
of the "theads" how does the "thread" know the file descriptor in the signal
is from its own file descriptor table?  If the signals are only going to the
specific member threads and, in fact NOT to the "process", then how is the
sharing of signal context anything more than a renaming of what is already
there as of 2.2?

If CLONE_THREAD exists solely to reproduce the existing
(CLONE_VM|CLONE_SIGHAND[|CLONE_whatever]) functionality, why did anybody
bother doing more than a #define?

Presumably CLONE_THREAD is supposed to make a LWP (in the classic sense)
that runs with view of the kernel that is consistent with all its peer LWPs.
If not, it is going to surprise a heck of a lot of (posix AND non posix)
thread programmers worldwide.  "They ought to know better" has merit, but
that merit is equal to "they might as well use the old stuff".

Rob.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of David Lang
Sent: Tuesday, October 07, 2003 7:39 PM
To: Robert White
Cc: 'Linus Torvalds'; 'Albert Cahalan'; 'Ulrich Drepper'; 'Mikael
Pettersson'; 'Kernel Mailing List'
Subject: RE: Who changed /proc/<pid>/ in 2.6.0-test5-bk9?

Robert, you are missing the point. Linux allows you to share or not share
each item.
.


