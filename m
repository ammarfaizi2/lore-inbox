Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130337AbRAKKby>; Thu, 11 Jan 2001 05:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131085AbRAKKbp>; Thu, 11 Jan 2001 05:31:45 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:13576 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S131081AbRAKKb3>; Thu, 11 Jan 2001 05:31:29 -0500
Message-ID: <3A5D8B79.AD1E161D@Hell.WH8.TU-Dresden.De>
Date: Thu, 11 Jan 2001 11:31:21 +0100
From: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Organization: Dept. Of Computer Science, Dresden University Of Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, de-DE
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Linus Torvalds <torvalds@transmeta.com>, andrea@suse.de,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.1-pre1 breaks XFree 4.0.2 and "w"
In-Reply-To: <3A5C6417.6670FCB7@Hell.WH8.TU-Dresden.De> <20010110181516.X10035@nightmaster.csn.tu-chemnitz.de> <3A5C96BB.96B19DB@Hell.WH8.TU-Dresden.De> <200101110841.AAA01652@penguin.transmeta.com> <3A5D8583.F5F30BD2@Hell.WH8.TU-Dresden.De> <20010111111145.A19584@gruyere.muc.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> Did you have CONFIG_X86_FXSR or CONFIG_X86_RUNTIME_FXSR enabled when it
> worked?
> 
> If not it probably means that the XServer is testing OSFXSR and the branch
> that handles it doesn't work.

--- linux-2.4.0/.config Thu Jan 11 11:22:11 2001
+++ linux-2.4.1/.config Thu Jan 11 11:24:56 2001
@@ -27,7 +27,7 @@
 # CONFIG_M586TSC is not set
 # CONFIG_M586MMX is not set
 # CONFIG_M686 is not set
-# CONFIG_M686FXSR is not set
+# CONFIG_MPENTIUMIII is not set
 # CONFIG_MPENTIUM4 is not set
 # CONFIG_MK6 is not set
 CONFIG_MK7=y

The only difference between the two .config files is shown above.
2.4.0 works, 2.4.1 doesn't. And it's not just the X server acting funny.

-Udo.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
