Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131532AbQKBOX7>; Thu, 2 Nov 2000 09:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131668AbQKBOXj>; Thu, 2 Nov 2000 09:23:39 -0500
Received: from chaos.analogic.com ([204.178.40.224]:41988 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S131532AbQKBOXf>; Thu, 2 Nov 2000 09:23:35 -0500
Date: Thu, 2 Nov 2000 09:23:01 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Thomas Sailer <sailer@ife.ee.ethz.ch>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Poll and OSS API
In-Reply-To: <3A017443.8E436A97@ife.ee.ethz.ch>
Message-ID: <Pine.LNX.3.95.1001102091346.8760A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2000, Thomas Sailer wrote:

> The OSS API (http://www.opensound.com/pguide/oss.pdf, page 102ff)
> specifies that a select _with the sounddriver's filedescriptor
> set in the read mask_ should start the recording.
> 
> Implementing this is currently not possible, as the driver does
> not get to know whether the application had the filedescriptor
> set in the select call. Similarily for poll, the driver does not
> get the caller's events.

The specification is bogus and should be fixed. select() is not
a function that was designed to start/stop anything. Writing
a specification to qualify some particular implementation's
side-affects is patently wrong. ioctl() was designed to control
things.

You should contact a committee member and get it fixed. Further,
all should fail to write code to such a so-called specification.

If specifications are allowed to be written like this, soon
the lights will go out when you open a file. This cannot be
allowed. Don't support such diatribe.

Cheers,
Dick Johnson

Penguin : Linux version 2.2.17 on an i686 machine (801.18 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
