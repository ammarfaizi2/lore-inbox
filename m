Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030442AbWBHXNr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030442AbWBHXNr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 18:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030444AbWBHXNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 18:13:47 -0500
Received: from xproxy.gmail.com ([66.249.82.196]:5960 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030442AbWBHXNr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 18:13:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nq2dj219j7T5DQ/nqxPegOg0gx8we5dkl3wa3fKiUnjlUdUIbLlK5UfS7TwEn2VPcmdRTCX3NLzsaAv6NaKJmRU8N9ilj2I0bJumSJDMYh4M47N9kQXAq3rtm6Xg0THmok+ZZx7DAUoRalLKL4FwIqqvLKKlM/HMqGp+X7UzsCY=
Message-ID: <2753bafa0602081513v1c520b85t4bbb6dfa90c1f251@mail.gmail.com>
Date: Thu, 9 Feb 2006 00:13:45 +0100
From: thomas <thomas.bsd@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Incomprehensible Boot freeze & Crash - Kernel 2.6.12
In-Reply-To: <Pine.LNX.4.61.0602081642040.7149@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <2753bafa0602081333y2f0f8c37o210b8acb6b3b73d1@mail.gmail.com>
	 <Pine.LNX.4.61.0602081642040.7149@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/06, linux-os (Dick Johnson) <linux-os@analogic.com> wrote:
>
> On Wed, 8 Feb 2006, thomas wrote:
>
> > Hello,
> > I'm running Debian GNU/Linux Etch on an Acer Aspire 1682 laptop with
> > kernel 2.6.12-1-686. So far the system was rock solid but I'm now
> > experiencing a boot freeze:
> >
> > ... Setting up ICE socket directory /tmp/ICE-Unix... done
> > INIT: Entering runlevel: 2
> > Starting system log daemon: syslogd
> >
> > Then, nothing. However I can boot in "recover mode" (that is, single
> > user & root login). There does not seem to be any hardware failure,
> > the partitions are properly mounted, and there is engough free space
> > on any of them. When I shut down the box, hundreds of lines of errors
> > messages are outputted. I cannot read them all but here are the last
> > ones:
> >
> > EIP is at do_page_fault+0xd6/0x6bf
> > eax: dfa40000 ebx:00000000 ecx:0000007b edx:ffffff7b esi:00030001
> > edi:0000000d ebp:0000000b esp: dfa417c8
> > ds: 007b es:007b ss:0008 (snip)
>        ^^^^^^^^^^^____ These are not correct segments!
>
> Something is corrupting the GDT or setting incorrect segments directly.
> Perhaps a driver? Or maybe your CPU is way too hot and is corrupting
> segments itself?

You may be right (but I did not install any new piece of hardware
recently). Maybe the following will help to understand the problem:

Booting for the tenth time worked surprisingly. As I shutdown the
system, this line was outputted without end:

inode hda2: 96697 at df6aa440: mode 120777, nlink 1, next 0

hda2 is my / partition. What does that mean? When I re-booted, then
re-shut down my computer, this worked flawlessly. Now everything seems
to work; however /var/log/boot contains a few errors:

Wed Feb  8 23:58:23 2006: Starting internet superserver:
inetdstart-stop-daemon: open pidfile /var/run/inetd.pid: Input/output
error (Input/output error)
Wed Feb  8 23:58:24 2006: Starting periodic command scheduler:
cronstart-stop-daemon: open pidfile /var/run/crond.pid: Input/output
error (Input/output error)

I don't want ask you to spend time for an
approximatively-self-solved-issue, but if you have an idee what
happened to my comp, I would be glad to hear it.

Thanks
