Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261453AbTCTNgb>; Thu, 20 Mar 2003 08:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261455AbTCTNgb>; Thu, 20 Mar 2003 08:36:31 -0500
Received: from chaos.analogic.com ([204.178.40.224]:30856 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S261453AbTCTNg2>; Thu, 20 Mar 2003 08:36:28 -0500
Date: Thu, 20 Mar 2003 08:49:02 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: John Jasen <jjasen@realityfailure.org>
cc: John Bradford <john@grabjohn.com>, "H. Peter Anvin" <hpa@zytor.com>,
       mirrors@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Deprecating .gz format on kernel.org
In-Reply-To: <Pine.LNX.4.44.0303200744010.2365-100000@bushido>
Message-ID: <Pine.LNX.4.53.0303200819070.3415@chaos>
References: <Pine.LNX.4.44.0303200744010.2365-100000@bushido>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Mar 2003, John Jasen wrote:

>
> Among the latest 2.4-release kernels (2.4.19 and 2.4.20), it seems that
> bz2 saves ~6MB.
>
> Downloads: 1.5MB DSL
>
> time `ncftpget ftp://ftp.kernel.org/pub/linux/kernel/v2.4/linux-2.4.20.tar.gz`
> real    3m24.004s
> <snipped>
>
> time `ncftpget ftp://ftp.kernel.org/pub/linux/kernel/v2.4/linux-2.4.20.tar.bz2`
> real    2m51.481s
> <snipped>
>
> Uncompression: Dual AMD 1600+, 512MB ram, 30 GB seagate EIDE
> time `gunzip linux-2.4.20.tar.gz`
> real    0m5.428s
> user    0m2.285s
> sys     0m1.096s
>
> time `bunzip2 linux-2.4.20.tar.bz2 `
> real    0m28.892s
> user    0m27.318s
> sys     0m1.363s
>
> Compression: Dual AMD 1600+, 512MB ram, 30 GB seagate EIDE
> time `gzip linux-2.4.20.tar`
> real    0m18.771s
> user    0m17.990s
> sys     0m0.674s
>
> time `gzip -9 linux-2.4.20.tar`
> real    0m42.032s
> user    0m40.725s
> sys     0m0.791s
>
> time `bzip2 linux-2.4.20.tar`
> real    1m50.411s
> user    1m49.197s
> sys     0m0.555s
>
> bz2 is about 18% of the size of the tarfile. gz is 22%. gzip -9 saved a
> whopping 310k compared to gzip.
>
> --
> -- John E. Jasen (jjasen@realityfailure.org)
> -- User Error #2361: Please insert coffee and try again.
>

Simple question. Has anybody provided a modified `tar` that
will properly extract `tar -xzf ...` without having to determine
ahead of time if it's a bz2 or gzip file? If not, you will
obsolete bz(2)illions of scripts that are in use for automatic
functions world-wide.

If tar will filter through past, present, and future compression
programs without human intervention, then you can get rid of
anything you want. But, until this is done, you need to leave
the "past" alone. There are many machines that get and install
stuff from tapes and home-brew CDs. They may not even have
'bz' stuff. Right now you have to modify scripts to use
tar -xjf after parsing the file-type to check its name and,
      |______ Dumb, doesn't make any sense.
some working systems don't even have bzip2 and are not connected
to the Internet.

Last year, I was in Kuala Lumpur, Malaysia (a nice modern city).
My company sent me a new CD to install a software update on
a 3-year old system. The compression was in "@$^_@%" bz format.
There was no such thing on that machine. I had to buy some
"Distribution" and waste time finding out how to extract the
bzip2 stuff from the CD/ROM. Not easy to do when the Distribution
CD/ROM was designed to install a complete operating system.

So my advise is to let the past slowly die away. Do not convert
any older distributions into something new. Leave them alone.
Make sure that any new distribution has the tools to handle the
old stuff and the next stuff. Then you can't go wrong.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

