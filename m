Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262145AbSJAQXN>; Tue, 1 Oct 2002 12:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262144AbSJAQXM>; Tue, 1 Oct 2002 12:23:12 -0400
Received: from [66.70.28.20] ([66.70.28.20]:16133 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S262134AbSJAQXH>; Tue, 1 Oct 2002 12:23:07 -0400
Date: Tue, 1 Oct 2002 18:37:43 +0200
From: DervishD <raul@pleyades.net>
To: undertow <undertow@dexcom.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: possible bug
Message-ID: <20021001163743.GA275@DervishD>
References: <1033487088.2369.6.camel@aenima>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1033487088.2369.6.camel@aenima>
User-Agent: Mutt/1.4i
Organization: Pleyades Net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Eduardo :)

> Im spannish user of linux, I have detected an error on my distro
> and I ask to local average users and told me that prob. is a kernel
> bug.

    I'm spanish, too ;)) But let's go to the matter: probably the PID
you're trying to 'kill -9' is stuck in 'D' state (or any other
uninterruptible state), so it's not a kernel bug ;) If this is not
the case, you may have hit a kernel bug.

> but I read that a kill -)
> command MUST finnish the running task

    AFAIK this is not exact ;) The 'SIGKILL' signal (that is, 9),
cannot be trapped and so its action cannot be changed. Moreover, it
is unblockable, so it's always 'fatal' ;))) it is always *sent*. This
doesn't mean that the process will die. If the process is in any
uninterruptible state, it won't be interrupted!. You will have to
wait until the process is woken up and then it will die.

    The more probable state, in my experience, is the 'D' state,
which if I remember well, is something like 'disk sleep', waiting for
disk i/o, etc...

> Normaly the freeze task
> is edonkey or overnet.

    Oh... The eDonkey client... AFAIK, this is closed source, so any
problem related to this client is difficult (if not impossible) to
catch...

    Raúl
