Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268282AbTBMUTL>; Thu, 13 Feb 2003 15:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268284AbTBMUTL>; Thu, 13 Feb 2003 15:19:11 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23827 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268282AbTBMUTK>; Thu, 13 Feb 2003 15:19:10 -0500
Date: Thu, 13 Feb 2003 12:25:26 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Synchronous signal delivery..
In-Reply-To: <Pine.LNX.4.50.0302131215140.1869-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.44.0302131222560.2125-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 13 Feb 2003, Davide Libenzi wrote:
> 
> That's really nice, I like file-based interfaces. No plan to have a way to
> change the sig-mask ? Close and reopen ?

You can have multiple fd's open at the same time, which is a lot more 
convenient. 

I will _not_ add a fcntl-like or ioctl interface to this. They are ugly 
_and_ there are security issues (ie if you pass on the fd to somebody 
else, they must not be able to change the signal mask _you_ specified).

> What do you think about having timers through a file interface ?

One of the reasons for the "flags" field (which is not unused) was because 
I thought it might have extensions for things like alarms etc. 

		Linus

