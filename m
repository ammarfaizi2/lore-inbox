Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135354AbRDLV6V>; Thu, 12 Apr 2001 17:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135357AbRDLV6L>; Thu, 12 Apr 2001 17:58:11 -0400
Received: from [216.151.155.121] ([216.151.155.121]:33287 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S135354AbRDLV6D>; Thu, 12 Apr 2001 17:58:03 -0400
To: Daniel Podlejski <underley@underley.eu.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Incorect signal handling ?
In-Reply-To: <20010412223128.A11625@witch.underley.eu.org>
From: Doug McNaught <doug@wireboard.com>
Date: 12 Apr 2001 17:56:37 -0400
In-Reply-To: Daniel Podlejski's message of "Thu, 12 Apr 2001 22:31:28 +0200"
Message-ID: <m3r8yxrdd6.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Podlejski <underley@underley.eu.org> writes:

> Hi,
> 
> there is litlle programm:
> 
> 	signal (SIGALRM, empty);
> 	alarm (1);
> 
>         a = read(fd, buf, 511);
> 
>         while (a && a != -1) a = read(fd, buf, 511);

> I open /tmp/nic and run compiled program.
> There should be error EINTR in read, but isn't.

"Fast" system calls (eg reads from disk) are generally
uninterruptible; thus the signal will be deferred until the read()
returns.

-Doug
