Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314475AbSFQPjv>; Mon, 17 Jun 2002 11:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314485AbSFQPju>; Mon, 17 Jun 2002 11:39:50 -0400
Received: from [195.63.194.11] ([195.63.194.11]:43269 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314475AbSFQPjt> convert rfc822-to-8bit; Mon, 17 Jun 2002 11:39:49 -0400
Message-ID: <3D0E02C2.5010304@evision-ventures.com>
Date: Mon, 17 Jun 2002 17:39:46 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.22 broke modversions
References: <Pine.LNX.4.44.0206171029400.22308-100000@chaos.physics.uiowa.edu>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Kai Germaschewski napisa³:
> On Mon, 17 Jun 2002, Martin Dalecki wrote:
> 
> 
>>BTW> There is some different thing broken: TEMP files
>>used by make menuconfig don't get clean up even after make distclean.
> 
> 
> Could you be more specific? The only file I can see lying around here
> is .menuconfig.log, and that gets cleaned up.
> 


Bjez probljemaw:

The following diff clutter appears in every diff after make menuconfig

diff -urN linux-2.5.21/scripts/lxdialog/.checklist.o.cmd 
linux/scripts/lxdialog/.checklist.o.cmd
--- linux-2.5.21/scripts/lxdialog/.checklist.o.cmd	1970-01-01 0
diff -urN linux-2.5.21/scripts/lxdialog/.inputbox.o.cmd 
linux/scripts/lxdialog/.inputbox.o.cmd
--- linux-2.5.21/scripts/lxdialog/.inputbox.o.cmd	1970-01-01 01:00:00.000000000 +0100
+++ linux/scripts/lxdialog/.inputbox.o.cmd	2002-06-13 12:50:06.000000000 +
diff -urN linux-2.5.21/scripts/lxdialog/.menubox.o.cmd 
linux/scripts/lxdialog/.menubox.o.cmd
--- linux-2.5.21/scripts/lxdialog/.menubox.o.cmd	1970-01-01 01:00:00.000000000 +0100
+++ linux/scripts/lxdialog/.menubox.o.cmd	2002-06-13 12:50:04.000000000
diff -urN linux-2.5.21/scripts/lxdialog/.msgbox.o.cmd 
linux/scripts/lxdialog/.msgbox.o.cmd
--- linux-2.5.21/scripts/lxdialog/.msgbox.o.cmd	1970-01-01 01:00:00.000000000 +0100
+++ linux/scripts/lxdialog/.msgbox.o.cmd	2002-06-13 12:50:07.000000000 3.1/include/stdbool.h \
+
diff -urN linux-2.5.21/scripts/lxdialog/.textbox.o.cmd 
linux/scripts/lxdialog/.textbox.o.cmd
--- linux-2.5.21/scripts/lxdialog/.textbox.o.cmd	1970-01-01 01:00:00.000000000 +0100
+++ linux/scripts/lxdialog/.textbox.o.cmd	2002-06-13 12:50:05.000000000 +0200
@@ -0,0 +1,48 @@
+cmd_textbox.o := gcc -Wp,-MD,.textbox.o.d -Wall -Wstrict-prototypes -O2 
-fomit-frame-pointer -DLOCALE  -I/usr/include/ncurses -DCURSES_LOC="<ncurses.h>" 
-c -o textbox.o textbox.c

diff -urN linux-2.5.21/scripts/lxdialog/.yesno.o.cmd 
linux/scripts/lxdialog/.yesno.o.cmd
--- linux-2.5.21/scripts/lxdialog/.yesno.o.cmd	1970-01-01 01:00:00.000000000 +0100
+++ linux/scripts/lxdialog/.yesno.o.cmd	2002-06-13 12:50:06.000000000 +0200
ude/stdbool.h \
+

