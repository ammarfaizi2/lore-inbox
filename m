Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263147AbUGYAE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263147AbUGYAE1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 20:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263204AbUGYAE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 20:04:26 -0400
Received: from chaos.analogic.com ([204.178.40.224]:61568 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263147AbUGYAEZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 20:04:25 -0400
Date: Sat, 24 Jul 2004 20:03:47 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Keith Owens <kaos@ocs.com.au>
cc: Mikael Pettersson <mikpe@csd.uu.se>, jamagallon@able.es,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.27+stdarg+gcc-3.4.1 
In-Reply-To: <18199.1090681162@ocs3.ocs.com.au>
Message-ID: <Pine.LNX.4.53.0407241958490.3373@chaos>
References: <18199.1090681162@ocs3.ocs.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jul 2004, Keith Owens wrote:

> On Sat, 24 Jul 2004 09:19:04 -0400 (EDT),
> "Richard B. Johnson" <root@chaos.analogic.com> wrote:
> >> >gcc -D__KERNEL__ -nostdinc -iwithprefix include
> >                     ^^^^^^^_______
> >
> >This will prevent it from using its private copy of stdarg.h.
> >
> >There needs to be one in the -I<include-path>
>
> No.  -iwithprefix include picks up the private path.  It is probably a
> misconfigured gcc, but I am waiting on detailed diagnostics to be sure.
>

Well you just might know everything, but with some versions of
gcc, I have found it necessary to use -I`gcc --print-file-name=include`
on the command line. On this system it is:

Script started on Sat Jul 24 19:58:12 2004
# gcc --print-file-name=include
/usr/local/lib/gcc-lib/i686-pc-linux-gnu/egcs-2.91.66/include
# exit
Script done on Sat Jul 24 19:58:35 2004

And it isn't a mis-configured gcc although some versions of gcc
don't always do what you are expecting.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


