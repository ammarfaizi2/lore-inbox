Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265748AbTL3LBt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 06:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265749AbTL3LBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 06:01:49 -0500
Received: from intra.cyclades.com ([64.186.161.6]:18099 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265748AbTL3LBr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 06:01:47 -0500
Date: Tue, 30 Dec 2003 09:00:32 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: IP v6 <inet6@mail.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel: kernel BUG at vmscan.c:389!
In-Reply-To: <26530865.1072758531296.JavaMail.Administrator@pumbaa>
Message-ID: <Pine.LNX.4.58L.0312300858200.22101@logos.cnet>
References: <26530865.1072758531296.JavaMail.Administrator@pumbaa>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Dec 2003, IP v6 wrote:

> Hello all, I've googled about the error in the subject but can't find anything about it,
> I seem to be the only one having this?
>
> Since I couldn't find anything in Google I am mailing it to this list.
>
> I'm having this for the second time and needed to reboot the box and I don't know how to reproduce this.
>
> The kernel version is 2.4.24-pre2 with some netfilter pom patches and lufs patch
> and the CPU is a Cyrix 6x86L 150MHz
> I believe this was the reason why I decided to upgrade to 2.4.24-pre2 from 2.4.23 but I'm not sure anymore, I forgot...
> Anyway I'm compiling 2.4.23 again now, as this may not happen when I'm out partying for newyear ;)
>
> Here is a *small* portion of the messages in /var/log/messages
> (there is more but the mail would be too long to include them all :)).
> I hope someone can do anything with this and help me. Thanks.
>
>
> Dec 30 02:34:43 core1-fe0-gw1 kernel: kernel BUG at vmscan.c:389!
> Dec 30 02:34:43 core1-fe0-gw1 kernel: invalid operand: 0000
> Dec 30 02:34:43 core1-fe0-gw1 kernel: CPU:    0
> Dec 30 02:34:43 core1-fe0-gw1 kernel: EIP:    0010:[<c012d240>]    Tainted: P
> Dec 30 02:34:43 core1-fe0-gw1 kernel: EFLAGS: 00010202
> Dec 30 02:34:43 core1-fe0-gw1 kernel: eax: 000000c4   ebx: c10215e4   ecx: 00002dd9   edx: c1160000
> Dec 30 02:34:43 core1-fe0-gw1 kernel: esi: c10215c8   edi: 00000000   ebp: 00000005   esp: c1161f30
> Dec 30 02:34:43 core1-fe0-gw1 kernel: ds: 0018   es: 0018   ss: 0018
> Dec 30 02:34:43 core1-fe0-gw1 kernel: Process kswapd (pid: 4, stackpage=c1161000)
> Dec 30 02:34:43 core1-fe0-gw1 kernel: Stack: c1160000 00000bf2 00000a31 000001d0 c028c998 c2cf6fe0 c105a460 c012d632
> Dec 30 02:34:43 core1-fe0-gw1 kernel:        c105a460 00000020 000001d0 c028c998 00000000 c012d6cf c1161f88 0000003c
> Dec 30 02:34:43 core1-fe0-gw1 kernel:        000001d0 00000020 c012d732 c1161f88 c1161f88 c028c998 00000000 c028c998
> Dec 30 02:34:43 core1-fe0-gw1 kernel: Call Trace:    [<c012d632>] [<c012d6cf>] [<c012d732>] [<c012d8ec>] [<c012d956>]
> Dec 30 02:34:43 core1-fe0-gw1 kernel:   [<c012da91>] [<c012d9f0>] [<c0105000>] [<c0107156>] [<c012d9f0>]

Hi,

This seems to be caused by the additional patches you are using.

Remove them and see if the machine is still unstable.
