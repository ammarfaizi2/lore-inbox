Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261754AbTCQPsL>; Mon, 17 Mar 2003 10:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261758AbTCQPsL>; Mon, 17 Mar 2003 10:48:11 -0500
Received: from chaos.analogic.com ([204.178.40.224]:17796 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S261754AbTCQPsJ>; Mon, 17 Mar 2003 10:48:09 -0500
Date: Mon, 17 Mar 2003 11:15:37 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Sparks, Jamie" <JAMIE.SPARKS@cubic.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: select() stress
In-Reply-To: <Pine.WNT.4.44.0303171010580.1544-100000@GOLDENEAGLE.gameday2000>
Message-ID: <Pine.LNX.4.53.0303171112090.22652@chaos>
References: <Pine.WNT.4.44.0303171010580.1544-100000@GOLDENEAGLE.gameday2000>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Mar 2003, Sparks, Jamie wrote:

>
> Hello,
>
>   I'm running some code ported from an sgi running Irix 6.5 on a
>   redhat 7.1 box: 2.4.7-10, i686.  Control hangs on a select()
>   statement forever.  The select is never completed, so I can't
>   check errno.
>
[SNIPPED...]


>       /*  ****************************** */
>       if (select(getdtablesize(), &socklist, NULL, NULL, NULL) < 0)
>       {
>         if (errno != EINTR) perror("WeapTerrain");
> 	continue;
>       }

select() takes a file-descriptor as its first argument, not the
return-value of some function that returns the number of file-
descriptors. You cannot assume that this number is the same
as the currently open socket. Just use the socket-value. That's
the file-descriptor.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

