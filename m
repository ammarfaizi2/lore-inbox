Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267434AbTALUEL>; Sun, 12 Jan 2003 15:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267481AbTALUEL>; Sun, 12 Jan 2003 15:04:11 -0500
Received: from services.cam.org ([198.73.180.252]:12493 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S267434AbTALUEF> convert rfc822-to-8bit;
	Sun, 12 Jan 2003 15:04:05 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: Re: make xconfig broken in bk current
Date: Sun, 12 Jan 2003 15:12:59 -0500
User-Agent: KMail/1.4.3
Cc: Roman Zippel <zippel@linux-m68k.org>
MIME-Version: 1.0
Message-Id: <200301121512.59840.tomlins@cam.org>
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:

> Hi,
> 
> Ed Tomlinson wrote:
> 
>> make -f scripts/Makefile.build obj=scripts/kconfig scripts/kconfig/qconf
>>   g++  -o scripts/kconfig/qconf  scripts/kconfig/kconfig_load.o 
>>   scripts/kconfig/qconf.o  -L/usr/share
>> /qt/lib -Wl,-rpath,/usr/share/qt/lib -lqt-mt -ldl
>> scripts/kconfig/qconf.o(.text+0x31): In function `ConfigView::tr(char
>> const*, char const*)':
>> : undefined reference to `QApplication::translate(char const*, char
>> : const*, char const*, QApplication:
>> :Encoding) const'
> 
> Which distribution do you use?
> It looks like you try to use a different g++ version than qt was
> compiled with.

This makes sense.  Debian has changed its default compiler to 3.2 in
sid...  Suspect we will get quite a few reports like this one.

Solution would seem to be to fix the links in /usr/bin for:

gcc
g++
gcov
cpp

to point at the 2.95 binary, make clean xconfig

Thanks
Ed Tomlinson

PS. The kernel will not link here using 3.2....
