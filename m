Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264614AbTEaS2k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 14:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264624AbTEaS2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 14:28:40 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:16708 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264614AbTEaS2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 14:28:37 -0400
Date: Sat, 31 May 2003 11:42:08 -0700
From: Andrew Morton <akpm@digeo.com>
To: Michael Buesch <fsdeveloper@yahoo.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pdflush -> noflushd related question
Message-Id: <20030531114208.35b62972.akpm@digeo.com>
In-Reply-To: <200305312036.55506.fsdeveloper@yahoo.de>
References: <200305311841.59599.fsdeveloper@yahoo.de>
	<20030531105850.7cc92601.akpm@digeo.com>
	<200305312036.55506.fsdeveloper@yahoo.de>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 May 2003 18:41:56.0927 (UTC) FILETIME=[5025A4F0:01C327A4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Buesch <fsdeveloper@yahoo.de> wrote:
>
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Saturday 31 May 2003 19:58, Andrew Morton wrote:
> > You can turn these guys off by setting the sysctls to 1000000000
> > I guess.   Problem is, I don't think there's a way of starting them
> > again until the ten million seconds expires.  hmm.
> 
> I've thought a little bit more about it.
> Why do you think, there is no way of waking up?
> Is it, because, when I set it to 1000000000 and the back to,
> let's say, 500, the pdflush threads don't wake up to recognize
> this change? Is this the cause?

Yes.

> What about signaling all pdflush threads with, for example,
> for(ALL_PDFLUSHS)
> 	kill(pid, SIGSTOP);
> 
> Don't they wake up then and recognize the reducing of the timeout?
> The old noflushd did so to wake up updated.

No, that's OK - I'll fix it in the kernel.  It's pretty simple.


