Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129458AbQLXAY5>; Sat, 23 Dec 2000 19:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129595AbQLXAYs>; Sat, 23 Dec 2000 19:24:48 -0500
Received: from d-dialin-693.addcom.de ([62.96.161.221]:40174 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S129458AbQLXAYo>; Sat, 23 Dec 2000 19:24:44 -0500
Date: Sat, 23 Dec 2000 19:12:32 +0100 (CET)
From: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
To: ebi4 <ebi4@ozob.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: test13-pre4 fails to compile
In-Reply-To: <Pine.LNX.3.96.1001223111028.32426B-100000@ozob.net>
Message-ID: <Pine.LNX.4.30.0012231911100.1123-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 23 Dec 2000, ebi4 wrote:

> ld: cannot open drivers/ieee1394/ieee1394.a: No such file or directory
> make: *** [vmlinux] Error 1

I sent the following patch to Linus already. It should fix the problem.

--Kai


diff -ur linux-2.4.0-test13-pre3/drivers/ieee1394/Makefile linux-2.4.0-test13-pre3.1/drivers/ieee1394/Makefile
--- linux-2.4.0-test13-pre3/drivers/ieee1394/Makefile	Tue Dec 19 21:44:15 2000
+++ linux-2.4.0-test13-pre3.1/drivers/ieee1394/Makefile	Wed Dec 20 12:42:07 2000
@@ -23,7 +23,8 @@
 obj-$(CONFIG_IEEE1394_VIDEO1394) += video1394.o
 obj-$(CONFIG_IEEE1394_RAWIO) += raw1394.o

+include $(TOPDIR)/Rules.make
+
 ieee1394.o: $(ieee1394-objs)
 	$(LD) -r -o $@ $(ieee1394-objs)

-include $(TOPDIR)/Rules.make




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
