Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269073AbUIXXk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269073AbUIXXk3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 19:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269088AbUIXXk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 19:40:27 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:13220 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S269073AbUIXXiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 19:38:16 -0400
Subject: Re: 2.6.9-rc2-mm1 swsusp bug report.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Kevin Fenzi <kevin-linux-kernel@scrye.com>, Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040924210958.A3C5AA2073@voldemort.scrye.com>
References: <20040924021956.98FB5A315A@voldemort.scrye.com>
	 <20040924143714.GA826@openzaurus.ucw.cz>
	 <20040924210958.A3C5AA2073@voldemort.scrye.com>
Content-Type: text/plain
Message-Id: <1096069216.3591.16.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sat, 25 Sep 2004 09:40:17 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sat, 2004-09-25 at 07:09, Kevin Fenzi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> >>>>> "Pavel" == Pavel Machek <pavel@ucw.cz> writes:
> 
> Pavel> Hi!
> >> Was trying to swsusp my 2.6.9-rc2-mm1 laptop tonight. It churned
> >> for a while, but didn't hibernate. Here are the messages.
> >> 
> >> ....................................................................................................
> >> .........................swsusp: Need to copy 34850 pages Sep 23
> >> 16:53:37 voldemort kernel: hibernate: page allocation
> >> failure. order:8, mode:0x120 Sep 23 16:53:37 voldemort kernel:
> Pavel> Out of memory... Try again with less loaded system. 
> 
> The system was no more loaded than usual. I have 1GB memory and 4GB of
> swap defined. I almost never touch swap. It might have been 100mb into
> the 4Gb of swap when this happened. 
> 
> What would cause it to be out of memory? 
> swsup needs to be reliable... rebooting when you are using your memory
> kinda defeats the purpose of swsusp. 

The problem isn't really that you're out of memory. Rather, the memory
is so fragmented that swsusp is unable to get an order 8 allocation in
which to store its metadata. There isn't really anything you can do to
avoid this issue apart from eating memory (which swsusp is doing
anyway).

Regards,

Nigel

