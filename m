Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311664AbSDDVBX>; Thu, 4 Apr 2002 16:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311647AbSDDVBP>; Thu, 4 Apr 2002 16:01:15 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:36367 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S311618AbSDDVBB>; Thu, 4 Apr 2002 16:01:01 -0500
Date: Thu, 4 Apr 2002 16:56:22 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: "Sapan J . Bhatia" <lists@corewars.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] POLL_OUT in ttys, misc bug fix
In-Reply-To: <20020327032408.A7073@corewars.org>
Message-ID: <Pine.LNX.4.21.0204041655430.10117-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sapan, 

Have you actually tested the SIGIO POLL_OUT changes with an userspace app?

Thanks

On Wed, 27 Mar 2002, Sapan J . Bhatia wrote:

> Hello,
> 
> While fixing a flow control bug that truncated output to a terminal in
> User Mode Linux, I noticed that the tty drivers only send POLL_IN on new
> data being available but not POLL_OUT when the device is ready for new
> data.
> 
> This patch fixes the bug in the line discipline and the pty driver.
> 
> Also, there's another minor bug in n_tty.c where write_chan returns
> on a (retvalue < 0) unconditionally. This is a problem, since the type of
> IO (BLOCKING / NON_BLOCKING) is stored in the tty, and if the console driver
> returns a -EAGAIN (eg. in UML on getting an EAGAIN from the host kernel), 
> write_chan returns even in the case of a blocking write, which is wrong
> since the process doesn't expect it.
> 
> Regards,
> Sapan
> 
> 

