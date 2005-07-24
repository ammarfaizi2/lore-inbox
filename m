Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261380AbVGXXXD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbVGXXXD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 19:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbVGXXXC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 19:23:02 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:4531 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261380AbVGXXXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 19:23:00 -0400
Subject: Re: kernel 2.6 speed
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ciprian <cipicip@yahoo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050724191211.48495.qmail@web53608.mail.yahoo.com>
References: <20050724191211.48495.qmail@web53608.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 25 Jul 2005 00:47:49 +0100
Message-Id: <1122248869.10835.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-07-24 at 12:12 -0700, Ciprian wrote:
> I'm not an OS guru, but I ran a little and very simple
> test. The program bellow, as you can see, measures the
> number of cycles performed in 30 seconds.

No it measures the performance of the "time()" call. Windows has some
funky optimisations that we never bother with because time() isn't a hot
path in the real world.

Instead try code which does


time(&start);
while(count++ < LOTS) {
  Do_stuff
}
time(&end)

and you'll find the numbers on pure CPU work are essentially CPU bound
not OS affected at all

