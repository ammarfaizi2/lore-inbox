Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262685AbUJ0Xcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262685AbUJ0Xcb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 19:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262630AbUJ0Uvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 16:51:41 -0400
Received: from mail.dif.dk ([193.138.115.101]:4271 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262723AbUJ0Uq0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 16:46:26 -0400
Date: Wed, 27 Oct 2004 22:54:48 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Danny Brow <dan@fullmotions.com>
Cc: Kernel-List <linux-kernel@vger.kernel.org>
Subject: Re: SSH and 2.6.9
In-Reply-To: <1098906712.2972.7.camel@hanzo.fullmotions.com>
Message-ID: <Pine.LNX.4.61.0410272247460.3284@dragon.hygekrogen.localhost>
References: <1098906712.2972.7.camel@hanzo.fullmotions.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2004, Danny Brow wrote:

> I have this odd issue with the 2.6.9 & greater kernels, that I can't ssh
> or use scp any more, this is what happens when I try:
> 
> SSH Error with-in X:
> ssh_askpass: exec(/usr/libexec/ssh-askpass): No such file or directory
> Host key verification failed.
> 
> SCP Error with-in X:
> ssh_askpass: exec(/usr/libexec/ssh-askpass): No such file or directory
> Host key verification failed.
> lost connection
> 
> I just get Host key verification failed in the terminal with either
> command.
> 
> ssh-askpass does not exsisit but it never has & ssh/scp works fine with
> 2.6.8.1 and below. When upgrading to the new kernel I just copied my
> old .config and did a make oldconfig, make, etc.
> 
> Any ideas?
> 

As it happens, I had a chat with a few people on IRC a few days ago who 
had very similar trouble and I had no such trouble. After talking about 
our kernel configs a bit we came to the conclusion that the main 
difference between our .config's (except for some hardware specific 
drivers and a few other bits that seemed unrelated) was that they had 
CONFIG_LEGACY_PTYS=y while I had it unset. One guy recompiled his kernel 
on the spot and disabled CONFIG_LEGACY_PTYS and then reported that his 
trouble went away. He may have made other changes as well, I don't know, 
and it may have been some of the seemingly unrelated bits that did the 
trick, again I don't know.

I have not attempted to verify this myself, but I'd say it's worth a try 
for you to disable CONFIG_LEGACY_PTYS (if you have it enabled) and then 
test that (and report your findings back).

--
Jesper Juhl

