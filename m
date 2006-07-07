Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbWGGHDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbWGGHDg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 03:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbWGGHDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 03:03:36 -0400
Received: from mail.gmx.net ([213.165.64.21]:12510 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751240AbWGGHDf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 03:03:35 -0400
Cc: manfred@colorfullife.com, linux-kernel@vger.kernel.org, tytso@mit.edu,
       torvalds@osdl.org, eggert@cs.ucla.edu, roland@redhat.com,
       rlove@rlove.org, mtk-lkml@gmx.net, mtk-manpages@gmx.net
Content-Type: text/plain; charset="utf-8"
Date: Fri, 07 Jul 2006 09:03:34 +0200
From: "Michael Kerrisk" <michael.kerrisk@gmx.net>
In-Reply-To: <44ADFD43.4040204@redhat.com>
Message-ID: <20060707070334.186790@gmx.net>
MIME-Version: 1.0
References: <44A92DC8.9000401@gmx.net> <44AABB31.8060605@colorfullife.com>
 <20060706092328.320300@gmx.net> <44AD599D.70803@colorfullife.com>
 <44AD5CB6.7000607@redhat.com> <20060707043220.186800@gmx.net>
 <44ADE9B6.1020900@redhat.com> <20060707050731.186770@gmx.net>
 <44ADFD43.4040204@redhat.com>
Subject: Re: Strange Linux behaviour with blocking syscalls and stop
 signals+SIGCONT
To: Ulrich Drepper <drepper@redhat.com>
X-Authenticated: #2864774
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Von: Ulrich Drepper <drepper@redhat.com>

> > Changing EINTR
> > to ERESTARTSYS is likely to have more impact on userland (though 
> > it still strikes me as a desirable gola to have all system calls 
> > restartable via SA_RESTART).
> 
> This is certainly a nice goal but it changes the current ABI.  

Yes, it does.

> Therefore
> it cannot be anything but an option and I don't assume we want to add so
> much cruft for just this.

There must be some framework for changing the kernel ABI over time.
We can't remain forever stuck with an ABI behaviour because 
of the development model (i.e., no 2.7/2.8).  And it probably
would not be that much code change to achieve the result?

Cheers,

Michael
-- 


"Feel free" – 10 GB Mailbox, 100 FreeSMS/Monat ...
Jetzt GMX TopMail testen: http://www.gmx.net/de/go/topmail
