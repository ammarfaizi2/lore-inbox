Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267625AbTASVI3>; Sun, 19 Jan 2003 16:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267632AbTASVI3>; Sun, 19 Jan 2003 16:08:29 -0500
Received: from sccrmhc01.attbi.com ([204.127.202.61]:9660 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S267625AbTASVI2>; Sun, 19 Jan 2003 16:08:28 -0500
Message-ID: <000501c2c000$2c22b400$c5eeea0c@attbi.com>
From: "Paul Zimmerman" <zimmerman.paul@attbi.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: ANN: LKMB (Linux Kernel Module Builder) version 0.1.16
Date: Sun, 19 Jan 2003 13:17:28 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> It is also a bug that parts of the development infrastructure are
>> installed in /lib/modules/<version> and it's somewhat documented that
>> compiling modules needs this /lib/modules/<version> stuff. That may be
>> true for the ideal, simplified Red Hat world but in reality the
>> machine and running OS version of the development machine is likely
>> different from the box it will run on. Mixing development environment
>> and install target only causes confusion.
>
> you make a series of good points before this. However
> /lib/modules/<version>/build is nothing Red Hat specific. It's something
> that is the result of a similar discussion long ago where Linus finally
> decreed this location for finding the full source of modules.
> Combine that with the makefile dwmw2 showed and you can compile external
> modules EVERYWHERE on ANY distribution (assuming said distribution
> doesn't go out of the way to break the decree). Afaik RHL, SuSE,
> Mandrake, Debian and Slackware at least have this correct.
>
> Yes it breaks if you move around your source after doing make
> modules_install. Yes it breaks if you don't have the tree at all. But
> both situations are "invalid" wrt the decree, and need a fixed symlink.

Try "make modules INSTALL_MOD_PATH=<whatever>". Then modules
will use <whatever>/lib/modules instead of /lib/modules. This works in 2.4
and early 2.5, I haven't tried it with the new kbuild system in recent 2.5.
And
I don't know if this is properly documented anywhere.

Paul

