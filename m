Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316594AbSFGBtC>; Thu, 6 Jun 2002 21:49:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316598AbSFGBtB>; Thu, 6 Jun 2002 21:49:01 -0400
Received: from fed1mtao02.cox.net ([68.6.19.243]:21720 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP
	id <S316594AbSFGBtA>; Thu, 6 Jun 2002 21:49:00 -0400
Message-ID: <000d01c20dc5$7a5b08e0$66aca8c0@kpfhome>
From: "Kevin P. Fleming" <kpfleming@cox.net>
To: <linux-kernel@vger.kernel.org>
Subject: kbuild-2.5 on 2.4.19-pre10-ac2 build error when modular support turned off
Date: Thu, 6 Jun 2002 18:48:53 -0700
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

I had a kernel built and working fine with module support turned on, only a
single driver (ide-floppy) compiled as a module. I then did "make -f
Makefile-2.5 menuconfig" and turned off loadable module support, kmod and
double-checked that ide-floppy changed to built-in (it did).

I then did "make -f Makefile-2.5 -j2 installable", and kbuild rebuilt very
little, and the final link died with failed references to "request_module".
It appears that kbuild did not rebuild the entire kernel, even though would
have been necessary.

Did I miss something?

