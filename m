Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268516AbTBWR1s>; Sun, 23 Feb 2003 12:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268518AbTBWR1s>; Sun, 23 Feb 2003 12:27:48 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:19428 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S268516AbTBWR1r> convert rfc822-to-8bit; Sun, 23 Feb 2003 12:27:47 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Rik van Riel <riel@imladris.surriel.com>
Subject: Re: oom killer and its superior braindamage in 2.4
Date: Sun, 23 Feb 2003 18:35:56 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
References: <200302222025.48129.m.c.p@wolk-project.de> <Pine.LNX.4.50L.0302221711100.2206-100000@imladris.surriel.com> <Pine.LNX.4.50L.0302221732010.2206-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.50L.0302221732010.2206-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302231833.05944.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 22 February 2003 21:32, Rik van Riel wrote:

Hi Rik,

> > > - Feb 21 10:04:57 codeman kernel: Out of Memory: Killed process 2657
> > > (apache).
> > > The above log entry (apache) appeared for about 4 hours every some
> > > seconds (same PID) until I thought about sysrq-b
> > > Is there any chance we can fix this up?
> > Yes.
> Never mind my last idea, it can be done much simpler ;)
hehe :)

> Does the below patch fix your problem ?
Well, this makes a difference. I filled up my memory with something else 
before starting mystress.pl because of top's|ps' slowness with many processes.
I had about 400 processes. The test from yesterday had ~ 1800.

With your patch, mystress.pl was marked to get killed, every PID only once, no 
apache or similar (good). ... But the strange thing is, that it seems none of 
the processes, which are marked to be killed, get killed. So sysrq-t tells 
me. Sysrq-i gave me the chance to get out of the OOM killing process and only 
kernel threads were left + getty's so I was able to log in again.

ciao, Marc
