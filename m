Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266552AbUBETbS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 14:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266808AbUBETbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 14:31:18 -0500
Received: from chaos.analogic.com ([204.178.40.224]:6529 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266552AbUBETat
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 14:30:49 -0500
Date: Thu, 5 Feb 2004 14:33:20 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: Nicholas Berry <nikberry@med.umich.edu>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: change kernel name
In-Reply-To: <20040205083949.7738937d.rddunlap@osdl.org>
Message-ID: <Pine.LNX.4.53.0402051429590.7301@chaos>
References: <s021eb13.042@med-gwia-02a.med.umich.edu>
 <20040205083949.7738937d.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1678434306-838005544-1076009600=:7301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1678434306-838005544-1076009600=:7301
Content-Type: TEXT/PLAIN; charset=US-ASCII


Hello all,

It turns out that you can easily change the kernel name, version,
etc., even on a running kernel.

Everything you need is already exported.
A very easy module and test program is attached.

Script started on Thu Feb  5 14:24:20 2004
# ./tester
Usage:
./tester <Item> <string>
Items are SYSNAME, NODENAME, RELEASE, VERSION, MACHINE, DOMAIN
# ./tester SYSNAME foo
Can't open device file, UNAME
Maybe `insmod` the driver?
# insmod unamedrvr.o
# ./tester sysname foo
# uname -a
foo chaos 2.4.24 #1 SMP Wed Feb 4 11:50:33 EST 2004 i686
# ./tester sysname Linux
You have new mail in /var/spool/mail/root
# uname -a
Linux chaos 2.4.24 #1 SMP Wed Feb 4 11:50:33 EST 2004 i686
# ./tester nodename bar
# uname -a
Linux bar 2.4.24 #1 SMP Wed Feb 4 11:50:33 EST 2004 i686
# ./tester node chaos
# uname -a
Linux chaos 2.4.24 #1 SMP Wed Feb 4 11:50:33 EST 2004 i686
# ./tester releas 1.1
You have new mail in /var/spool/mail/root
# uname -a
Linux chaos 1.1 #1 SMP Wed Feb 4 11:50:33 EST 2004 i686
# ./tester r 2.4.24
# uname -a
Linux chaos 2.4.24 #1 SMP Wed Feb 4 11:50:33 EST 2004 i686
# exit
exit
Script done on Thu Feb  5 14:27:04 2004

Have fun!


On Thu, 5 Feb 2004, Randy.Dunlap wrote:

> On Thu, 05 Feb 2004 07:04:26 -0500 "Nicholas Berry" <nikberry@med.umich.edu> wrote:
>
> | Note the words 'after the compilation'.
>
> I think that the other person who answered 'no' was close enough.
>
> BTW, did you say what processor architecture and what kernel
> image file format?  If it's a zipped kernel image, changing text
> in it is a bit tougher, I guess.  If it's not zipped, almost
> anything could change that string (just not make it larger).
>
> --
> ~Randy
>
> | >>> "Richard B. Johnson" <root@chaos.analogic.com> 02/04/04 07:38AM
> | >>>
> | On Tue, 3 Feb 2004, Gaspar Bakos wrote:
> |
> | > Hello,
> | >
> | > I have the following question:
> | > If I compile the kernel (2.4.*) and boot it in, then the
> | kernel-release,
> | > as shown by 'uname -r' will be the string that was in the
> | EXTRAVERSION
> | > string from the kernel Makefile.
> | > Is there any way to change this 'identity' of the kernel after the
> | > compilation?
> | > Such as
> | > changekernelname bzImage "newname"
> |
> | Put anything you want in the structure, system_utsname, in your copy
> | of
> | linux-nn-nn/init/version.c.
> |
> | Cheers,
> | Dick Johnson
> | Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
> |             Note 96.31% of all statistics are fiction.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


--1678434306-838005544-1076009600=:7301
Content-Type: APPLICATION/octet-stream; name="module.tar.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.53.0402051433200.7301@chaos>
Content-Description: 
Content-Disposition: attachment; filename="module.tar.gz"

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

--1678434306-838005544-1076009600=:7301--
