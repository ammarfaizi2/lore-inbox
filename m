Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268997AbRH0VSm>; Mon, 27 Aug 2001 17:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269041AbRH0VSc>; Mon, 27 Aug 2001 17:18:32 -0400
Received: from barry.mail.mindspring.net ([207.69.200.25]:31548 "EHLO
	barry.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S268997AbRH0VSY>; Mon, 27 Aug 2001 17:18:24 -0400
Subject: Re: Updated Linux kernel preemption patches
From: Robert Love <rml@tech9.net>
To: Linux kernel <linux-kernel@vger.kernel.org>
Cc: J Sloan <jjs@toyota.com>, Cliff Albert <cliff@oisec.net>
In-Reply-To: <998941465.1993.9.camel@phantasy>
In-Reply-To: <998877465.801.19.camel@phantasy>
	<20010827093835.A15153@oisec.net>  <3B8AA02D.6F7561AB@lexus.com> 
	<998941465.1993.9.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99+cvs.2001.08.21.23.41 (Preview Release)
Date: 27 Aug 2001 17:18:57 -0400
Message-Id: <998947154.11860.30.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ahhh I think I got it. nevermind the bit about CONFIG_PREEMPT not being
set, that is not it (as I am sure you all know).

The problem is that dec_and_lock.c is not being compiled (or at least
the object isnt being included).  I believe this is caused by having bad
dependencies.  My .depend has a dependency to compile the object -- I
wager your's does not.

So... did you rerun `make dep' ?

If not, try a fresh kernel tree and make sure to do `make oldconfig dep
clean' after patching.

Please let me know because I am trying to track this down, and I don't
have it happening to me.  I think this should do it.

Of note, I will release a patch against 2.4.9-ac2 and 2.4.10-pre1 soon.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

