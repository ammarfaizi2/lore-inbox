Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbTESROy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 13:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262390AbTESROy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 13:14:54 -0400
Received: from smtp03.uc3m.es ([163.117.136.123]:42253 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id S261960AbTESROx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 13:14:53 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200305191727.h4JHRih00517@oboe.it.uc3m.es>
Subject: Re: recursive spinlocks. Shoot.
In-Reply-To: <Pine.LNX.4.55.0305190957520.4379@bigblue.dev.mcafeelabs.com> from
 Davide Libenzi at "May 19, 2003 10:15:54 am"
To: Davide Libenzi <davidel@xmailserver.org>
Date: Mon, 19 May 2003 19:27:44 +0200 (MET DST)
Cc: "Peter T. Breuer" <ptb@it.uc3m.es>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > (1) while, with some luck, writing may be atomic on ia32 (and I'm not
> > sure it is, I'm only prepared to guarantee it for the lower bits, and I
> > really don't know about zeroing the carry and so on), I actually doubt
> > that reading is atomic, or we wouldn't need the atomic_read
> > construction!
> 
> Look at atomic read :
> 
> $ emacs `find /usr/src/linux/include -name atomic.h | xargs`

:-). Well, whaddya know. Both read and write of a int (declared
volatile) are atomic on ia32. 

> > (3) even if one gets either one or the other answer, one of them would
> > be the wrong answer, and you clearly intend the atomic_inc of the
> > counter to be done in the same atomic region as the setting to current,
> > which would be a programming hypothesis that is broken when the wrong
> > answer comes up.

[snip atomicity of read/write]

> being "a" an aligned memory location, a third thread reading "a" reads
> either 1 or -1. Going back to the (doubtfully useful) code, you still have
> to point out were it does bang ...

OK. I'll have a look later.

Peter
