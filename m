Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261520AbSIZUgz>; Thu, 26 Sep 2002 16:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261522AbSIZUgz>; Thu, 26 Sep 2002 16:36:55 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:29967 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S261520AbSIZUgx>; Thu, 26 Sep 2002 16:36:53 -0400
Message-Id: <200209262037.g8QKbTp06253@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: DragonK <dragon_krome@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.x Kernel Bug - Problem found
Date: Thu, 26 Sep 2002 23:31:45 -0200
X-Mailer: KMail [version 1.3.2]
References: <20020925210654.24630.qmail@web20301.mail.yahoo.com>
In-Reply-To: <20020925210654.24630.qmail@web20301.mail.yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 September 2002 19:06, DragonK wrote:
> Hello,
>
> Two days ago I've sent you a mail regarding my problem
> with the Kernel 2.4(5).x boot hangs.
>
> I'd like to thank the kind people who answered me
> back, I really appreciate their efforts.
>
> I have two news: one good, one bad :)
> The good one is that I've found the cause of the
> kernel lock-up (er...sort of).
>
> Tha bad one is that I can't do anything about it.
> I had an ideea and disabled in my BIOS all caches,
> floppy controller, ports and other stuff...
> Surprise! Kernel 2.4.18 booted (in 10 mins :). No
> lock-up!!

Congratulations!

> Ok...I went back into the BIOS and enabled internal
> cache. Boot again...Guess what? :(
> Nothing...dead.
>
> So, at least on my system, there is a problem with the
> cache. I don't think that the cache memory
> itself is bad, since I don't experience random
> failures or reboots...
>
> What should I do? If there will be a patch for this,
> where would I find it?
> Please help!

You have to patch arch/i386/setup.S with some piece of
'marker' asm code (say, infinite loop with blinking keyboard LED :-)
and move it further and further into boot process
until you find a place where it stops blinking.
You'll know then exact place of hang!
--
vda
