Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262872AbUB0Nd5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 08:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262871AbUB0NcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 08:32:00 -0500
Received: from chaos.analogic.com ([204.178.40.224]:642 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262872AbUB0Nby
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 08:31:54 -0500
Date: Fri, 27 Feb 2004 08:33:23 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Tibor Kendl <kendl@flexys.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Set gcc to kernel header path
In-Reply-To: <403F4B58.1010901@flexys.hu>
Message-ID: <Pine.LNX.4.53.0402270823500.6853@chaos>
References: <403F4B58.1010901@flexys.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Feb 2004, Tibor Kendl wrote:

> Dear mailing list members!
>
> I'd like to know, how do you solve this problem on your own systems.
> I've installed a linux distribution with a 2.2.18 kernel, than i've
> downloaded, compiled and installed a 2.6.2 kernel. How can i make, if i
> want to compile any application ( like Samba, Apache, KDE, etc...), the
> gcc compiler use the '/usr/src/linux-2.6.2/include' header path instaead
> of the '/usr/include' for such include directories like 'linux', 'asm',
> 'asm-generic', etc...?
>
> Yours
> Tibor Kendl
>


	gcc -I/usr/src/linux-2.6.2/include

... if you are sure that's what you want. Normally, you use the
headers that your 'C' runtime library was compiled with, i.e.,
what's in /usr/include.

gcc will search the -I/path first, then do the other ones unless
you use  -nostdinc on the command-line as well. If you use
-nostdinc, you need to also put -I`gcc -print-file-name=include` on
the command line, also or else gcc won't find stddef.h, etc., which
are not in one of the "standard places".


Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


