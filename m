Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264925AbTCCOfD>; Mon, 3 Mar 2003 09:35:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265135AbTCCOfC>; Mon, 3 Mar 2003 09:35:02 -0500
Received: from hellcat.admin.navo.hpc.mil ([204.222.179.34]:64709 "EHLO
	hellcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S264925AbTCCOfC> convert rfc822-to-8bit; Mon, 3 Mar 2003 09:35:02 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: Dan Kegel <dank@kegel.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Protecting processes from the OOM killer
Date: Mon, 3 Mar 2003 08:45:00 -0600
User-Agent: KMail/1.4.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3E5EB9A8.3010807@kegel.com> <1046439618.16599.22.camel@irongate.swansea.linux.org.uk> <3E5F8985.60606@kegel.com>
In-Reply-To: <3E5F8985.60606@kegel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200303030845.00097.pollard@admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 February 2003 10:08 am, Dan Kegel wrote:
> Alan Cox wrote:
snip
> > Everything else is armwaving "works half the time" stuff. By the time
> > the OOM kicks in the game is already over.
>
> Even with overcommit disallowed, the OOM killer is going to run
> when my users try to run too big a job, so I would still like
> the OOM killer to behave "well".

Shouldn't - the process the user tries to run will not be started since
it must reserve the space first. malloc will fail immediately, allowing the
process to handle the even gracefully and exit.

Anything else is a bug in the application.

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
