Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264640AbUGINxB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264640AbUGINxB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 09:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264649AbUGINxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 09:53:01 -0400
Received: from mail.dif.dk ([193.138.115.101]:41092 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S264640AbUGINw7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 09:52:59 -0400
Date: Fri, 9 Jul 2004 15:51:37 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: post 2.6.7 BK change breaks Java?
In-Reply-To: <20040705231131.GA5958@merlin.emma.line.org>
Message-ID: <Pine.LNX.4.56.0407091544170.22376@jjulnx.backbone.dif.dk>
References: <20040705231131.GA5958@merlin.emma.line.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jul 2004, Matthias Andree wrote:

> Hi,
>
> I've pulled from the linux-2.6 BK tree some post-2.6.7 version, compiled
> and installed it, and it breaks Java, standalone or plugged into
> firefox, the symptom is that the application catches SIGKILL. This
> didn't happen with stock 2.6.7 and doesn't happen with 2.6.6 either.
>
I'm seeing the same thing. I'm using Eclipse a lot which is Java based,
and I noticed that wen I went from plain 2.6.7 to 2.6.7-mm3 Eclipse
started dying shortly after launch (it only manages to get the splash
screen up) with a message about the JVM dying. Since I had also upgraded
my Sun Java at the same time I initially suspected that and back down to
my old version, but the problem persisted. Then I tried the latest Java
release from Sun, with same result. Then I started suspecting the kernel
and tried 2.6.7-mm6, 2.6.7-bk20 and 2.6.7-mm7 - all with the same result
that Java breaks. Finally I went back to a plain 2.6.7 and the problem
went away - so it certainly looks kernel related.
I was using the same .config with all kernels (copied from my plain 2.6.7
kernel to the others and then running 'make oldconfig'), so I'm also
pretty sure it's not due to some new kernel option I've enabled that I
don't usually use.

My hardware is AMD Athlon (t-bird) 1.4GHz CPU in a ASUS A7M266 mobo with
512MB of DDR266 RAM.


> Is there any particular change I should try backing out?
>
I'm looking for the same thing, haven't found it yet unfortunately.

--
Jesper Juhl <juhl-lkml@dif.dk>
