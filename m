Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261987AbTCQUoZ>; Mon, 17 Mar 2003 15:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261997AbTCQUoY>; Mon, 17 Mar 2003 15:44:24 -0500
Received: from chaos.analogic.com ([204.178.40.224]:14469 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S261987AbTCQUoX>; Mon, 17 Mar 2003 15:44:23 -0500
Date: Mon, 17 Mar 2003 16:12:28 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Jamie Lokier <jamie@shareable.org>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.20 modem control
In-Reply-To: <20030317195607.GB11881@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.53.0303171610400.23874@chaos>
References: <Pine.LNX.4.53.0303171116160.22652@chaos>
 <20030317195607.GB11881@mail.jlokier.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Mar 2003, Jamie Lokier wrote:

> Richard B. Johnson wrote:
> > Now, the hang-up sequence appears to be queued. It can (and does)
> > happen after the previous terminal owner has expired and another
> > owner has opened the device. This makes /dev/ttyS0 useless for remote
> > log-ins.
> >
> > It needs to be, that a 'close()' of a terminal, configured as a modem,
> > cannot return to the caller until after the DTR has been lowered, and
> > preferably, after waiting a few hundred milliseconds. Without this,
> > once logged in, the modem will never disconnect so a new caller
> > can't log in.
>
> Better would be if the hang-up sequence is still queued, but a new
> open() is delayed until the hangup has completed.
>
> -- Jamie
>

Yes, something like that. Modems are "special" only one task is
going to access that device at one time.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

