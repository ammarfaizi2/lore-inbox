Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289844AbSAKDGJ>; Thu, 10 Jan 2002 22:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289843AbSAKDF7>; Thu, 10 Jan 2002 22:05:59 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:60945 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S289844AbSAKDFt>; Thu, 10 Jan 2002 22:05:49 -0500
Date: Thu, 10 Jan 2002 19:11:12 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Robert Love <rml@tech9.net>
cc: Dieter =?ISO-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Ed Tomlinson <tomlins@cam.org>, Ingo Molnar <mingo@elte.hu>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] O(1) scheduler, -H4 - 2.4.17 problems
In-Reply-To: <1010718017.1027.8.camel@phantasy>
Message-ID: <Pine.LNX.4.40.0201101910260.1493-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Jan 2002, Robert Love wrote:

> On Thu, 2002-01-10 at 21:42, Davide Libenzi wrote:
>
> > Look in init/main.c, if kernel_thread() is called before init_idle().
>
> init is started via kernel_thread prior to init_idle ...

Move init_idle() before the first call to kernel_thread().
This should fix it.



- Davide


