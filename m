Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263431AbSJGW42>; Mon, 7 Oct 2002 18:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263328AbSJGWzU>; Mon, 7 Oct 2002 18:55:20 -0400
Received: from mg03.austin.ibm.com ([192.35.232.20]:23728 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S263121AbSJGWyc>; Mon, 7 Oct 2002 18:54:32 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: GrandMasterLee <masterlee@digitalroadkill.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: EVMS breaking menuconfig in 2.5.40?
Date: Mon, 7 Oct 2002 09:30:20 -0500
X-Mailer: KMail [version 1.2]
References: <1033968519.3948.7.camel@localhost>
In-Reply-To: <1033968519.3948.7.camel@localhost>
MIME-Version: 1.0
Message-Id: <02100709302000.15613@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 October 2002 00:28, GrandMasterLee wrote:
> I got EVMS from cvs, found the 2.5.40 patch, applied it, then attempted
> to do make menuconfig.
>
> All that happens is this:
>
> [austin@UberGeek linux-2.5.40]$ make menuconfig
> make[1]: Entering directory `/data/build/linux-2.5.40/scripts'
> make -C lxdialog all
> make[2]: Entering directory `/data/build/linux-2.5.40/scripts/lxdialog'
> make[2]: Leaving directory `/data/build/linux-2.5.40/scripts/lxdialog'
> make[1]: Leaving directory `/data/build/linux-2.5.40/scripts'
> /bin/sh ./scripts/Menuconfig arch/i386/config.in
> Using defaults found in .config
> Preparing scripts: functions, parsing

It sounds like you added the EVMS common-files patch but not the actual EVMS 
code. This will cause the kernel config to break, since it can't find the 
file drivers/evms/Config.in.

If you want to build the latest EVMS kernel code from CVS, please see 
http://evms.sf.net/install.html (last section).

> and then my console becomes unuseable, I can't even ssh in from another
> box, then X dies eventually.
>
> If I hit and hold ctrl-c for a few seconds after this begins, I can
> usually break out, but if I miss it, then well, X blows up pretty good.

This doesn't make much sense. When I reproduce the above situation, all I get 
is an error from awk, and then make quits with an error. I can't imagine why 
it would cause your X server to blow up.

-- 
Kevin Corry
corryk@us.ibm.com
http://evms.sourceforge.net/
